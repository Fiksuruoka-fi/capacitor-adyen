---
name: capacitor-adyen-add-component
description: Add a new Adyen payment method component (Google Pay, Apple Pay, iDEAL, Klarna, PayPal, etc.) to the @foodello/capacitor-adyen plugin source. Use when contributing a new payment method, adding platform support for an existing component, or extending the plugin with a new native payment sheet.
---

# Adding a New Payment Method Component

This skill is for contributors working inside the plugin source — not for consumer app code.

Before starting: check the `## Roadmap` section of README.md to see which components are planned.

## Step 0 — Research the target component

Fetch the Adyen docs for your component:

- iOS: `https://docs.adyen.com/payment-methods/<name>/ios-component/`
- Android: `https://docs.adyen.com/payment-methods/<name>/android-component/`

Check `Package.swift` — confirm whether the required Adyen iOS module is already listed. Common modules beyond what's already there: `AdyenComponents`, `AdyenActions`, `AdyenDropIn`.

Check `android/build.gradle` for the Android Gradle dependency.

---

## Step 1 — TypeScript definitions

Create `src/definitions/components/<name>.ts`:

```typescript
import type { BaseAdyenComponentOptions } from '..';
import type { ComponentViewOptions, FormComponentStyle } from '../styles';

export interface <Name>ComponentOptions extends BaseAdyenComponentOptions {
  configuration?: <Name>ComponentConfiguration;
  style?: FormComponentStyle;
  viewOptions?: ComponentViewOptions;
}

export interface <Name>ComponentConfiguration {
  // Mirror fields from the Adyen SDK docs
}

export interface <Name>ComponentMethods {
  present<Name>Component(options?: <Name>ComponentOptions): Promise<void>;
}

export interface <Name>ComponentEvents {
  on<Name>Submit: (data: <Name>SubmitEventData) => void;
  // add other events as needed
}

export interface <Name>SubmitEventData {
  // fields from the native SDK callback
}
```

Wire into `src/definitions/index.ts`:

```typescript
// Extend AdyenEvents:
export interface AdyenEvents extends BaseEvents, CardComponentEvents, <Name>ComponentEvents {}

// Extend AdyenPlugin:
export interface AdyenPlugin extends BaseAdyenPlugin, CardComponentMethods, <Name>ComponentMethods {}

// Re-export:
export * from './components/<name>';
```

---

## Step 2 — Web stub

Add to `src/web.ts`:

```typescript
async present<Name>Component(): Promise<void> {
  throw this.unavailable('method is not available on web, use Adyen Web SDK directly.');
}
```

Every method exposed in `AdyenPlugin` must have a stub here or the TypeScript compiler will error.

---

## Step 3 — iOS

### 3a. Register the plugin method — CRITICAL

`ios/Sources/AdyenPlugin/AdyenPlugin.swift`, add to `pluginMethods`:

```swift
CAPPluginMethod(name: "present<Name>Component", returnType: CAPPluginReturnPromise),
```

**This array is the authoritative list of callable methods. If a method is missing here, JavaScript calls to it return nothing — no error, no rejection, just silence.**

### 3b. Add the `@objc` handler

In `AdyenPlugin.swift`:

```swift
@objc public func present<Name>Component(_ call: CAPPluginCall) {
    guard let implementation = self.implementation else {
        call.reject("Adyen not initialized")
        return
    }
    let amount = call.getInt("amount")
    let countryCode = call.getString("countryCode")
    let currencyCode = call.getString("currencyCode")
    let viewOptions = call.getObject("viewOptions")
    let configuration = call.getObject("configuration")

    DispatchQueue.main.async { [weak self] in
        do {
            let vc = try implementation.create<Name>Component(
                amount: amount,
                countryCode: countryCode,
                currencyCode: currencyCode,
                configuration: configuration
            )
            self?.presentWithTracking(vc, viewOptions: viewOptions) {
                call.resolve()
            }
        } catch {
            call.reject(error.localizedDescription)
        }
    }
}
```

### 3c. Component class

`ios/Sources/AdyenPlugin/Components/<Name>/<Name>Component.swift`:

```swift
internal class Adyen<Name>Component {
    private weak var bridge: AdyenBridge?

    init(bridge: AdyenBridge) { self.bridge = bridge }

    func create(
        amount: Int?,
        countryCode: String?,
        currencyCode: String?,
        configuration: [String: Any]? = nil
    ) throws -> UIViewController {
        guard let bridge = bridge,
              let paymentMethods = bridge.currentPaymentMethods,
              let paymentMethod = paymentMethods.paymentMethod(ofType: <Name>PaymentMethod.self) else {
            throw AdyenError.paymentMethodNotFound
        }

        let payment = createPaymentIfNeeded(
            amount: amount,
            currencyCode: currencyCode,
            countryCode: countryCode
        )
        let adyenContext = try bridge.createAdyenContext(with: payment)

        var componentConfig = <Name>Component.Configuration()
        // Apply fields from `configuration` dict here

        let component = <Name>Component(
            paymentMethod: paymentMethod,
            context: adyenContext,
            configuration: componentConfig
        )
        bridge.setActivePaymentComponent(component)
        return component.viewController
    }

    private func createPaymentIfNeeded(
        amount: Int?, currencyCode: String?, countryCode: String?
    ) -> Payment? {
        guard let value = amount, let currency = currencyCode, let country = countryCode else { return nil }
        return Payment(amount: Amount(value: value, currencyCode: currency), countryCode: country)
    }
}
```

### 3d. Wire into AdyenBridge

`ios/Sources/AdyenPlugin/Core/AdyenBridge.swift`:

```swift
private lazy var <name>Component = Adyen<Name>Component(bridge: self)

public func create<Name>Component(
    amount: Int?,
    countryCode: String?,
    currencyCode: String?,
    configuration: [String: Any]? = nil
) throws -> UIViewController {
    return try <name>Component.create(
        amount: amount,
        countryCode: countryCode,
        currencyCode: currencyCode,
        configuration: configuration
    )
}
```

### 3e. Add iOS module dependency if needed

`Package.swift`:

```swift
.product(name: "Adyen<Module>", package: "adyen-ios"),
```

`FoodelloCapacitorAdyen.podspec`:

```ruby
s.dependency 'Adyen/<Module>', '~> 5.20.1'
```

---

## Step 4 — Android

### 4a. Plugin method

`android/src/main/java/com/foodello/adyen/AdyenPlugin.kt`:

```kotlin
@PluginMethod
fun present<Name>Component(call: PluginCall) {
    val amount = call.getInt("amount")
    val countryCode = call.getString("countryCode")
    val currencyCode = call.getString("currencyCode")
    val configuration = call.getObject("configuration")
    val style = call.getObject("style")
    val viewOptions = call.getObject("viewOptions")

    try {
        implementation.present<Name>Component(
            amount, countryCode, currencyCode, configuration, style, viewOptions
        )
        call.resolve()
    } catch (e: Exception) {
        call.reject("Failed to present <name> component: ${e.message}")
    }
}
```

### 4b. Implementation method

`android/src/main/java/com/foodello/adyen/AdyenImplementation.kt`:

```kotlin
fun present<Name>Component(
    amount: Int?, countryCode: String?, currencyCode: String?,
    configuration: JSObject?, style: JSObject?, viewOptions: JSObject?
) {
    activity.runOnUiThread {
        val config = checkoutConfiguration
            ?: throw IllegalStateException("Adyen not initialized")
        val methods = paymentMethods
            ?: throw IllegalStateException("Payment methods not set")

        val paymentMethod = methods.paymentMethods
            ?.find { it.type == "<adyen-type-string>" }
            ?: throw IllegalStateException("<Name> payment method not found")

        val comp = Adyen<Name>Component(activity, config, plugin)
        val component = comp.create(amount, currencyCode, paymentMethod, countryCode, configuration)
        comp.present(component, style, viewOptions)
        active<Name>Component = comp
    }
}
```

### 4c. Component class

`android/src/main/java/com/foodello/adyen/components/Adyen<Name>Component.kt`

Use `AdyenCardComponent.kt` as the structural template. Key points:

- Implement `ComponentCallback<<Name>ComponentState>` with `onSubmit`, `onError`, `onAdditionalDetails`, and `onStateChanged`
- In `onSubmit`, fire both `adyenPlugin.onEvent("onSubmit", ...)` and `adyenPlugin.onEvent("on<Name>Submit", ...)`
- Build presentation UI using `BottomSheetDialog` (same pattern as card) or use the platform's native sheet if the SDK provides one
- Call `adyenPlugin.onEvent("onShow", JSObject())` when the sheet appears
- Call `adyenPlugin.onEvent("onHide", ...)` in the `setOnDismissListener`

---

## Step 5 — Build and verify

```bash
# Web / TypeScript
npm run build

# iOS
npm run verify:ios

# Android
npm run verify:android

# Lint
npm run lint
```

All three must pass before opening a PR.

---

## Step 6 — Docs and changelog

1. Remove the component from the `## Roadmap` list in `README.md` and add it to the `## Supported Components` table.
2. Add an entry to `CHANGELOG.md` with the appropriate semver bump.
3. Run `npm run docs` to regenerate the API reference section in `README.md`.

---

## Mistake reference

| Mistake | Consequence |
|---|---|
| Method not in iOS `pluginMethods` array | JS call returns nothing — no error, silent failure |
| No web stub in `web.ts` | TypeScript compile error |
| `configuration` dict contains a function | Silently stripped by `JSON.parse(JSON.stringify(...))` in `Card.tsx` |
| New Adyen iOS module not in `Package.swift` AND `podspec` | Build fails depending on which package manager the consumer uses |
| `setCurrentPaymentMethods` not called before presenting | `paymentMethodNotFound` / `IllegalStateException` at runtime |
| Android `Activity` instead of `ComponentActivity` | DropIn launcher crash |
