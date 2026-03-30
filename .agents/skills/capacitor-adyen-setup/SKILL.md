---
name: capacitor-adyen-setup
description: Install and configure the @foodello/capacitor-adyen plugin in a Capacitor app. Use when a user is setting up the plugin for the first time, configuring capacitor.config.json, troubleshooting initialization errors, or asking why the plugin isn't working.
---

# Setting Up @foodello/capacitor-adyen

## Install

```bash
npm install @foodello/capacitor-adyen
npx cap sync
```

## Configure — capacitor.config.json

Add the `Adyen` key under `plugins`. All three fields are required — the plugin will silently skip initialization if either `clientKey` or `environment` is missing:

```json
{
  "plugins": {
    "Adyen": {
      "clientKey": "test_XXXXXXXXXXXXXXXXXXXX",
      "environment": "test",
      "enableAnalytics": false
    }
  }
}
```

Valid `environment` values: `"test"` | `"liveApse"` | `"liveUs"` | `"liveEu"` | `"liveAu"`

**Environment strings are case-sensitive.** `"test"` works; `"Test"` silently falls back to TEST on Android and rejects with an error on iOS.

## Import CSS — required, not automatic

The plugin does not self-inject styles. The consumer app must import both:

```ts
import '@adyen/adyen-web/styles/adyen.css';
import '@foodello/capacitor-adyen/dist/esm/styles.css';
```

Missing either import produces unstyled or broken card form UI.

## Peer dependencies

```bash
npm install @adyen/adyen-web@^6.22.0
```

The plugin's `Card` component extends `@adyen/adyen-web`'s `AdyenCardComponent`. Both packages must be installed.

## Verify the plugin loaded

On iOS, check the Xcode console for:
```
✅ Adyen SDK initialized successfully
```

If you see `❌ Missing environment configuration` or `❌ Missing clientKey configuration`, the `capacitor.config.json` values are not reaching the native layer. Check that `npx cap sync` was run after editing the config.

On Android, filter logcat for `AdyenPlugin` or `AdyenImplementation`.

## iOS — Minimum deployment target

iOS 14+. Ensure your app's deployment target is not lower or the build will fail.

## Android — ComponentActivity requirement

The plugin's DropIn component uses the AndroidX Activity Result API. The host app's `MainActivity` must extend `ComponentActivity` (which it does in all current Capacitor templates). Plain `Activity` will cause a crash if DropIn is used.

## Common initialization mistakes

| Symptom | Cause | Fix |
|---|---|---|
| All plugin calls reject with `"Adyen not initialized"` | Missing `clientKey` or `environment` in config | Add both to `capacitor.config.json` and re-sync |
| Card form appears but is unstyled | CSS imports missing | Import both CSS files in app entry point |
| Works in browser, fails on device | `setCurrentPaymentMethods` not called before `presentCardComponent` | Always call `setCurrentPaymentMethods` first on native platforms |
| iOS build fails | `adyen-ios` not resolved | Run `pod install` or let Xcode resolve SPM packages |
| Android build fails | Gradle dependency not resolved | Run `./gradlew clean build` in the `android/` directory |
