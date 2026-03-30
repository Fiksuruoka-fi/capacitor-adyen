# AGENTS.md — capacitor-adyen

This file gives AI coding agents (Claude Code, Codex, Cursor, etc.) the context they need to work effectively in this repository.

---

## What This Is

`@foodello/capacitor-adyen` is a Capacitor.js plugin that bridges the **Adyen iOS and Android native SDKs** into hybrid Ionic/Capacitor apps. It also ships an **extended Adyen Web component** (`Card`) that transparently presents the native bottom sheet on device while falling back to the standard Adyen Web UI in a browser.

**The core pattern**: the web layer owns the payment lifecycle (state, events, `onSubmit` callback), but on native platforms the *rendering* is delegated to the platform SDK via the `Adyen` Capacitor plugin bridge.

---

## Repository Layout

```
src/                          TypeScript / Preact web layer
  bridge.ts                   registerPlugin call — Adyen plugin singleton
  web.ts                      Web stub (throws "use Adyen Web SDK directly")
  index.ts                    Public exports
  definitions/
    index.ts                  All shared TS interfaces and types
    components/card.ts        Card-specific interfaces (options, events, config)
    styles.ts                 FormComponentStyle, TextStyleDefinition, ButtonStyleDefinition, etc.
  components/card/
    Card.tsx                  Extended AdyenCardComponent — main integration point
    CardDetails.tsx           Preact UI for native card state display (loading / submitted)
    styles.scss               Styles for CardDetails

ios/Sources/AdyenPlugin/
  AdyenPlugin.swift           CAPPlugin — method registration + load() init
  Core/AdyenBridge.swift      Holds APIContext, PaymentMethods, delegates
  Core/AdyenContext.swift     AdyenContext factory
  Core/AdyenError.swift       Error enum
  Components/Card/
    CardComponent.swift       Creates and configures iOS CardComponent, applies style
  Delegates/
    CardComponentDelegate.swift
    PaymentComponentDelegate.swift
    ViewControllerDelegate.swift
  Serialization/
    CardBrandSerializer.swift
    PaymentDataSerializer.swift
  Styling/
    StyleFactory.swift        Maps JS style dict → Adyen FormStyle
    StyleExtensions.swift
    ViewController.swift      Presentation helpers (applyNavigationPresentationConfiguration)

android/src/main/java/com/foodello/adyen/
  AdyenPlugin.kt              @CapacitorPlugin — method dispatch
  AdyenImplementation.kt      Init, setPaymentMethods, presentCardComponent
  components/
    AdyenCardComponent.kt     Creates CardComponent, builds BottomSheetDialog, callbacks
  FormStyleApplier.kt         Applies JS style dict to AdyenComponentView
  SheetChromeApplier.kt       Styles the bottom sheet header + close button

example/src/
  App.tsx                     Full usage example — React + Adyen Web + this plugin
  config/env.ts               Env-driven config (clientKey, environment, locale)
```

---

## Key Concepts

### Plugin Initialization

Config lives in `capacitor.config.json` (or `.ts`) under the `Adyen` key:

```json
{
  "plugins": {
    "Adyen": {
      "clientKey": "test_xxxxx",
      "environment": "test",
      "enableAnalytics": false
    }
  }
}
```

Valid environments: `"test"`, `"liveApse"`, `"liveUs"`, `"liveEu"`, `"liveAu"`.

Both `clientKey` and `environment` are **required**. If either is missing, the iOS plugin silently skips init (logs `❌ Missing …`) and all calls will reject with `"Adyen not initialized"`.

### Payment Flow

1. **Fetch payment methods** from your backend (`/paymentMethods` Adyen API)
2. `Adyen.setCurrentPaymentMethods({ paymentMethodsJson })` — stores methods in native SDK
3. `Adyen.presentCardComponent(options)` — opens native sheet
4. Listen to `onSubmit` → forward `data.paymentMethod` to your backend `/payments`
5. `Adyen.hideComponent()` after processing (or on `onHide`)

### Card.tsx — the bridge component

`Card` extends `@adyen/adyen-web`'s `AdyenCardComponent`. When `Capacitor.isNativePlatform()` is `true`, it:

- Calls `Adyen.presentCardComponent(options)` on `mount()`
- Renders `<CardDetails>` (Preact) instead of the normal Adyen form
- Forwards `onCardSubmit` / `onSubmit` native events back into Adyen Web state
- Cleans up listeners on `unmount()`

`testNativePresentation: true` forces native path on browser (for UI dev).  
`isDev: true` sets `window.adyenCard` for debugging and enables consola output.

### Event Names

| Event | Payload | Direction |
|---|---|---|
| `onSubmit` | `PaymentSubmitEventData` | Native → JS |
| `onCardSubmit` | `CardSubmitEventData` (lastFour, finalBIN) | Native → JS |
| `onCardChange` | `CardChangeEventData` | Native → JS |
| `onAdditionalDetails` | raw object | Native → JS |
| `onError` | `{ message: string }` | Native → JS |
| `onShow` | — | Native → JS |
| `onHide` | `{ reason: 'user_gesture' }` | Native → JS |

---

## Build System

### Web layer

```bash
npm run build          # clean → docs → tsc → rollup → dist/
npm run watch          # tsc --watch (no rollup)
npm run docs           # typedoc + inject API into README
```

Rollup bundles `dist/plugin.js` (IIFE), `dist/plugin.cjs.js`, and `dist/esm/` tree.  
PostCSS + sass-embedded compiles `src/components/card/styles.scss` → `dist/esm/styles.css`.

### iOS

```bash
npm run verify:ios
# expands to:
xcodebuild -scheme CapacitorAdyen -destination generic/platform=iOS
```

The iOS target is a Swift Package (SPM). Dependencies are declared in `Package.swift`:
- `capacitor-swift-pm` ≥ 7.0.0
- `adyen-ios` ~> 5.20.1 (pulls `Adyen`, `AdyenComponents`, `AdyenCard`)

CocoaPods is also supported via `FoodelloCapacitorAdyen.podspec` (mirrors same deps).

Minimum deployment target: **iOS 14**.

### Android

```bash
npm run verify:android
# expands to:
cd android && ./gradlew clean build test && cd ..
```

Gradle build. The Adyen Android SDK (v5.x) is pulled as a Gradle dependency in `android/build.gradle`.  
`AdyenPlugin.kt` requires `ComponentActivity` (AndroidX) — `Activity` alone won't work for DropIn launcher registration.

---

## Linting / Formatting

```bash
npm run lint           # eslint + prettier --check + swiftlint lint
npm run fmt            # eslint --fix + prettier --write + swiftlint --fix --format
```

SwiftLint config: `@ionic/swiftlint-config`.  
Prettier config: `@ionic/prettier-config` (covers `.ts`, `.js`, `.css`, `.html`, `.java`).  
ESLint config: `@ionic/eslint-config/recommended`.

---

## Common Gotchas

1. **`setCurrentPaymentMethods` must be called before `presentCardComponent`** — both iOS and Android throw if `paymentMethods` is null.

2. **Android requires `ComponentActivity`** — the DropIn launcher (`registerForDropInResult`) uses the AndroidX Activity Result API. If the app's main activity doesn't extend `ComponentActivity`, DropIn will crash.

3. **CSS must be imported by the consumer** — the plugin emits `dist/esm/styles.css` but does not auto-inject it. Apps must import:
   ```ts
   import '@adyen/adyen-web/styles/adyen.css';
   import '@foodello/capacitor-adyen/dist/esm/styles.css';
   ```

4. **`CardComponentOptions` must be JSON-serializable** — `Card.tsx` runs `JSON.parse(JSON.stringify(options))` before calling the native bridge. Functions in `componentOptions` are stripped.

5. **`showsSubmitButton` on Android maps to `isSubmitButtonVisible`** — different field name between platforms. `CardComponentOptions.configuration.showsSubmitButton` (JS) → `isSubmitButtonVisible` on Android's `CheckoutConfiguration`.

6. **Environment strings are case-sensitive on Android** — `"test"` works; `"Test"` falls back silently to `Environment.TEST`. On iOS, `AdyenEnvironment.from(string:)` does a lowercased comparison.

7. **The DropIn component on Android is alpha** — `AdyenDropInComponent.kt` and `AdyenDropInService.kt` exist but `startPayment()` is not exposed in the public TypeScript interface. Don't use it for production until the interface is stabilized.

8. **`destroyComponent` is iOS-missing** — declared in `AdyenPlugin` iOS but not wired in `pluginMethods`. Call `hideComponent` instead.

---

## Testing

No automated JavaScript tests exist. Verification is:

- **Web**: `npm run build` (TypeScript compile + rollup)  
- **iOS**: `xcodebuild` scheme `CapacitorAdyen`  
- **Android**: `./gradlew clean build test`

The `example/` app is the integration test harness. Run it against a real Adyen test merchant account.

---

## Adding a New Payment Method Component

To add, e.g., Google Pay:

1. **TypeScript**: Add `GooglePayComponentOptions`, `GooglePayComponentMethods`, and `GooglePayComponentEvents` in `src/definitions/components/googlepay.ts`. Re-export from `src/definitions/index.ts` and extend `AdyenPlugin`.
2. **iOS**: Add a `GooglePayComponent.swift` in `ios/Sources/AdyenPlugin/Components/`. Register the method in `AdyenPlugin.swift`'s `pluginMethods` array and add the `@objc` method.
3. **Android**: Add `AdyenGooglePayComponent.kt`, wire it in `AdyenPlugin.kt` with `@PluginMethod`, and implement in `AdyenImplementation.kt`.
4. **Web stub**: Add the method to `web.ts` throwing `unavailable(...)`.
5. **Update `CHANGELOG.md`** with semver bump.

---

## Skills

Three agent skills are shipped with this repository under `.agents/skills/`. They follow the [agentskills.io](https://agentskills.io) spec and are automatically discovered by Codex, Claude Code, and other compatible agents.

| Skill | Trigger |
|---|---|
| `capacitor-adyen-setup` | Installing or configuring the plugin for the first time |
| `capacitor-adyen-payment-flow` | Implementing the payment lifecycle in a consumer app |
| `capacitor-adyen-add-component` | Contributing a new payment method to the plugin source |
