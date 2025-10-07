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

- [ ] **Google Pay** component support - [Android](https://docs.adyen.com/payment-methods/google-pay/android-component/)
- [ ] **Apple Pay** component support - [iOS](https://docs.adyen.com/payment-methods/apple-pay/ios-component/)
- [ ] **PayPal** component support - [iOS](https://docs.adyen.com/payment-methods/paypal/ios-component/) / [Android](https://docs.adyen.com/payment-methods/paypal/android-component/)
- [ ] **iDEAL** component support - [iOS](https://docs.adyen.com/payment-methods/ideal/ios-component/) / [Android](https://docs.adyen.com/payment-methods/ideal/android-component/)
- [ ] **Klarna** component support - [iOS](https://docs.adyen.com/payment-methods/klarna/ios-component/) / [Android](https://docs.adyen.com/payment-methods/klarna/android-component/)

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

You can use component from this plugin to extend Adyen web component's behaviour for native platforms.

```typescript
import { Capacitor} from '@capacitor/core';
import { Adyen, type ExtendedCardConfiguration } from '@foodello/capacitor-adyen';
import { AdyenCheckout, Core, type CoreConfiguration, type PaymentResponseData } from '@adyen/adyen-web';

import '@adyen/adyen-web/styles/adyen.css'; // Import Adyen base styles
import '@foodello/capacitor-adyen/dist/esm/styles.css'; // Import plugin styles

// 1. Fetch current payment methods from your backend
const paymentMethodsJson = await fetchPaymentMethodsFromYourBackend();

// 2. Set current payment methods to Adyen plugin if running on native platform
if (Capacitor.isNativePlatform()) {
  await Adyen.setCurrentPaymentMethods({ paymentMethodsJson });
}

// 3. Create Adyen Web Checkout instance
const checkoutCore = CoreConfiguration = {
    countryCode: 'NL',
    locale: 'nl-NL',
    environment: 'test',
    clientKey: 'test_***',
    analytics: { enabled: true },
    paymentMethodsResponse: PAYMENT_METHOD_JSON,
    onPaymentCompleted: (result, component) => {
      console.log('Payment completed', result, component)
    },
    onPaymentFailed: (error, component) => {
      console.error('Payment failed', error, component)
    },
    onError: (error) => {
      console.error(error)
    },
    beforeSubmit: (state, component, actions) => {
      console.log('beforeSubmit', state, component, actions)
    },
    onSubmit: (state, component, actions) => {
      console.log('onSubmit', state, component, actions)
      // Mimic a successful payment submission
      // In real implementation, you would send `state.data` to your server
      // and get the payment response from Adyen's /payments API
      // and then call `actions.handleResponse` with that response.
      // Here we just call it with an empty object to simulate success.
      const response: PaymentResponseData = {
        resultCode: 'Authorised',
        type: 'scheme',
      };
      actions.resolve(response);
    },
    onAdditionalDetails: (state, component, actions) => {
      console.log('onAdditionalDetails', state, component, actions)
    },
    onActionHandled: () => {
      console.log('onActionHandled')
    },
    onChange: (state, component) => {
      console.log('onChange', state, component)
    },
  };

  // 4. Initialize Adyen Checkout instance
  const checkout = await AdyenCheckout(checkoutCore);

  // 5. Create Card component configuration
  const cardConfiguration: ExtendedCardConfiguration = {
    // Your custom configuration here
  };

  // 6. Create Card component instance
  const cardComponent = new CardWithNativeSupport(coreRef.current, cardConfiguration);
  
  // 7. Mount the component to your container
  const wrapper = document.getElementById('card-container');
  cardComponent.mount(wrapper);
```

Supports:
- Card component

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
  - [Interface: ExtendedCardConfiguration](#interface-extendedcardconfiguration)
  - [Interface: NativeCardConfiguration](#interface-nativecardconfiguration)
  - [Interface: NativeCardState](#interface-nativecardstate)

- **Configuration**
  - [Interface: AdditionalDetailsEventData](#interface-additionaldetailseventdata)
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

## Interface: AdditionalDetailsEventData

Defined in: [src/definitions/index.ts:217](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L217)

#### Indexable

```ts
[key: string]: any
```

## Interface: AdyenEvents

Defined in: [src/definitions/index.ts:156](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L156)

All available Adyen events

#### Extends

- [`BaseEvents`](#BaseEvents.md).[`CardComponentEvents`](#CardComponentEvents.md)

#### Properties

#### onCardSubmit()

```ts
onCardSubmit: (data) => void;
```

Defined in: [src/definitions/components/card.ts:221](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L221)

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

Defined in: [src/definitions/components/card.ts:236](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L236)

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

#### onAdditionalDetails()

```ts
onAdditionalDetails: (data) => void;
```

Defined in: [src/definitions/index.ts:90](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L90)

Listens for payment `onAdditionalDetails` events.

#### Parameters

##### data

[`AdditionalDetailsEventData`](#AdditionalDetailsEventData.md)

#### Returns

`void`

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
Adyen.addListener('onAdditionalDetails', async (data) => {
  // Handle the additionalDetails event, e.g., send data to your server
  console.log('Additional details:', data);
});
```

#### Inherited from

[`BaseEvents`](#BaseEvents.md).[`onAdditionalDetails`](#BaseEvents.md#onadditionaldetails)

***

#### onSubmit()

```ts
onSubmit: (data) => void;
```

Defined in: [src/definitions/index.ts:104](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L104)

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

Defined in: [src/definitions/index.ts:119](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L119)

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

Defined in: [src/definitions/index.ts:134](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L134)

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

Defined in: [src/definitions/index.ts:149](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L149)

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

Defined in: [src/definitions/index.ts:212](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L212)

#### Extends

- [`BaseAdyenPlugin`](#BaseAdyenPlugin.md).[`CardComponentMethods`](#CardComponentMethods.md)

#### Methods

#### presentCardComponent()

```ts
presentCardComponent(options?): Promise<void>;
```

Defined in: [src/definitions/components/card.ts:203](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L203)

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

Defined in: [src/definitions/index.ts:179](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L179)

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

Defined in: [src/definitions/index.ts:193](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L193)

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

#### destroyComponent()

```ts
destroyComponent(): Promise<void>;
```

Defined in: [src/definitions/index.ts:207](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L207)

Destroys the currently selected Adyen component, if any.

#### Returns

`Promise`\<`void`\>

A promise that resolves when the component is destroyed.

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
await Adyen.destroyComponent();
```

#### Inherited from

[`BaseAdyenPlugin`](#BaseAdyenPlugin.md).[`destroyComponent`](#BaseAdyenPlugin.md#destroycomponent)

***

#### addListener()

```ts
addListener<E>(eventName, listener): Promise<PluginListenerHandle>;
```

Defined in: [src/definitions/index.ts:209](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L209)

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

Defined in: [src/definitions/index.ts:65](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L65)

Base options for Adyen components.

#### Extended by

- [`CardComponentOptions`](#CardComponentOptions.md)

#### Properties

#### amount?

```ts
optional amount: number;
```

Defined in: [src/definitions/index.ts:66](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L66)

***

#### countryCode?

```ts
optional countryCode: string;
```

Defined in: [src/definitions/index.ts:68](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L68)

ISO-3166-1 alpha-2 format

***

#### currencyCode?

```ts
optional currencyCode: string;
```

Defined in: [src/definitions/index.ts:70](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L70)

ISO 4217 currency code

## Interface: BaseAdyenPlugin

Defined in: [src/definitions/index.ts:158](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L158)

#### Extended by

- [`AdyenPlugin`](#AdyenPlugin.md)

#### Methods

#### setCurrentPaymentMethods()

```ts
setCurrentPaymentMethods(options): Promise<void>;
```

Defined in: [src/definitions/index.ts:179](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L179)

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

Defined in: [src/definitions/index.ts:193](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L193)

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

#### destroyComponent()

```ts
destroyComponent(): Promise<void>;
```

Defined in: [src/definitions/index.ts:207](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L207)

Destroys the currently selected Adyen component, if any.

#### Returns

`Promise`\<`void`\>

A promise that resolves when the component is destroyed.

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
await Adyen.destroyComponent();
```

***

#### addListener()

```ts
addListener<E>(eventName, listener): Promise<PluginListenerHandle>;
```

Defined in: [src/definitions/index.ts:209](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L209)

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

Defined in: [src/definitions/index.ts:77](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L77)

Base events available for all Adyen components.

#### Extended by

- [`AdyenEvents`](#AdyenEvents.md)

#### Properties

#### onAdditionalDetails()

```ts
onAdditionalDetails: (data) => void;
```

Defined in: [src/definitions/index.ts:90](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L90)

Listens for payment `onAdditionalDetails` events.

#### Parameters

##### data

[`AdditionalDetailsEventData`](#AdditionalDetailsEventData.md)

#### Returns

`void`

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
Adyen.addListener('onAdditionalDetails', async (data) => {
  // Handle the additionalDetails event, e.g., send data to your server
  console.log('Additional details:', data);
});
```

***

#### onSubmit()

```ts
onSubmit: (data) => void;
```

Defined in: [src/definitions/index.ts:104](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L104)

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

Defined in: [src/definitions/index.ts:119](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L119)

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

Defined in: [src/definitions/index.ts:134](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L134)

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

Defined in: [src/definitions/index.ts:149](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L149)

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

Defined in: [src/definitions/components/card.ts:170](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L170)

#### Properties

#### type

```ts
type: string;
```

Defined in: [src/definitions/components/card.ts:174](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L174)

Card brand name, e.g., 'visa', 'mc', 'amex', etc.

***

#### isSupported

```ts
isSupported: boolean;
```

Defined in: [src/definitions/components/card.ts:179](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L179)

Only on iOS

## Interface: CardBrandData

Defined in: [src/definitions/components/card.ts:157](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L157)

#### Properties

#### cardBrands

```ts
cardBrands: CardBrand | CardBrand[];
```

Defined in: [src/definitions/components/card.ts:162](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L162)

iOS: List of detected card brands
Android: Detected card brand

***

#### primaryBrand

```ts
primaryBrand: CardBrand;
```

Defined in: [src/definitions/components/card.ts:167](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L167)

First card brand in the list (iOS) or the detected brand (Android)

## Interface: CardChangeEventData

Defined in: [src/definitions/components/card.ts:145](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L145)

#### Properties

#### cardBrands?

```ts
optional cardBrands: CardBrandData;
```

Defined in: [src/definitions/components/card.ts:149](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L149)

Card brand information

***

#### cardBIN?

```ts
optional cardBIN: string;
```

Defined in: [src/definitions/components/card.ts:154](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L154)

Bank Identification Number (BIN) of the card

## Interface: CardComponentConfiguration

Defined in: [src/definitions/components/card.ts:31](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L31)

Configuration options specific to the Card component.

#### See

 - [Android](https://docs.adyen.com/payment-methods/cards/android-component/#components-configuration)
 - [iOS](https://docs.adyen.com/payment-methods/cards/ios-component/#optional-configuration)

#### Properties

#### showsHolderNameField?

```ts
optional showsHolderNameField: boolean;
```

Defined in: [src/definitions/components/card.ts:36](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L36)

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

Defined in: [src/definitions/components/card.ts:42](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L42)

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

Defined in: [src/definitions/components/card.ts:48](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L48)

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

Defined in: [src/definitions/components/card.ts:55](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L55)

Supported card types
Same as `supportedCardTypes` on Android

#### Default

`AnyCardPaymentMethod`

***

#### showsSubmitButton?

```ts
optional showsSubmitButton: boolean;
```

Defined in: [src/definitions/components/card.ts:61](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L61)

Display submit button

#### Default

```ts
true
```

***

#### shopperReference?

```ts
optional shopperReference: string;
```

Defined in: [src/definitions/components/card.ts:66](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L66)

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

Defined in: [src/definitions/components/card.ts:71](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L71)

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
optional koreanAuthenticationMode: "auto" | "hide" | "show";
```

Defined in: [src/definitions/components/card.ts:101](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L101)

For Korean cards, sets if security fields show in the payment form. Possible values:
  - show: show the fields.
  - hide: do not show the fields.
  - auto: the field appears for cards issued in South Korea.

#### Default

`auto`

***

#### socialSecurityNumberMode?

```ts
optional socialSecurityNumberMode: "auto" | "hide" | "show";
```

Defined in: [src/definitions/components/card.ts:110](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L110)

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

Defined in: [src/definitions/components/card.ts:113](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L113)

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

Defined in: [src/definitions/components/card.ts:207](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L207)

#### Extended by

- [`AdyenEvents`](#AdyenEvents.md)

#### Properties

#### onCardSubmit()

```ts
onCardSubmit: (data) => void;
```

Defined in: [src/definitions/components/card.ts:221](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L221)

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

Defined in: [src/definitions/components/card.ts:236](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L236)

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

Defined in: [src/definitions/components/card.ts:183](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L183)

#### Extended by

- [`AdyenPlugin`](#AdyenPlugin.md)

#### Methods

#### presentCardComponent()

```ts
presentCardComponent(options?): Promise<void>;
```

Defined in: [src/definitions/components/card.ts:203](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L203)

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

Defined in: [src/definitions/components/card.ts:10](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L10)

Options for creating a Adyen Card component.

#### Extends

- [`BaseAdyenComponentOptions`](#BaseAdyenComponentOptions.md)

#### Properties

#### amount?

```ts
optional amount: number;
```

Defined in: [src/definitions/components/card.ts:12](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L12)

Payment amount in minor currency units (e.g., cents)

#### Overrides

[`BaseAdyenComponentOptions`](#BaseAdyenComponentOptions.md).[`amount`](#BaseAdyenComponentOptions.md#amount)

***

#### countryCode?

```ts
optional countryCode: string;
```

Defined in: [src/definitions/components/card.ts:14](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L14)

ISO 3166-1 alpha-2 country code (e.g., 'US', 'NL')

#### Overrides

[`BaseAdyenComponentOptions`](#BaseAdyenComponentOptions.md).[`countryCode`](#BaseAdyenComponentOptions.md#countrycode)

***

#### currencyCode?

```ts
optional currencyCode: string;
```

Defined in: [src/definitions/components/card.ts:16](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L16)

ISO 4217 currency code (e.g., 'USD', 'EUR')

#### Overrides

[`BaseAdyenComponentOptions`](#BaseAdyenComponentOptions.md).[`currencyCode`](#BaseAdyenComponentOptions.md#currencycode)

***

#### configuration?

```ts
optional configuration: CardComponentConfiguration;
```

Defined in: [src/definitions/components/card.ts:18](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L18)

Card component behaviour configuration

***

#### style?

```ts
optional style: FormComponentStyle;
```

Defined in: [src/definitions/components/card.ts:20](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L20)

Card-specific styling options

***

#### viewOptions?

```ts
optional viewOptions: ComponentViewOptions;
```

Defined in: [src/definitions/components/card.ts:22](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L22)

View options for the component's presentation layout

## Interface: CardSubmitEventData

Defined in: [src/definitions/components/card.ts:133](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L133)

#### Properties

#### lastFour

```ts
lastFour: string;
```

Defined in: [src/definitions/components/card.ts:137](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L137)

Last four digits of the card number

***

#### finalBIN

```ts
finalBIN: string;
```

Defined in: [src/definitions/components/card.ts:142](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L142)

Final Bank Identification Number (BIN) of the card

## Interface: ComponentHideEventData

Defined in: [src/definitions/index.ts:237](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L237)

#### Properties

#### reason

```ts
reason: "user_gesture";
```

Defined in: [src/definitions/index.ts:238](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L238)

## Interface: ExtendedCardConfiguration

Defined in: [src/definitions/components/card.ts:331](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L331)

Extended Card component configuration including native options

#### See

https://docs.adyen.com/payment-methods/cards/web-component/#optional-configuration

#### Extends

- `CardConfiguration`

#### Properties

#### order?

```ts
optional order: Order;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:627

#### Inherited from

```ts
CardConfiguration.order
```

***

#### modules?

```ts
optional modules: {
  srPanel?: SRPanel;
  analytics?: AnalyticsModule;
  resources?: Resources;
  risk?: RiskElement;
};
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:628

#### srPanel?

```ts
optional srPanel: SRPanel;
```

#### analytics?

```ts
optional analytics: AnalyticsModule;
```

#### resources?

```ts
optional resources: Resources;
```

#### risk?

```ts
optional risk: RiskElement;
```

#### Inherited from

```ts
CardConfiguration.modules
```

***

#### isDropin?

```ts
optional isDropin: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:634

#### Inherited from

```ts
CardConfiguration.isDropin
```

***

#### environment?

```ts
optional environment: string;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:696

#### Inherited from

```ts
CardConfiguration.environment
```

***

#### session?

```ts
optional session: Session;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:697

#### Inherited from

```ts
CardConfiguration.session
```

***

#### onComplete()?

```ts
optional onComplete: (state, element) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:698

#### Parameters

##### state

`any`

##### element

`UIElement`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onComplete
```

***

#### isInstantPayment?

```ts
optional isInstantPayment: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:699

#### Inherited from

```ts
CardConfiguration.isInstantPayment
```

***

#### icon?

```ts
optional icon: string;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:723

#### Inherited from

```ts
CardConfiguration.icon
```

***

#### amount?

```ts
optional amount: PaymentAmount;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:724

#### Inherited from

```ts
CardConfiguration.amount
```

***

#### secondaryAmount?

```ts
optional secondaryAmount: PaymentAmountExtended;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:725

#### Inherited from

```ts
CardConfiguration.secondaryAmount
```

***

#### showPayButton?

```ts
optional showPayButton: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:730

Show/Hide pay button

#### Default Value

```ts
true
```

#### Inherited from

```ts
CardConfiguration.showPayButton
```

***

#### originalAction?

```ts
optional originalAction: PaymentAction;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:757

Reference to the action object found in a /payments response. This, in most cases, is passed on to the onActionHandled callback

#### Inherited from

```ts
CardConfiguration.originalAction
```

***

#### autoFocus?

```ts
optional autoFocus: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:775

Automatically shift the focus from one field to another. Usually happens from a valid Expiry Date field to the Security Code field,
but some BINS also allow us to know that the PAN is complete, in which case we can shift focus to the date field

#### Default Value

`true`

- merchant set config option

#### Inherited from

```ts
CardConfiguration.autoFocus
```

***

#### billingAddressAllowedCountries?

```ts
optional billingAddressAllowedCountries: string[];
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:780

Config t olimit the countries that will show in the country dropdown
- merchant set config option

#### Inherited from

```ts
CardConfiguration.billingAddressAllowedCountries
```

***

#### billingAddressMode?

```ts
optional billingAddressMode: "none" | "full" | "partial";
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:787

If billingAddressRequired is set to true, you can set this to partial to require the shopper's postal code instead of the full address.

#### Default Value

```ts
full

- merchant set config option
```

#### Inherited from

```ts
CardConfiguration.billingAddressMode
```

***

#### billingAddressRequired?

```ts
optional billingAddressRequired: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:794

Show Address fields

#### Default Value

`false`

- merchant set config option

#### Inherited from

```ts
CardConfiguration.billingAddressRequired
```

***

#### billingAddressRequiredFields?

```ts
optional billingAddressRequiredFields: string[];
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:799

Config to specify which address field are required
- merchant set config option

#### Inherited from

```ts
CardConfiguration.billingAddressRequiredFields
```

***

#### brandsConfiguration?

```ts
optional brandsConfiguration: CardBrandsConfiguration;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:816

Configuration specific to brands
- merchant set config option

#### Inherited from

```ts
CardConfiguration.brandsConfiguration
```

***

#### challengeWindowSize?

```ts
optional challengeWindowSize: "01" | "02" | "03" | "04" | "05";
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:830

Defines the size of the challenge Component

01: [250px, 400px]
02: [390px, 400px]
03: [500px, 600px]
04: [600px, 400px]
05: [100%, 100%]

#### Default Value

```ts
'02'

- merchant set config option
```

#### Inherited from

```ts
CardConfiguration.challengeWindowSize
```

***

#### clickToPayConfiguration?

```ts
optional clickToPayConfiguration: ClickToPayProps;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:835

Configuration for Click to Pay
- merchant set config option

#### Inherited from

```ts
CardConfiguration.clickToPayConfiguration
```

***

#### fastlaneConfiguration?

```ts
optional fastlaneConfiguration: FastlaneSignupConfiguration;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:839

Configuration for displaying the Fastlane consent UI.

#### Inherited from

```ts
CardConfiguration.fastlaneConfiguration
```

***

#### data?

```ts
optional data: {
  holderName?: string;
  billingAddress?: Partial<AddressData>;
};
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:854

Object that contains placeholder information that you can use to prefill fields.
- merchant set config option

#### holderName?

```ts
optional holderName: string;
```

#### billingAddress?

```ts
optional billingAddress: Partial<AddressData>;
```

#### Inherited from

```ts
CardConfiguration.data
```

***

#### disableIOSArrowKeys?

```ts
optional disableIOSArrowKeys: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:870

Turn on the procedure to force the arrow keys on an iOS soft keyboard to always be disabled

#### Default Value

`false`

- merchant set config option

#### Inherited from

```ts
CardConfiguration.disableIOSArrowKeys
```

***

#### disclaimerMessage?

```ts
optional disclaimerMessage: DisclaimerMsgObject;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:875

Object to configure the message and text for a disclaimer message, added after the Card input fields
- merchant set config option

#### Inherited from

```ts
CardConfiguration.disclaimerMessage
```

***

#### doBinLookup?

```ts
optional doBinLookup: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:882

Allow binLookup process to occur

#### Default Value

`true`

- merchant set config option

#### Inherited from

```ts
CardConfiguration.doBinLookup
```

***

#### enableStoreDetails?

```ts
optional enableStoreDetails: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:887

Config option related to whether we set storePaymentMethod in the card data, and showing/hiding the "store details" checkbox
- merchant set config option

#### Inherited from

```ts
CardConfiguration.enableStoreDetails
```

***

#### exposeExpiryDate?

```ts
optional exposeExpiryDate: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:897

Allows SF to return an unencrypted expiryDate
- merchant set config option

#### Inherited from

```ts
CardConfiguration.exposeExpiryDate
```

***

#### forceCompat?

```ts
optional forceCompat: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:902

Force securedFields to use the 'compat' version of JWE. (Use case: running custom http:// test environment
- merchant set config option

#### Inherited from

```ts
CardConfiguration.forceCompat
```

***

#### hasHolderName?

```ts
optional hasHolderName: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:919

Show/hide the card holder name field
- merchant set config option

#### Inherited from

```ts
CardConfiguration.hasHolderName
```

***

#### hideCVC?

```ts
optional hideCVC: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:929

Show/hide the Security Code field
- merchant set config option

#### Inherited from

```ts
CardConfiguration.hideCVC
```

***

#### holderNameRequired?

```ts
optional holderNameRequired: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:934

Whether the card holder name field will be required
- merchant set config option

#### Inherited from

```ts
CardConfiguration.holderNameRequired
```

***

#### installmentOptions?

```ts
optional installmentOptions: InstallmentOptions;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:944

Configure the installment options for the card
- merchant set config option

#### Inherited from

```ts
CardConfiguration.installmentOptions
```

***

#### keypadFix?

```ts
optional keypadFix: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:951

Implements a workaround for iOS/Safari bug where keypad doesn't retract when SF paymentMethod is no longer active

#### Default Value

`true`

- merchant set config option

#### Inherited from

```ts
CardConfiguration.keypadFix
```

***

#### legacyInputMode?

```ts
optional legacyInputMode: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:963

For some scenarios make the card input fields (PAN, Expiry Date, Security Code) have type="tel" rather than type="text" inputmode="numeric"

#### Default Value

`false`

- merchant set config option

#### Inherited from

```ts
CardConfiguration.legacyInputMode
```

***

#### maskSecurityCode?

```ts
optional maskSecurityCode: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:970

Adds type="password" to the Security code input field, causing its value to be masked

#### Default Value

`false`

- merchant set config option

#### Inherited from

```ts
CardConfiguration.maskSecurityCode
```

***

#### minimumExpiryDate?

```ts
optional minimumExpiryDate: string;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:976

Specify the minimum expiry date that will be considered valid

- merchant set config option

#### Inherited from

```ts
CardConfiguration.minimumExpiryDate
```

***

#### onAddressLookup?

```ts
optional onAddressLookup: OnAddressLookupType;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:987

Function used to perform 3rd party Address lookup
- merchant set config option

#### Inherited from

```ts
CardConfiguration.onAddressLookup
```

***

#### onAddressSelected?

```ts
optional onAddressSelected: OnAddressSelectedType;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:992

Function used to handle the selected address from 3rd party Address lookup
- merchant set config option

#### Inherited from

```ts
CardConfiguration.onAddressSelected
```

***

#### onBinLookup()?

```ts
optional onBinLookup: (event) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:997

After binLookup call - provides the brand(s) we detect the user is entering, and if we support the brand(s)
- merchant set config option

#### Parameters

##### event

`CardBinLookupData`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onBinLookup
```

***

#### onBinValue()?

```ts
optional onBinValue: (event) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1002

Provides the BIN Number of the card (up to 6 digits), called as the user types in the PAN.
- merchant set config option

#### Parameters

##### event

`CardBinValueData`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onBinValue
```

***

#### onBlur()?

```ts
optional onBlur: (event) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1007

Called when a field loses focus.
- merchant set config option

#### Parameters

##### event

`CardFocusData` | `ComponentFocusObject`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onBlur
```

***

#### onBrand()?

```ts
optional onBrand: (event) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1012

Called once we detect the card brand.
- merchant set config option

#### Parameters

##### event

`CardBrandData`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onBrand
```

***

#### onConfigSuccess()?

```ts
optional onConfigSuccess: (event) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1017

Called once the card input fields are ready to use.
- merchant set config option

#### Parameters

##### event

`CardConfigSuccessData`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onConfigSuccess
```

***

#### onAllValid()?

```ts
optional onAllValid: (event) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1022

Called when *all* the securedFields becomes valid
 Also called again if one of the fields moves out of validity.

#### Parameters

##### event

`CardAllValidData`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onAllValid
```

***

#### onFieldValid()?

```ts
optional onFieldValid: (event) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1028

Called when a field becomes valid and also if a valid field changes and becomes invalid.
For the card number field, it returns the last 4 digits of the card number.
- merchant set config option

#### Parameters

##### event

`CardFieldValidData`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onFieldValid
```

***

#### onFocus()?

```ts
optional onFocus: (event) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1033

Called when a field gains focus.
- merchant set config option

#### Parameters

##### event

`CardFocusData` | `ComponentFocusObject`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onFocus
```

***

#### onLoad()?

```ts
optional onLoad: (event) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1038

Called once all the card input fields have been created but are not yet ready to use.
- merchant set config option

#### Parameters

##### event

`CardLoadData`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onLoad
```

***

#### placeholders?

```ts
optional placeholders: Partial<Record<PlaceholderKeys, string>>;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1043

Configure placeholder text for holderName, cardNumber, expirationDate, securityCode and password.
- merchant set config option

#### Inherited from

```ts
CardConfiguration.placeholders
```

***

#### positionHolderNameOnTop?

```ts
optional positionHolderNameOnTop: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1050

Position holder name above card number field (instead of having it after the security code field)

#### Default Value

`false`

- merchant set config option

#### Inherited from

```ts
CardConfiguration.positionHolderNameOnTop
```

***

#### showBrandIcon?

```ts
optional showBrandIcon: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1057

Show/hide the brand logo when the card brand has been recognized

#### Default Value

`true`

- merchant set config option

#### Inherited from

```ts
CardConfiguration.showBrandIcon
```

***

#### showContextualElement?

```ts
optional showContextualElement: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1064

Show/hide the contextual text under each form field. The contextual text is to assist shoppers filling in the payment form.

#### Default Value

`true`

- merchant set config option

#### Inherited from

```ts
CardConfiguration.showContextualElement
```

***

#### showInstallmentAmounts?

```ts
optional showInstallmentAmounts: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1071

Set whether to show installments broken down into amounts or months

#### Default Value

`true`

- merchant set config option

#### Inherited from

```ts
CardConfiguration.showInstallmentAmounts
```

***

#### styles?

```ts
optional styles: StylesObject;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1086

Object to configure the styling of the inputs in the iframes that are used to present the PAN, Expiry Date & Security Code fields
- merchant set config option

#### Inherited from

```ts
CardConfiguration.styles
```

***

#### beforeRedirect()?

```ts
optional beforeRedirect: (resolve, reject, redirectData) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:5981

Called before the page redirect happens.
Allows you to perform any sort of action before redirecting the shopper to another page.

#### Parameters

##### resolve

() => `void`

##### reject

() => `void`

##### redirectData

###### url

`string`

###### method

`string`

###### data?

`any`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.beforeRedirect
```

***

#### beforeSubmit()?

```ts
optional beforeSubmit: (state, component, actions) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:5996

Called when the shopper selects the Pay button (it only works on Sessions flow)

Allows you to add details which will be sent in the payment request to Adyen's servers.
For example, you can add shopper details like 'billingAddress', 'deliveryAddress', 'shopperEmail' or 'shopperName'

#### Parameters

##### state

`PaymentData`

##### component

`UIElement`

##### actions

`BeforeSubmitActions`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.beforeSubmit
```

***

#### onPaymentCompleted()?

```ts
optional onPaymentCompleted: (data, component?) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:6005

Called when the payment succeeds.

The first parameter is the sessions response (when using sessions flow), or the result code.

#### Parameters

##### data

`PaymentCompletedData`

##### component?

`UIElement`\<`UIElementProps`\>

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onPaymentCompleted
```

***

#### onPaymentFailed()?

```ts
optional onPaymentFailed: (data?, component?) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:6015

Called when the payment fails.

The first parameter is populated when merchant is using sessions, or when the payment was rejected
with an object. (Ex: 'action.reject(obj)' ). Otherwise, it will be empty.

#### Parameters

##### data?

`PaymentFailedData`

session response or resultCode. It can also be undefined if payment was rejected without argument ('action.reject()')

##### component?

`UIElement`\<`UIElementProps`\>

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onPaymentFailed
```

***

#### onSubmit()?

```ts
optional onSubmit: (state, component, actions) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:6026

Callback used in the Advanced flow to perform the /payments API call

The payment response must be passed to the 'resolve' function, even if the payment wasn't authorized (Ex: resultCode = Refused).
The 'reject' should be used only if a critical error occurred.

#### Parameters

##### state

`SubmitData`

##### component

`UIElement`

##### actions

`SubmitActions`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onSubmit
```

***

#### onAdditionalDetails()?

```ts
optional onAdditionalDetails: (state, component, actions) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:6037

Callback used in the Advanced flow to perform the /payments/details API call.

The payment response must be passed to the 'resolve' function, even if the payment wasn't authorized (Ex: resultCode = Refused).
The 'reject' should be used only if a critical error occurred.

#### Parameters

##### state

`AdditionalDetailsData`

##### component

`UIElement`

Component submitting details. It is undefined when using checkout.submitDetails()

##### actions

`AdditionalDetailsActions`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onAdditionalDetails
```

***

#### onActionHandled()?

```ts
optional onActionHandled: (actionHandled) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:6053

Callback called when an action (for example a QR code or 3D Secure 2 authentication screen) is shown to the shopper.

#### Parameters

##### actionHandled

`ActionHandledReturnObject`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onActionHandled
```

***

#### onChange()?

```ts
optional onChange: (state, component) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:6054

#### Parameters

##### state

`OnChangeData`

##### component

`UIElement`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onChange
```

***

#### onError()?

```ts
optional onError: (error, component?) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:6063

Callback called in two different scenarios:
- when a critical error happened (network error; implementation error; script failed to load)
- when the shopper cancels the payment flow in payment methods that have an overlay (GooglePay, PayPal, ApplePay)

#### Parameters

##### error

`AdyenCheckoutError`

##### component?

`UIElement`\<`UIElementProps`\>

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onError
```

***

#### onEnterKeyPressed()?

```ts
optional onEnterKeyPressed: (activeElement, component) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:6070

Called when a Component detects, or is told by a SecuredField, that the Enter key has been pressed.
- merchant set config option

#### Parameters

##### activeElement

`Element`

##### component

`UIElement`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onEnterKeyPressed
```

***

#### onPaymentMethodsRequest()?

```ts
optional onPaymentMethodsRequest: (data, actions) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:6080

Callback called when it is required to fetch/update the payment methods list.
It is currently used mainly on Giftcard flow (Partial orders), since the payment method list might change depending on the amount left to be paid

The /paymentMethods response must be passed to the 'resolve' function

#### Parameters

##### data

`PaymentMethodsRequestData`

##### actions

###### resolve

(`response`) => `void`

###### reject

() => `void`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onPaymentMethodsRequest
```

***

#### onOrderUpdated()?

```ts
optional onOrderUpdated: (data) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:6090

Called when the gift card balance is less than the transaction amount.
Returns an Order object that includes the remaining amount to be paid.
https://docs.adyen.com/payment-methods/gift-cards/web-component?tab=config-sessions_1

#### Parameters

##### data

###### order

`Order`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onOrderUpdated
```

***

#### nativeCard?

```ts
optional nativeCard: NativeCardConfiguration;
```

Defined in: [src/definitions/components/card.ts:332](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L332)

***

#### isDev?

```ts
optional isDev: boolean;
```

Defined in: [src/definitions/components/card.ts:333](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L333)

***

#### testNativePresentation?

```ts
optional testNativePresentation: boolean;
```

Defined in: [src/definitions/components/card.ts:334](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L334)

## Interface: NativeCardConfiguration

Defined in: [src/definitions/components/card.ts:271](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L271)

Native card component configuration options

#### Properties

#### brandImages?

```ts
optional brandImages: Record<string, string>;
```

Defined in: [src/definitions/components/card.ts:279](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L279)

Override card brand image `src` strings

#### Example

```json
{ "mc": "https://example.com/mc.png", "visa": "https://example.com/visa.png" }
```

***

#### labels?

```ts
optional labels: {
  addCard?: string;
  submittedCardTitle?: string;
  changePaymentMethod?: string;
};
```

Defined in: [src/definitions/components/card.ts:285](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L285)

i18n strings to use in Web presentation on native platforms.
Fallbacks to English strings.

#### addCard?

```ts
optional addCard: string;
```

Label for the button to add a new card

##### Default

```ts
"Add card"
```

#### submittedCardTitle?

```ts
optional submittedCardTitle: string;
```

Title on top of filled card brand and number

##### Default

```ts
"Card:"
```

#### changePaymentMethod?

```ts
optional changePaymentMethod: string;
```

Label for the button to change the payment method once filled

##### Default

```ts
"Change"
```

***

#### onClickEdit()?

```ts
optional onClickEdit: () => void;
```

Defined in: [src/definitions/components/card.ts:317](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L317)

Override default behaviour when the user taps "Edit" or "Add card" button.
You can use this to present your own card form or handle the event differently.

#### Returns

`void`

#### Default

```ts
presents the native Card component form
```

#### Example

```typescript
async function onClickEdit() {
  // Present your own card form or handle differently
}
```

***

#### componentOptions?

```ts
optional componentOptions: Omit<CardComponentOptions, "countryCode" | "amount" | "currencyCode">;
```

Defined in: [src/definitions/components/card.ts:322](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L322)

Component options for the native bottom sheet card form presentation

## Interface: NativeCardState

Defined in: [src/definitions/components/card.ts:243](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L243)

State of the native card component

#### Properties

#### brand

```ts
brand: string;
```

Defined in: [src/definitions/components/card.ts:247](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L247)

Card brand (e.g., 'visa', 'mc', 'amex', etc.)

***

#### state

```ts
state: "loading" | "submitted";
```

Defined in: [src/definitions/components/card.ts:252](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L252)

Component state (loading or submitted)

***

#### lastFour

```ts
lastFour: string;
```

Defined in: [src/definitions/components/card.ts:257](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L257)

Last four digits of the card number

***

#### showForceEditButton

```ts
showForceEditButton: boolean;
```

Defined in: [src/definitions/components/card.ts:263](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L263)

Show "Add card" button immediately when rendering loading state

#### Default

```ts
false
```

## Interface: PaymentErrorEventData

Defined in: [src/definitions/index.ts:232](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L232)

#### Indexable

```ts
[key: string]: any
```

#### Properties

#### message

```ts
message: string;
```

Defined in: [src/definitions/index.ts:234](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L234)

## Interface: PaymentMethodsResponse

Defined in: [src/definitions/index.ts:49](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L49)

JSON response from Adyen API call

#### See

https://docs.adyen.com/api-explorer/Checkout/latest/post/paymentMethods for more information.

#### Properties

#### paymentMethods

```ts
paymentMethods: any[];
```

Defined in: [src/definitions/index.ts:53](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L53)

Array of available payment methods.

***

#### savedPaymentMethods?

```ts
optional savedPaymentMethods: any[];
```

Defined in: [src/definitions/index.ts:58](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L58)

The type of the payment method response, typically "PaymentMethods".

## Interface: PaymentSubmitEventData

Defined in: [src/definitions/index.ts:221](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L221)

#### Properties

#### paymentMethod

```ts
paymentMethod: {
[key: string]: any;
};
```

Defined in: [src/definitions/index.ts:222](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L222)

#### Index Signature

```ts
[key: string]: any
```

***

#### componentType

```ts
componentType: "card";
```

Defined in: [src/definitions/index.ts:225](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L225)

***

#### browserInfo?

```ts
optional browserInfo: {
  userAgent: string;
};
```

Defined in: [src/definitions/index.ts:226](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L226)

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

Defined in: [src/definitions/index.ts:227](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L227)

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

Defined in: [src/definitions/index.ts:228](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L228)

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

Defined in: [src/definitions/index.ts:229](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L229)

## Type: ButtonStyleDefinition

```ts
type ButtonStyleDefinition = {
  font?: FontDefinition;
  textColor?: string;
  backgroundColor?: string;
  cornerRadius?: number;
};
```

Defined in: [src/definitions/styles.ts:131](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L131)

Defines the styling for a button. These definitions map to
`FormButtonItemStyle.main` in the iOS SDK. All fields are optional.

#### Properties

#### font?

```ts
optional font: FontDefinition;
```

Defined in: [src/definitions/styles.ts:133](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L133)

Font used for the button's title.

***

#### textColor?

```ts
optional textColor: string;
```

Defined in: [src/definitions/styles.ts:135](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L135)

Colour of the button title text.

***

#### backgroundColor?

```ts
optional backgroundColor: string;
```

Defined in: [src/definitions/styles.ts:137](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L137)

Main background colour of the button.

***

#### cornerRadius?

```ts
optional cornerRadius: number;
```

Defined in: [src/definitions/styles.ts:139](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L139)

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

Defined in: [src/definitions/styles.ts:5](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L5)

Options for customizing the appearance of the component navbar's view.

#### Properties

#### title?

```ts
optional title: string;
```

Defined in: [src/definitions/styles.ts:7](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L7)

Custom text for the title

***

#### titleColor?

```ts
optional titleColor: string;
```

Defined in: [src/definitions/styles.ts:9](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L9)

Color for the title text

***

#### titleBackgroundColor?

```ts
optional titleBackgroundColor: string;
```

Defined in: [src/definitions/styles.ts:11](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L11)

Title bar's background color

***

#### titleTintColor?

```ts
optional titleTintColor: string;
```

Defined in: [src/definitions/styles.ts:13](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L13)

Tint color for buttons in the title bar

***

#### showsCloseButton?

```ts
optional showsCloseButton: boolean;
```

Defined in: [src/definitions/styles.ts:15](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L15)

Whether to show a close button in the title bar

***

#### closeButtonText?

```ts
optional closeButtonText: string;
```

Defined in: [src/definitions/styles.ts:17](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L17)

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

Defined in: [src/definitions/styles.ts:19](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L19)

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

Defined in: [src/definitions/styles.ts:31](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L31)

Defines a font used within a text element. Both fields are optional; if
omitted, the default system font is used.

#### Properties

#### size?

```ts
optional size: number;
```

Defined in: [src/definitions/styles.ts:33](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L33)

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

Defined in: [src/definitions/styles.ts:35](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L35)

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

Defined in: [src/definitions/styles.ts:148](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L148)

Combined style configuration for forms. Includes top-level colours and
nested sub-styles for various form elements. All keys are optional and
unknown keys are ignored.

#### Properties

#### backgroundColor?

```ts
optional backgroundColor: string;
```

Defined in: [src/definitions/styles.ts:150](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L150)

Background colour applied to the entire form.

***

#### tintColor?

```ts
optional tintColor: string;
```

Defined in: [src/definitions/styles.ts:152](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L152)

Tint colour applied to accent elements within the form.

***

#### separatorColor?

```ts
optional separatorColor: string;
```

Defined in: [src/definitions/styles.ts:154](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L154)

Colour of separators between form rows.

***

#### header?

```ts
optional header: TextStyleDefinition;
```

Defined in: [src/definitions/styles.ts:157](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L157)

Styling for the header text (section title).

***

#### textField?

```ts
optional textField: TextFieldStyleDefinition;
```

Defined in: [src/definitions/styles.ts:159](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L159)

Styling for text input fields.

***

#### switch?

```ts
optional switch: SwitchStyleDefinition;
```

Defined in: [src/definitions/styles.ts:162](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L162)

Styling for toggle rows. Both `switch` and `toggle` keys are supported.

***

#### toggle?

```ts
optional toggle: SwitchStyleDefinition;
```

Defined in: [src/definitions/styles.ts:163](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L163)

***

#### hint?

```ts
optional hint: TextStyleDefinition;
```

Defined in: [src/definitions/styles.ts:166](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L166)

Styling for hint labels (usually under a field).

***

#### footnote?

```ts
optional footnote: TextStyleDefinition;
```

Defined in: [src/definitions/styles.ts:168](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L168)

Styling for footnote labels at the bottom of the form.

***

#### linkText?

```ts
optional linkText: TextStyleDefinition;
```

Defined in: [src/definitions/styles.ts:170](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L170)

Styling for inline link text in informational messages.

***

#### button?

```ts
optional button: ButtonStyleDefinition;
```

Defined in: [src/definitions/styles.ts:173](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L173)

Styling for the primary action button. You may use either `button` or `mainButton`.

***

#### mainButton?

```ts
optional mainButton: ButtonStyleDefinition;
```

Defined in: [src/definitions/styles.ts:175](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L175)

Styling for the primary action button. Same as `button`.

***

#### secondaryButton?

```ts
optional secondaryButton: ButtonStyleDefinition;
```

Defined in: [src/definitions/styles.ts:177](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L177)

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

Defined in: [src/definitions/styles.ts:111](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L111)

Styling for a toggle (switch) row. Supports a title style and colours for
tint, separator and background. This type is used for both the `switch` and
`toggle` keys when specifying form styles.

#### Properties

#### title?

```ts
optional title: TextStyleDefinition;
```

Defined in: [src/definitions/styles.ts:113](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L113)

Styling for the title label next to the toggle.

***

#### titleColor?

```ts
optional titleColor: string;
```

Defined in: [src/definitions/styles.ts:115](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L115)

Colour of the title label (legacy shortcut).

***

#### titleFont?

```ts
optional titleFont: FontDefinition;
```

Defined in: [src/definitions/styles.ts:117](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L117)

Font for the title label (legacy shortcut).

***

#### tintColor?

```ts
optional tintColor: string;
```

Defined in: [src/definitions/styles.ts:119](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L119)

Tint colour of the toggle when turned on.

***

#### separatorColor?

```ts
optional separatorColor: string;
```

Defined in: [src/definitions/styles.ts:121](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L121)

Colour of the separator line beneath the toggle row.

***

#### backgroundColor?

```ts
optional backgroundColor: string;
```

Defined in: [src/definitions/styles.ts:123](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L123)

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

Defined in: [src/definitions/styles.ts:59](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L59)

Describes styling for a text field in the form. This includes styling
for the title label, user input text, placeholder text, and trailing icon.

#### Properties

#### title?

```ts
optional title: TextStyleDefinition;
```

Defined in: [src/definitions/styles.ts:61](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L61)

Styling for the field's title label.

***

#### titleColor?

```ts
optional titleColor: string;
```

Defined in: [src/definitions/styles.ts:63](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L63)

Colour of the title label (legacy shortcut).

***

#### titleFont?

```ts
optional titleFont: FontDefinition;
```

Defined in: [src/definitions/styles.ts:65](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L65)

Font used for the title label (legacy shortcut).

***

#### text?

```ts
optional text: TextStyleDefinition;
```

Defined in: [src/definitions/styles.ts:68](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L68)

Styling for the user-entered text.

***

#### textColor?

```ts
optional textColor: string;
```

Defined in: [src/definitions/styles.ts:70](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L70)

Colour of the user-entered text (legacy shortcut).

***

#### textFont?

```ts
optional textFont: FontDefinition;
```

Defined in: [src/definitions/styles.ts:72](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L72)

Font for the user-entered text (legacy shortcut).

***

#### placeholder?

```ts
optional placeholder: TextStyleDefinition;
```

Defined in: [src/definitions/styles.ts:75](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L75)

Styling for the placeholder text.

***

#### placeholderColor?

```ts
optional placeholderColor: string;
```

Defined in: [src/definitions/styles.ts:77](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L77)

Colour of the placeholder text (legacy shortcut).

***

#### placeholderFont?

```ts
optional placeholderFont: FontDefinition;
```

Defined in: [src/definitions/styles.ts:79](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L79)

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

Defined in: [src/definitions/styles.ts:82](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L82)

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

Defined in: [src/definitions/styles.ts:96](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L96)

Tint colour applied to the text field (cursor/accent).

***

#### separatorColor?

```ts
optional separatorColor: string;
```

Defined in: [src/definitions/styles.ts:98](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L98)

Colour of the separator line beneath the text field.

***

#### backgroundColor?

```ts
optional backgroundColor: string;
```

Defined in: [src/definitions/styles.ts:100](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L100)

Background colour of the entire text field cell.

***

#### errorColor?

```ts
optional errorColor: string;
```

Defined in: [src/definitions/styles.ts:102](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L102)

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

Defined in: [src/definitions/styles.ts:43](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L43)

Describes common text styling. Applicable to labels, hints, footers, etc.
You can combine colour, font, background and text alignment.

#### Properties

#### color?

```ts
optional color: string;
```

Defined in: [src/definitions/styles.ts:45](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L45)

Hex colour string for the text (e.g. '#FF0000' or 'FFFFFF').

***

#### font?

```ts
optional font: FontDefinition;
```

Defined in: [src/definitions/styles.ts:47](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L47)

Font specification for the text.

***

#### backgroundColor?

```ts
optional backgroundColor: string;
```

Defined in: [src/definitions/styles.ts:49](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L49)

Background colour behind the text.

***

#### textAlignment?

```ts
optional textAlignment: "left" | "center" | "right" | "justified" | "natural";
```

Defined in: [src/definitions/styles.ts:51](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L51)

Alignment for the text within its container.

<!-- API-REF:END -->
