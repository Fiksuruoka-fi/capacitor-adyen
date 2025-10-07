# Interface: CardComponentMethods

Defined in: [src/definitions/components/card.ts:182](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/components/card.ts#L182)

## Extended by

- [`AdyenPlugin`](AdyenPlugin.md)

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
