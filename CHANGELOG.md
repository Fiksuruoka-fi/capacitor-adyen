# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

### [8.0.0](https://github.com/Fiksuruoka-fi/capacitor-adyen/compare/v7.0.0...v7.0.1) (2025-10-07)

#### Breaking changes

- Bump @capacitor/core, @capacitor/ios, @capacitor/android, and
@capacitor/cli to v8
- Bump peer dependency @capacitor/core from >=7.0.0 to >=8.0.0
- Bump peer dependency @adyen/adyen-web from ^6.22.0 to ^6.33.0
- Update capacitor-swift-pm from v7 to v8 in Package.swift

#### Chore

- Add baseline-browser-mapping to devDependencies
- Add explicit return types to Card.tsx (mount, unmount, render)
- Fix import ordering and formatting (eslint/prettier)
- Migrate Tailwind v4 classes in example app (bg-gradient-to-br →
bg-linear-to-br, min-h-[200px] → min-h-50)

**iOS**

- Raise deployment target from iOS 14 to iOS 15 (SPM and CocoaPods)
- Bump Adyen iOS SDK from 5.20.1 to 5.23.1
- Rename SPM package from CapacitorAdyen to FoodelloCapacitorAdyen to
match podspec

**Android**

- Bump Adyen Android SDK from 5.14.0 to 5.17.0
- Bump AGP from 8.7.2 to 8.13.0, Kotlin from 2.2.0 to 2.2.20
- Bump Gradle wrapper to 8.14.3
- Raise minSdk from 23 to 24, compileSdk/targetSdk from 35 to 36
- Bump AppCompat from 1.7.0 to 1.7.1, AndroidX JUnit to 1.3.0,
Espresso to 3.7.0
- Migrate kotlinOptions.jvmTarget to kotlin.compilerOptions.jvmTarget
(Kotlin DSL)

#### Bug fixes

- Fix saved card horizontal overflow — masked card number and "Change"
button no longer overflow the container
- Shorten masked card display from `•••• •••• •••• 1234` to `•••• 1234`
(industry-standard format)
- Fix example ButtonProps type to use ButtonHTMLAttributes

### Security

- Override lodash and lodash-es to 4.18.1 to fix CVE-2026-4800 (code
injection via _.template) and prototype pollution in _.unset/_.omit
(transitive via prettier-plugin-java → java-parser → chevrotain)


### [7.0.1](https://github.com/Fiksuruoka-fi/capacitor-adyen/compare/v7.0.0...v7.0.1) (2025-10-07)


### Bug Fixes

* fixes publish to npm ([ec0298b](https://github.com/Fiksuruoka-fi/capacitor-adyen/commit/ec0298b54122e01d83010c917a8a16a8b41bbdb4))
* **ios:** adds missing podspec ([9d9656d](https://github.com/Fiksuruoka-fi/capacitor-adyen/commit/9d9656d97c3754f19cde2af725ed3ecc123dd37c))

## 7.0.0 (2025-10-07)

Initial release to follow supported Capacitor version numbering.

### Supported SDK versions

- Adyen Web (JavaScript): ^6.22.0 (validated against 6.22.x)
- Adyen iOS Components: ^5.20.1 (validated against 5.20.1)
- Adyen Android Components: ^5.20.1 (validated against 5.20.1)
- Capacitor: ^7.x.x (validated against 7.4.3)

### Features

- adds Android and iOS Card component support
- adds usage examples for the Card component support
