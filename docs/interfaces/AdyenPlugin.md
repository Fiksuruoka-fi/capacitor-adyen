# Interface: AdyenPlugin

Defined in: [src/definitions/index.ts:212](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/index.ts#L212)

## Extends

- [`BaseAdyenPlugin`](BaseAdyenPlugin.md).[`CardComponentMethods`](CardComponentMethods.md)

## Methods

### presentCardComponent()

```ts
presentCardComponent(options?): Promise<void>;
```

Defined in: [src/definitions/components/card.ts:202](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/components/card.ts#L202)

Creates a Adyen Card component for handling card payments.

#### Parameters

##### options?

[`CardComponentOptions`](CardComponentOptions.md)

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

[`CardComponentMethods`](CardComponentMethods.md).[`presentCardComponent`](CardComponentMethods.md#presentcardcomponent)

***

### setCurrentPaymentMethods()

```ts
setCurrentPaymentMethods(options): Promise<void>;
```

Defined in: [src/definitions/index.ts:179](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/index.ts#L179)

Set current available payment methods for the Adyen components.

#### Parameters

##### options

Options for creating the card component.

###### paymentMethodsJson

[`PaymentMethodsResponse`](PaymentMethodsResponse.md)

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

[`BaseAdyenPlugin`](BaseAdyenPlugin.md).[`setCurrentPaymentMethods`](BaseAdyenPlugin.md#setcurrentpaymentmethods)

***

### hideComponent()

```ts
hideComponent(): Promise<void>;
```

Defined in: [src/definitions/index.ts:193](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/index.ts#L193)

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

[`BaseAdyenPlugin`](BaseAdyenPlugin.md).[`hideComponent`](BaseAdyenPlugin.md#hidecomponent)

***

### destroyComponent()

```ts
destroyComponent(): Promise<void>;
```

Defined in: [src/definitions/index.ts:207](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/index.ts#L207)

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

[`BaseAdyenPlugin`](BaseAdyenPlugin.md).[`destroyComponent`](BaseAdyenPlugin.md#destroycomponent)

***

### addListener()

```ts
addListener<E>(eventName, listener): Promise<PluginListenerHandle>;
```

Defined in: [src/definitions/index.ts:209](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/index.ts#L209)

#### Type Parameters

##### E

`E` *extends* keyof [`AdyenEvents`](AdyenEvents.md)

#### Parameters

##### eventName

`E`

##### listener

[`AdyenEvents`](AdyenEvents.md)\[`E`\]

#### Returns

`Promise`\<`PluginListenerHandle`\>

#### Inherited from

[`BaseAdyenPlugin`](BaseAdyenPlugin.md).[`addListener`](BaseAdyenPlugin.md#addlistener)
