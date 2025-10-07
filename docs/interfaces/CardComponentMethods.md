# Interface: CardComponentMethods

Defined in: [src/definitions/components/card.ts:183](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/components/card.ts#L183)

## Extended by

- [`AdyenPlugin`](AdyenPlugin.md)

## Methods

### presentCardComponent()

```ts
presentCardComponent(options?): Promise<void>;
```

Defined in: [src/definitions/components/card.ts:203](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/components/card.ts#L203)

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
