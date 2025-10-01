<div align="center">

[![npm version](https://img.shields.io/npm/v/@foodello/capacitor-adyen.svg?style=flat)](https://www.npmjs.com/package/@foodello/capacitor-adyen)
[![npm downloads](https://img.shields.io/npm/dm/@foodello/capacitor-adyen.svg?style=flat)](https://www.npmjs.com/package/@foodello/capacitor-adyen)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub issues](https://img.shields.io/github/issues/Fiksuruoka-fi/capacitor-adyen.svg?style=flat)](https://github.com/Fiksuruoka-fi/capacitor-adyen/issues)
[![GitHub stars](https://img.shields.io/github/stars/Fiksuruoka-fi/capacitor-adyen.svg?style=flat)](https://github.com/Fiksuruoka-fi/capacitor-adyen/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/Fiksuruoka-fi/capacitor-adyen.svg?style=flat)](https://github.com/Fiksuruoka-fi/capacitor-adyen/network)

[![Adyen iOS SDK](https://img.shields.io/badge/Adyen%20iOS-^v5.x.x-000000?style=flat&logo=ios&logoColor=white)](https://github.com/Adyen/adyen-ios/releases)
[![Adyen Android SDK](https://img.shields.io/badge/Adyen%20Android-^v5.x.x-3DDC84?style=flat&logo=android&logoColor=white)](https://github.com/Adyen/adyen-android/releases)

</div>

<div align="center">
  <a href="https://www.adyen.com/">
    <img src="./.github/raw/main/images/logo.png" alt="Adyen x Capacitor.js" width="50%" style="border-radius: 16px;" />
  </a>
  <h1>Adyen SDK integration with Capacitor.js</h1>
</div>

## Supported Components

| Component | Since Version | Platform Support                                                                                                                                                                    |
| --------- | ------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Card**  | `v7.0.0`      | ![iOS](https://img.shields.io/badge/iOS-000000?style=flat&logo=ios&logoColor=white) ![Android](https://img.shields.io/badge/Android-3DDC84?style=flat&logo=android&logoColor=white) |

## Roadmap

- [ ] **DropIn** component support - [iOS](https://docs.adyen.com/online-payments/build-your-integration/advanced-flow/?platform=iOS&integration=Drop-in) / [Android](https://docs.adyen.com/online-payments/build-your-integration/advanced-flow/?platform=Android&integration=Drop-in)
- [ ] **Google Pay** component support - [Android](https://docs.adyen.com/payment-methods/google-pay/android-component/)
- [ ] **Apple Pay** component support - [iOS](https://docs.adyen.com/payment-methods/apple-pay/ios-component/)
- [ ] **PayPal** component support - [iOS](https://docs.adyen.com/payment-methods/paypal/ios-component/) / [Android](https://docs.adyen.com/payment-methods/paypal/android-component/)
- [ ] **iDEAL** component support - [iOS](https://docs.adyen.com/payment-methods/ideal/ios-component/) / [Android](https://docs.adyen.com/payment-methods/ideal/android-component/)
- [ ] **Klarna** component support - [iOS](https://docs.adyen.com/payment-methods/klarna/ios-component/) / [Android](https://docs.adyen.com/payment-methods/klarna/android-component/)
- [ ] **3D Secure 2** enhanced support - [iOS](https://docs.adyen.com/online-payments/3d-secure/native-3ds2/?platform=iOS) / [Android](https://docs.adyen.com/online-payments/3d-secure/native-3ds2/?platform=Android)

## Install

```bash
# npm
npm install capacitor-adyen

# yarn
yarn add @foodello/capacitor-adyen

# pnpm
pnpm add @foodello/capacitor-adyen

# sync native projects
npx cap sync
```

## Usage

Define `Adyen` plugin configuration in `capacitor.config.json`:

```json
{
  "plugins": {
    "Adyen": {
      "componentsEnvironment": "test", // or "live"
      "clientKey": "your-adyen-client-key",
      "enableAnalytics": true // optional, defaults to false
    }
  }
}
```

Then all components require [payment methods](https://docs.adyen.com/api-explorer/Checkout/latest/post/paymentMethods) to be set before presenting the component:

```typescript
import { Adyen } from '@foodello/capacitor-adyen';

const paymentMethodsJson = await fetchPaymentMethodsFromYourBackend();
await Adyen.setCurrentPaymentMethods({ paymentMethodsJson });
```

After that you can present any of the supported components, for example a Card component:

```typescript
await Adyen.presentCardComponent();
```

To react to component events with your code, add listeners:

```typescript
import { Adyen, PaymentSubmitEventData } from '@foodello/capacitor-adyen';
const listener = await Adyen.addListener('onSubmit', (data: PaymentSubmitEventData) => {
  console.log('Payment submitted:', data);
});
```

### Example on extending Adyen web components

See [example](example) -folder for a full example of how to extend Adyen's web Card component to support native platforms with Capacitor.

## Useful Links

### 🏢 Adyen Resources

- [📚 Adyen Documentation](https://docs.adyen.com/)
- [🔧 Adyen Test Cards](https://docs.adyen.com/development-resources/testing/test-card-numbers)
- [🎨 Design Guidelines](https://docs.adyen.com/online-payments/components/styling/)
- [🔐 Security Best Practices](https://docs.adyen.com/development-resources/security/)

### 🛠️ Developer Tools

- [Adyen Customer Area](https://ca-test.adyen.com/) (Test Environment)
- [Adyen GitHub](https://github.com/Adyen)

<!-- API-REF:START -->

## API Reference

### Table of Contents

- **Plugin Interface**
  - [Interface: AdyenPlugin](#interface-adyenplugin)
  - [Interface: BaseAdyenPlugin](#interface-baseadyenplugin)

- **Card Component**
  - [Interface: CardBrand](#interface-cardbrand)
  - [Interface: CardBrandData](#interface-cardbranddata)
  - [Interface: CardChangeEventData](#interface-cardchangeeventdata)
  - [Interface: CardComponentConfiguration](#interface-cardcomponentconfiguration)
  - [Interface: CardComponentEvents](#interface-cardcomponentevents)
  - [Interface: CardComponentMethods](#interface-cardcomponentmethods)
  - [Interface: CardComponentOptions](#interface-cardcomponentoptions)
  - [Interface: CardSubmitEventData](#interface-cardsubmiteventdata)

- **Configuration**
  - [Interface: AdyenEvents](#interface-adyenevents)
  - [Interface: BaseAdyenComponentOptions](#interface-baseadyencomponentoptions)
  - [Interface: BaseEvents](#interface-baseevents)
  - [Interface: ComponentHideEventData](#interface-componenthideeventdata)
  - [Interface: PaymentErrorEventData](#interface-paymenterroreventdata)
  - [Interface: PaymentMethodsResponse](#interface-paymentmethodsresponse)
  - [Interface: PaymentSubmitEventData](#interface-paymentsubmiteventdata)
  - [Type: ButtonStyleDefinition](#type-buttonstyledefinition)
  - [Type: ComponentViewOptions](#type-componentviewoptions)
  - [Type: FontDefinition](#type-fontdefinition)
  - [Type: FormComponentStyle](#type-formcomponentstyle)
  - [Type: SwitchStyleDefinition](#type-switchstyledefinition)
  - [Type: TextFieldStyleDefinition](#type-textfieldstyledefinition)
  - [Type: TextStyleDefinition](#type-textstyledefinition)

## Interface: AdyenEvents

Defined in: [index.ts:126](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L126)

All available Adyen events

#### Extends

- [`BaseEvents`](#BaseEvents.md).[`CardComponentEvents`](#CardComponentEvents.md)

#### Properties

#### onCardSubmit()

```ts
onCardSubmit: (data) => void;
```

Defined in: [components/card.ts:219](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L219)

Listens for Card component `submit` events.

#### Parameters

##### data

[`CardSubmitEventData`](#CardSubmitEventData.md)

#### Returns

`void`

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
Adyen.addListener('onCardSubmit', async (data) => {
  // Handle the submit event, e.g., show selected card details to the user
  console.log('Card submitted:', data);
});
```

#### Inherited from

[`CardComponentEvents`](#CardComponentEvents.md).[`onCardSubmit`](#CardComponentEvents.md#oncardsubmit)

***

#### onCardChange()

```ts
onCardChange: (data) => void;
```

Defined in: [components/card.ts:234](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L234)

Listens for Card component's `change` events.

#### Parameters

##### data

[`CardChangeEventData`](#CardChangeEventData.md)

#### Returns

`void`

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
Adyen.addListener('onCardChange', async (data) => {
  // Handle the change event, e.g., show selected card details to the user
  console.log('Card changed:', data);
});
```

#### Inherited from

[`CardComponentEvents`](#CardComponentEvents.md).[`onCardChange`](#CardComponentEvents.md#oncardchange)

***

#### onSubmit()

```ts
onSubmit: (data) => void;
```

Defined in: [index.ts:74](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L74)

Listens for payment `submit` events.

#### Parameters

##### data

[`PaymentSubmitEventData`](#PaymentSubmitEventData.md)

#### Returns

`void`

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
Adyen.addListener('onSubmit', async (data) => {
  // Handle the submit event, e.g., send payment data to your server
  console.log('Payment submitted:', data);
});
```

#### Inherited from

[`BaseEvents`](#BaseEvents.md).[`onSubmit`](#BaseEvents.md#onsubmit)

***

#### onError()

```ts
onError: (data) => void;
```

Defined in: [index.ts:89](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L89)

Listens for payment and component `error` events.

#### Parameters

##### data

[`PaymentErrorEventData`](#PaymentErrorEventData.md)

#### Returns

`void`

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
Adyen.addListener('onError', async (data) => {
  // Handle the error event, e.g., show an error message to the user
  console.error('Payment error:', data);
});
```

#### Inherited from

[`BaseEvents`](#BaseEvents.md).[`onError`](#BaseEvents.md#onerror)

***

#### onShow()

```ts
onShow: () => void;
```

Defined in: [index.ts:104](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L104)

Listens for component `present` events.

#### Returns

`void`

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
Adyen.addListener('onShow', async () => {
  // Handle the present event
  console.log('Component presented');
});
```

#### Inherited from

[`BaseEvents`](#BaseEvents.md).[`onShow`](#BaseEvents.md#onshow)

***

#### onHide()

```ts
onHide: (data) => void;
```

Defined in: [index.ts:119](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L119)

Listens for component `dismiss` events.

#### Parameters

##### data

[`ComponentHideEventData`](#ComponentHideEventData.md)

#### Returns

`void`

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
Adyen.addListener('onHide', async (data) => {
  // Handle the hide event, e.g., navigate back or reset the UI
  console.log('Component hidden:', data.reason);
});
```

#### Inherited from

[`BaseEvents`](#BaseEvents.md).[`onHide`](#BaseEvents.md#onhide)

## Interface: AdyenPlugin

Defined in: [index.ts:168](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L168)

#### Extends

- [`BaseAdyenPlugin`](#BaseAdyenPlugin.md).[`CardComponentMethods`](#CardComponentMethods.md)

#### Methods

#### presentCardComponent()

```ts
presentCardComponent(options?): Promise<void>;
```

Defined in: [components/card.ts:201](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L201)

Creates a Adyen Card component for handling card payments.

#### Parameters

##### options?

[`CardComponentOptions`](#CardComponentOptions.md)

Options for creating the card component.

#### Returns

`Promise`\<`void`\>

#### Since

7.0.0

#### See

[https://docs.adyen.com/api-explorer/Checkout/latest/post/paymentMethods](https://docs.adyen.com/api-explorer/Checkout/latest/post/paymentMethods) for more information on how to retrieve available payment methods.

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';

const paymentMethodsResponse: PaymentMethodsResponse = await fetchPaymentMethodsFromYourServer();
await Adyen.presentCardComponent({
  amount: 1000,
  countryCode: 'NL',
  currencyCode: 'EUR',
});

#### Inherited from

[`CardComponentMethods`](#CardComponentMethods.md).[`presentCardComponent`](#CardComponentMethods.md#presentcardcomponent)

***

#### setCurrentPaymentMethods()

```ts
setCurrentPaymentMethods(options): Promise<void>;
```

Defined in: [index.ts:149](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L149)

Set current available payment methods for the Adyen components.

#### Parameters

##### options

Options for creating the card component.

###### paymentMethodsJson

[`PaymentMethodsResponse`](#PaymentMethodsResponse.md)

#### Returns

`Promise`\<`void`\>

A promise that resolves when the card component is created.

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';

const paymentMethodsResponse: PaymentMethodsResponse = await fetchPaymentMethodsFromYourServer();
await Adyen.setCurrentPaymentMethods({
  paymentMethodsJson: paymentMethodsResponse,
});

@see {@link https://docs.adyen.com/api-explorer/Checkout/latest/post/paymentMethods} for more information on how to retrieve available payment methods.

@throws Will throw an error if the Adyen SDK is not initialized or if required parameters are missing.

#### Inherited from

[`BaseAdyenPlugin`](#BaseAdyenPlugin.md).[`setCurrentPaymentMethods`](#BaseAdyenPlugin.md#setcurrentpaymentmethods)

***

#### hideComponent()

```ts
hideComponent(): Promise<void>;
```

Defined in: [index.ts:163](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L163)

Hides the currently presented Adyen component, if any.

#### Returns

`Promise`\<`void`\>

A promise that resolves when the component is hidden.

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
await Adyen.hideComponent();
```

#### Inherited from

[`BaseAdyenPlugin`](#BaseAdyenPlugin.md).[`hideComponent`](#BaseAdyenPlugin.md#hidecomponent)

***

#### addListener()

```ts
addListener<E>(eventName, listener): Promise<PluginListenerHandle>;
```

Defined in: [index.ts:165](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L165)

#### Type Parameters

##### E

`E` *extends* keyof [`AdyenEvents`](#AdyenEvents.md)

#### Parameters

##### eventName

`E`

##### listener

[`AdyenEvents`](#AdyenEvents.md)\[`E`\]

#### Returns

`Promise`\<`PluginListenerHandle`\>

#### Inherited from

[`BaseAdyenPlugin`](#BaseAdyenPlugin.md).[`addListener`](#BaseAdyenPlugin.md#addlistener)

## Interface: BaseAdyenComponentOptions

Defined in: [index.ts:49](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L49)

Base options for Adyen components.

#### Extended by

- [`CardComponentOptions`](#CardComponentOptions.md)

#### Properties

#### amount?

```ts
optional amount: number;
```

Defined in: [index.ts:50](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L50)

***

#### countryCode?

```ts
optional countryCode: string;
```

Defined in: [index.ts:52](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L52)

ISO-3166-1 alpha-2 format

***

#### currencyCode?

```ts
optional currencyCode: string;
```

Defined in: [index.ts:54](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L54)

ISO 4217 currency code

## Interface: BaseAdyenPlugin

Defined in: [index.ts:128](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L128)

#### Extended by

- [`AdyenPlugin`](#AdyenPlugin.md)

#### Methods

#### setCurrentPaymentMethods()

```ts
setCurrentPaymentMethods(options): Promise<void>;
```

Defined in: [index.ts:149](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L149)

Set current available payment methods for the Adyen components.

#### Parameters

##### options

Options for creating the card component.

###### paymentMethodsJson

[`PaymentMethodsResponse`](#PaymentMethodsResponse.md)

#### Returns

`Promise`\<`void`\>

A promise that resolves when the card component is created.

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';

const paymentMethodsResponse: PaymentMethodsResponse = await fetchPaymentMethodsFromYourServer();
await Adyen.setCurrentPaymentMethods({
  paymentMethodsJson: paymentMethodsResponse,
});

@see {@link https://docs.adyen.com/api-explorer/Checkout/latest/post/paymentMethods} for more information on how to retrieve available payment methods.

@throws Will throw an error if the Adyen SDK is not initialized or if required parameters are missing.

***

#### hideComponent()

```ts
hideComponent(): Promise<void>;
```

Defined in: [index.ts:163](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L163)

Hides the currently presented Adyen component, if any.

#### Returns

`Promise`\<`void`\>

A promise that resolves when the component is hidden.

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
await Adyen.hideComponent();
```

***

#### addListener()

```ts
addListener<E>(eventName, listener): Promise<PluginListenerHandle>;
```

Defined in: [index.ts:165](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L165)

#### Type Parameters

##### E

`E` *extends* keyof [`AdyenEvents`](#AdyenEvents.md)

#### Parameters

##### eventName

`E`

##### listener

[`AdyenEvents`](#AdyenEvents.md)\[`E`\]

#### Returns

`Promise`\<`PluginListenerHandle`\>

## Interface: BaseEvents

Defined in: [index.ts:61](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L61)

Base events available for all Adyen components.

#### Extended by

- [`AdyenEvents`](#AdyenEvents.md)

#### Properties

#### onSubmit()

```ts
onSubmit: (data) => void;
```

Defined in: [index.ts:74](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L74)

Listens for payment `submit` events.

#### Parameters

##### data

[`PaymentSubmitEventData`](#PaymentSubmitEventData.md)

#### Returns

`void`

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
Adyen.addListener('onSubmit', async (data) => {
  // Handle the submit event, e.g., send payment data to your server
  console.log('Payment submitted:', data);
});
```

***

#### onError()

```ts
onError: (data) => void;
```

Defined in: [index.ts:89](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L89)

Listens for payment and component `error` events.

#### Parameters

##### data

[`PaymentErrorEventData`](#PaymentErrorEventData.md)

#### Returns

`void`

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
Adyen.addListener('onError', async (data) => {
  // Handle the error event, e.g., show an error message to the user
  console.error('Payment error:', data);
});
```

***

#### onShow()

```ts
onShow: () => void;
```

Defined in: [index.ts:104](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L104)

Listens for component `present` events.

#### Returns

`void`

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
Adyen.addListener('onShow', async () => {
  // Handle the present event
  console.log('Component presented');
});
```

***

#### onHide()

```ts
onHide: (data) => void;
```

Defined in: [index.ts:119](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L119)

Listens for component `dismiss` events.

#### Parameters

##### data

[`ComponentHideEventData`](#ComponentHideEventData.md)

#### Returns

`void`

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
Adyen.addListener('onHide', async (data) => {
  // Handle the hide event, e.g., navigate back or reset the UI
  console.log('Component hidden:', data.reason);
});
```

## Interface: CardBrand

Defined in: [components/card.ts:168](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L168)

#### Properties

#### type

```ts
type: string;
```

Defined in: [components/card.ts:172](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L172)

Card brand name, e.g., 'visa', 'mc', 'amex', etc.

***

#### isSupported

```ts
isSupported: boolean;
```

Defined in: [components/card.ts:177](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L177)

Only on iOS

## Interface: CardBrandData

Defined in: [components/card.ts:155](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L155)

#### Properties

#### cardBrands

```ts
cardBrands: CardBrand | CardBrand[];
```

Defined in: [components/card.ts:160](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L160)

iOS: List of detected card brands
Android: Detected card brand

***

#### primaryBrand

```ts
primaryBrand: CardBrand;
```

Defined in: [components/card.ts:165](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L165)

First card brand in the list (iOS) or the detected brand (Android)

## Interface: CardChangeEventData

Defined in: [components/card.ts:143](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L143)

#### Properties

#### cardBrands?

```ts
optional cardBrands: CardBrandData;
```

Defined in: [components/card.ts:147](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L147)

Card brand information

***

#### cardBIN?

```ts
optional cardBIN: string;
```

Defined in: [components/card.ts:152](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L152)

Bank Identification Number (BIN) of the card

## Interface: CardComponentConfiguration

Defined in: [components/card.ts:29](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L29)

Configuration options specific to the Card component.

#### See

 - [Android](https://docs.adyen.com/payment-methods/cards/android-component/#components-configuration)
 - [iOS](https://docs.adyen.com/payment-methods/cards/ios-component/#optional-configuration)

#### Properties

#### showsHolderNameField?

```ts
optional showsHolderNameField: boolean;
```

Defined in: [components/card.ts:34](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L34)

Display cardholder name input field

#### Default

```ts
false
```

***

#### showsSecurityCodeField?

```ts
optional showsSecurityCodeField: boolean;
```

Defined in: [components/card.ts:40](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L40)

Display security code input field

#### Default

```ts
true
```

***

#### showsStorePaymentMethodField?

```ts
optional showsStorePaymentMethodField: boolean;
```

Defined in: [components/card.ts:46](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L46)

Display store payment method checkbox

#### Default

```ts
false
```

***

#### allowedCardTypes?

```ts
optional allowedCardTypes: string[];
```

Defined in: [components/card.ts:53](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L53)

Supported card types
Same as `supportedCardTypes` on Android

#### Default

`AnyCardPaymentMethod`

***

#### showsSubmitButton?

```ts
optional showsSubmitButton: boolean;
```

Defined in: [components/card.ts:59](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L59)

Display submit button

#### Default

```ts
`true``
```

***

#### shopperReference?

```ts
optional shopperReference: string;
```

Defined in: [components/card.ts:64](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L64)

Your unique shopper reference.

***

#### billingAddress?

```ts
optional billingAddress: {
  requirementPolicy: boolean;
  mode: "none" | "full" | "postalCode";
  countryCodes?: string[];
};
```

Defined in: [components/card.ts:69](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L69)

Billing address configuration

#### requirementPolicy

```ts
requirementPolicy: boolean;
```

Set to `true` to collect the shopper's billing address and mark the fields as required.

##### Default

```ts
false
```

#### mode

```ts
mode: "none" | "full" | "postalCode";
```

Sets which billing address fields to show in the payment form. Possible values:
 - full: show all billing address fields.
 - none: do not show billing address fields.
 - postalCode: show only the postal code field.

##### Default

`none`

#### countryCodes?

```ts
optional countryCodes: string[];
```

Array of allowed country codes for the billing address. For example, `['US', 'CA', 'BR']`.

##### Default

```ts
all countries supported by Adyen
```

***

#### koreanAuthenticationMode?

```ts
optional koreanAuthenticationMode: "show" | "hide" | "auto";
```

Defined in: [components/card.ts:99](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L99)

For Korean cards, sets if security fields show in the payment form. Possible values:
  - show: show the fields.
  - hide: do not show the fields.
  - auto: the field appears for cards issued in South Korea.

#### Default

`auto`

***

#### socialSecurityNumberMode?

```ts
optional socialSecurityNumberMode: "show" | "hide" | "auto";
```

Defined in: [components/card.ts:108](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L108)

For Brazilian cards, sets if the CPF/CNPJ social security number field shows in the payment form. Possible values:
  - show: show the field.
  - hide: do not show the field.
  - auto: the field appears based on the detected card number.

#### Default

`auto`

***

#### localizationParameters?

```ts
optional localizationParameters: {
  languageOverride?: string;
  tableName?: string;
  keySeparator?: string;
};
```

Defined in: [components/card.ts:111](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L111)

Localization parameters for the component

#### languageOverride?

```ts
optional languageOverride: string;
```

ISO 639-1 language code

##### Default

```ts
not-set, defaults to device language
```

#### tableName?

```ts
optional tableName: string;
```

iOS only

##### See

https://adyen.github.io/adyen-ios/5.20.1/documentation/adyen/localization/

#### keySeparator?

```ts
optional keySeparator: string;
```

iOS only

##### See

https://adyen.github.io/adyen-ios/5.20.1/documentation/adyen/localization/

## Interface: CardComponentEvents

Defined in: [components/card.ts:205](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L205)

#### Extended by

- [`AdyenEvents`](#AdyenEvents.md)

#### Properties

#### onCardSubmit()

```ts
onCardSubmit: (data) => void;
```

Defined in: [components/card.ts:219](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L219)

Listens for Card component `submit` events.

#### Parameters

##### data

[`CardSubmitEventData`](#CardSubmitEventData.md)

#### Returns

`void`

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
Adyen.addListener('onCardSubmit', async (data) => {
  // Handle the submit event, e.g., show selected card details to the user
  console.log('Card submitted:', data);
});
```

***

#### onCardChange()

```ts
onCardChange: (data) => void;
```

Defined in: [components/card.ts:234](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L234)

Listens for Card component's `change` events.

#### Parameters

##### data

[`CardChangeEventData`](#CardChangeEventData.md)

#### Returns

`void`

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
Adyen.addListener('onCardChange', async (data) => {
  // Handle the change event, e.g., show selected card details to the user
  console.log('Card changed:', data);
});
```

## Interface: CardComponentMethods

Defined in: [components/card.ts:181](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L181)

#### Extended by

- [`AdyenPlugin`](#AdyenPlugin.md)

#### Methods

#### presentCardComponent()

```ts
presentCardComponent(options?): Promise<void>;
```

Defined in: [components/card.ts:201](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L201)

Creates a Adyen Card component for handling card payments.

#### Parameters

##### options?

[`CardComponentOptions`](#CardComponentOptions.md)

Options for creating the card component.

#### Returns

`Promise`\<`void`\>

#### Since

7.0.0

#### See

[https://docs.adyen.com/api-explorer/Checkout/latest/post/paymentMethods](https://docs.adyen.com/api-explorer/Checkout/latest/post/paymentMethods) for more information on how to retrieve available payment methods.

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';

const paymentMethodsResponse: PaymentMethodsResponse = await fetchPaymentMethodsFromYourServer();
await Adyen.presentCardComponent({
  amount: 1000,
  countryCode: 'NL',
  currencyCode: 'EUR',
});

## Interface: CardComponentOptions

Defined in: [components/card.ts:8](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L8)

Options for creating a Adyen Card component.

#### Extends

- [`BaseAdyenComponentOptions`](#BaseAdyenComponentOptions.md)

#### Properties

#### amount?

```ts
optional amount: number;
```

Defined in: [components/card.ts:10](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L10)

Payment amount in minor currency units (e.g., cents)

#### Overrides

[`BaseAdyenComponentOptions`](#BaseAdyenComponentOptions.md).[`amount`](#BaseAdyenComponentOptions.md#amount)

***

#### countryCode?

```ts
optional countryCode: string;
```

Defined in: [components/card.ts:12](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L12)

ISO 3166-1 alpha-2 country code (e.g., 'US', 'NL')

#### Overrides

[`BaseAdyenComponentOptions`](#BaseAdyenComponentOptions.md).[`countryCode`](#BaseAdyenComponentOptions.md#countrycode)

***

#### currencyCode?

```ts
optional currencyCode: string;
```

Defined in: [components/card.ts:14](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L14)

ISO 4217 currency code (e.g., 'USD', 'EUR')

#### Overrides

[`BaseAdyenComponentOptions`](#BaseAdyenComponentOptions.md).[`currencyCode`](#BaseAdyenComponentOptions.md#currencycode)

***

#### configuration?

```ts
optional configuration: CardComponentConfiguration;
```

Defined in: [components/card.ts:16](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L16)

Card component behaviour configuration

***

#### style?

```ts
optional style: FormComponentStyle;
```

Defined in: [components/card.ts:18](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L18)

Card-specific styling options

***

#### viewOptions?

```ts
optional viewOptions: ComponentViewOptions;
```

Defined in: [components/card.ts:20](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L20)

View options for the component's presentation layout

## Interface: CardSubmitEventData

Defined in: [components/card.ts:131](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L131)

#### Properties

#### lastFour

```ts
lastFour: string;
```

Defined in: [components/card.ts:135](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L135)

Last four digits of the card number

***

#### finalBIN

```ts
finalBIN: string;
```

Defined in: [components/card.ts:140](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L140)

Final Bank Identification Number (BIN) of the card

## Interface: ComponentHideEventData

Defined in: [index.ts:189](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L189)

#### Properties

#### reason

```ts
reason: "user_gesture";
```

Defined in: [index.ts:190](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L190)

## Interface: PaymentErrorEventData

Defined in: [index.ts:184](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L184)

#### Indexable

```ts
[key: string]: any
```

#### Properties

#### message

```ts
message: string;
```

Defined in: [index.ts:186](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L186)

## Interface: PaymentMethodsResponse

Defined in: [index.ts:33](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L33)

JSON response from Adyen API call

#### See

https://docs.adyen.com/api-explorer/Checkout/latest/post/paymentMethods for more information.

#### Properties

#### paymentMethods

```ts
paymentMethods: any[];
```

Defined in: [index.ts:37](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L37)

Array of available payment methods.

***

#### savedPaymentMethods?

```ts
optional savedPaymentMethods: any[];
```

Defined in: [index.ts:42](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L42)

The type of the payment method response, typically "PaymentMethods".

## Interface: PaymentSubmitEventData

Defined in: [index.ts:173](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L173)

#### Properties

#### paymentMethod

```ts
paymentMethod: {
[key: string]: any;
};
```

Defined in: [index.ts:174](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L174)

#### Index Signature

```ts
[key: string]: any
```

***

#### componentType

```ts
componentType: "card";
```

Defined in: [index.ts:177](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L177)

***

#### browserInfo?

```ts
optional browserInfo: {
  userAgent: string;
};
```

Defined in: [index.ts:178](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L178)

#### userAgent

```ts
userAgent: string;
```

***

#### order?

```ts
optional order: {
  orderData: string;
  pspReference: string;
};
```

Defined in: [index.ts:179](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L179)

#### orderData

```ts
orderData: string;
```

#### pspReference

```ts
pspReference: string;
```

***

#### amount?

```ts
optional amount: {
  value: number;
  currency: string;
};
```

Defined in: [index.ts:180](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L180)

#### value

```ts
value: number;
```

#### currency

```ts
currency: string;
```

***

#### storePaymentMethod?

```ts
optional storePaymentMethod: boolean;
```

Defined in: [index.ts:181](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L181)

## Type: ButtonStyleDefinition

```ts
type ButtonStyleDefinition = {
  font?: FontDefinition;
  textColor?: string;
  backgroundColor?: string;
  cornerRadius?: number;
};
```

Defined in: [styles.ts:131](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L131)

Defines the styling for a button. These definitions map to
`FormButtonItemStyle.main` in the iOS SDK. All fields are optional.

#### Properties

#### font?

```ts
optional font: FontDefinition;
```

Defined in: [styles.ts:133](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L133)

Font used for the button's title.

***

#### textColor?

```ts
optional textColor: string;
```

Defined in: [styles.ts:135](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L135)

Colour of the button title text.

***

#### backgroundColor?

```ts
optional backgroundColor: string;
```

Defined in: [styles.ts:137](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L137)

Main background colour of the button.

***

#### cornerRadius?

```ts
optional cornerRadius: number;
```

Defined in: [styles.ts:139](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L139)

Corner radius to round the button's corners.

## Type: ComponentViewOptions

```ts
type ComponentViewOptions = {
  title?: string;
  titleColor?: string;
  titleBackgroundColor?: string;
  titleTintColor?: string;
  showsCloseButton?: boolean;
  closeButtonText?: string;
  ios?: {
     titleColor?: string;
     titleBackgroundColor?: string;
     titleTintColor?: string;
  };
};
```

Defined in: [styles.ts:5](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L5)

Options for customizing the appearance of the component navbar's view.

#### Properties

#### title?

```ts
optional title: string;
```

Defined in: [styles.ts:7](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L7)

Custom text for the title

***

#### titleColor?

```ts
optional titleColor: string;
```

Defined in: [styles.ts:9](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L9)

Color for the title text

***

#### titleBackgroundColor?

```ts
optional titleBackgroundColor: string;
```

Defined in: [styles.ts:11](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L11)

Title bar's background color

***

#### titleTintColor?

```ts
optional titleTintColor: string;
```

Defined in: [styles.ts:13](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L13)

Tint color for buttons in the title bar

***

#### showsCloseButton?

```ts
optional showsCloseButton: boolean;
```

Defined in: [styles.ts:15](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L15)

Whether to show a close button in the title bar

***

#### closeButtonText?

```ts
optional closeButtonText: string;
```

Defined in: [styles.ts:17](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L17)

Custom text for the close button

***

#### ios?

```ts
optional ios: {
  titleColor?: string;
  titleBackgroundColor?: string;
  titleTintColor?: string;
};
```

Defined in: [styles.ts:19](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L19)

iOS specific styling options to override defaults

#### titleColor?

```ts
optional titleColor: string;
```

#### titleBackgroundColor?

```ts
optional titleBackgroundColor: string;
```

#### titleTintColor?

```ts
optional titleTintColor: string;
```

## Type: FontDefinition

```ts
type FontDefinition = {
  size?: number;
  weight?:   | "thin"
     | "light"
     | "regular"
     | "medium"
     | "semibold"
     | "bold"
     | "heavy"
     | "black";
};
```

Defined in: [styles.ts:31](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L31)

Defines a font used within a text element. Both fields are optional; if
omitted, the default system font is used.

#### Properties

#### size?

```ts
optional size: number;
```

Defined in: [styles.ts:33](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L33)

The font size in points.

***

#### weight?

```ts
optional weight: 
  | "thin"
  | "light"
  | "regular"
  | "medium"
  | "semibold"
  | "bold"
  | "heavy"
  | "black";
```

Defined in: [styles.ts:35](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L35)

Weight name matching iOS font weights.

## Type: FormComponentStyle

```ts
type FormComponentStyle = {
  backgroundColor?: string;
  tintColor?: string;
  separatorColor?: string;
  header?: TextStyleDefinition;
  textField?: TextFieldStyleDefinition;
  switch?: SwitchStyleDefinition;
  toggle?: SwitchStyleDefinition;
  hint?: TextStyleDefinition;
  footnote?: TextStyleDefinition;
  linkText?: TextStyleDefinition;
  button?: ButtonStyleDefinition;
  mainButton?: ButtonStyleDefinition;
  secondaryButton?: ButtonStyleDefinition;
};
```

Defined in: [styles.ts:148](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L148)

Combined style configuration for forms. Includes top-level colours and
nested sub-styles for various form elements. All keys are optional and
unknown keys are ignored.

#### Properties

#### backgroundColor?

```ts
optional backgroundColor: string;
```

Defined in: [styles.ts:150](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L150)

Background colour applied to the entire form.

***

#### tintColor?

```ts
optional tintColor: string;
```

Defined in: [styles.ts:152](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L152)

Tint colour applied to accent elements within the form.

***

#### separatorColor?

```ts
optional separatorColor: string;
```

Defined in: [styles.ts:154](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L154)

Colour of separators between form rows.

***

#### header?

```ts
optional header: TextStyleDefinition;
```

Defined in: [styles.ts:157](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L157)

Styling for the header text (section title).

***

#### textField?

```ts
optional textField: TextFieldStyleDefinition;
```

Defined in: [styles.ts:159](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L159)

Styling for text input fields.

***

#### switch?

```ts
optional switch: SwitchStyleDefinition;
```

Defined in: [styles.ts:162](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L162)

Styling for toggle rows. Both `switch` and `toggle` keys are supported.

***

#### toggle?

```ts
optional toggle: SwitchStyleDefinition;
```

Defined in: [styles.ts:163](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L163)

***

#### hint?

```ts
optional hint: TextStyleDefinition;
```

Defined in: [styles.ts:166](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L166)

Styling for hint labels (usually under a field).

***

#### footnote?

```ts
optional footnote: TextStyleDefinition;
```

Defined in: [styles.ts:168](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L168)

Styling for footnote labels at the bottom of the form.

***

#### linkText?

```ts
optional linkText: TextStyleDefinition;
```

Defined in: [styles.ts:170](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L170)

Styling for inline link text in informational messages.

***

#### button?

```ts
optional button: ButtonStyleDefinition;
```

Defined in: [styles.ts:173](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L173)

Styling for the primary action button. You may use either `button` or `mainButton`.

***

#### mainButton?

```ts
optional mainButton: ButtonStyleDefinition;
```

Defined in: [styles.ts:175](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L175)

Styling for the primary action button. Same as `button`.

***

#### secondaryButton?

```ts
optional secondaryButton: ButtonStyleDefinition;
```

Defined in: [styles.ts:177](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L177)

Styling for a secondary action button.

## Type: SwitchStyleDefinition

```ts
type SwitchStyleDefinition = {
  title?: TextStyleDefinition;
  titleColor?: string;
  titleFont?: FontDefinition;
  tintColor?: string;
  separatorColor?: string;
  backgroundColor?: string;
};
```

Defined in: [styles.ts:111](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L111)

Styling for a toggle (switch) row. Supports a title style and colours for
tint, separator and background. This type is used for both the `switch` and
`toggle` keys when specifying form styles.

#### Properties

#### title?

```ts
optional title: TextStyleDefinition;
```

Defined in: [styles.ts:113](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L113)

Styling for the title label next to the toggle.

***

#### titleColor?

```ts
optional titleColor: string;
```

Defined in: [styles.ts:115](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L115)

Colour of the title label (legacy shortcut).

***

#### titleFont?

```ts
optional titleFont: FontDefinition;
```

Defined in: [styles.ts:117](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L117)

Font for the title label (legacy shortcut).

***

#### tintColor?

```ts
optional tintColor: string;
```

Defined in: [styles.ts:119](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L119)

Tint colour of the toggle when turned on.

***

#### separatorColor?

```ts
optional separatorColor: string;
```

Defined in: [styles.ts:121](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L121)

Colour of the separator line beneath the toggle row.

***

#### backgroundColor?

```ts
optional backgroundColor: string;
```

Defined in: [styles.ts:123](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L123)

Background colour of the toggle row.

## Type: TextFieldStyleDefinition

```ts
type TextFieldStyleDefinition = {
  title?: TextStyleDefinition;
  titleColor?: string;
  titleFont?: FontDefinition;
  text?: TextStyleDefinition;
  textColor?: string;
  textFont?: FontDefinition;
  placeholder?: TextStyleDefinition;
  placeholderColor?: string;
  placeholderFont?: FontDefinition;
  icon?: {
     tintColor?: string;
     backgroundColor?: string;
     borderColor?: string;
     borderWidth?: number;
     cornerRadius?: number;
  };
  tintColor?: string;
  separatorColor?: string;
  backgroundColor?: string;
  errorColor?: string;
};
```

Defined in: [styles.ts:59](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L59)

Describes styling for a text field in the form. This includes styling
for the title label, user input text, placeholder text, and trailing icon.

#### Properties

#### title?

```ts
optional title: TextStyleDefinition;
```

Defined in: [styles.ts:61](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L61)

Styling for the field's title label.

***

#### titleColor?

```ts
optional titleColor: string;
```

Defined in: [styles.ts:63](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L63)

Colour of the title label (legacy shortcut).

***

#### titleFont?

```ts
optional titleFont: FontDefinition;
```

Defined in: [styles.ts:65](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L65)

Font used for the title label (legacy shortcut).

***

#### text?

```ts
optional text: TextStyleDefinition;
```

Defined in: [styles.ts:68](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L68)

Styling for the user-entered text.

***

#### textColor?

```ts
optional textColor: string;
```

Defined in: [styles.ts:70](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L70)

Colour of the user-entered text (legacy shortcut).

***

#### textFont?

```ts
optional textFont: FontDefinition;
```

Defined in: [styles.ts:72](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L72)

Font for the user-entered text (legacy shortcut).

***

#### placeholder?

```ts
optional placeholder: TextStyleDefinition;
```

Defined in: [styles.ts:75](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L75)

Styling for the placeholder text.

***

#### placeholderColor?

```ts
optional placeholderColor: string;
```

Defined in: [styles.ts:77](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L77)

Colour of the placeholder text (legacy shortcut).

***

#### placeholderFont?

```ts
optional placeholderFont: FontDefinition;
```

Defined in: [styles.ts:79](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L79)

Font for the placeholder text (legacy shortcut).

***

#### icon?

```ts
optional icon: {
  tintColor?: string;
  backgroundColor?: string;
  borderColor?: string;
  borderWidth?: number;
  cornerRadius?: number;
};
```

Defined in: [styles.ts:82](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L82)

Styling for the trailing icon.

#### tintColor?

```ts
optional tintColor: string;
```

Tint colour of the icon.

#### backgroundColor?

```ts
optional backgroundColor: string;
```

Background colour behind the icon.

#### borderColor?

```ts
optional borderColor: string;
```

Border colour of the icon container.

#### borderWidth?

```ts
optional borderWidth: number;
```

Border width of the icon container.

#### cornerRadius?

```ts
optional cornerRadius: number;
```

Corner radius of the icon container.

***

#### tintColor?

```ts
optional tintColor: string;
```

Defined in: [styles.ts:96](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L96)

Tint colour applied to the text field (cursor/accent).

***

#### separatorColor?

```ts
optional separatorColor: string;
```

Defined in: [styles.ts:98](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L98)

Colour of the separator line beneath the text field.

***

#### backgroundColor?

```ts
optional backgroundColor: string;
```

Defined in: [styles.ts:100](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L100)

Background colour of the entire text field cell.

***

#### errorColor?

```ts
optional errorColor: string;
```

Defined in: [styles.ts:102](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L102)

Colour used to highlight error states.

## Type: TextStyleDefinition

```ts
type TextStyleDefinition = {
  color?: string;
  font?: FontDefinition;
  backgroundColor?: string;
  textAlignment?: "left" | "center" | "right" | "justified" | "natural";
};
```

Defined in: [styles.ts:43](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L43)

Describes common text styling. Applicable to labels, hints, footers, etc.
You can combine colour, font, background and text alignment.

#### Properties

#### color?

```ts
optional color: string;
```

Defined in: [styles.ts:45](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L45)

Hex colour string for the text (e.g. '#FF0000' or 'FFFFFF').

***

#### font?

```ts
optional font: FontDefinition;
```

Defined in: [styles.ts:47](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L47)

Font specification for the text.

***

#### backgroundColor?

```ts
optional backgroundColor: string;
```

Defined in: [styles.ts:49](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L49)

Background colour behind the text.

***

#### textAlignment?

```ts
optional textAlignment: "left" | "center" | "right" | "justified" | "natural";
```

Defined in: [styles.ts:51](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L51)

Alignment for the text within its container.

<!-- API-REF:END -->
