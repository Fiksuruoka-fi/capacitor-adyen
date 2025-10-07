# Interface: PaymentMethodsResponse

Defined in: [src/definitions/index.ts:49](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/index.ts#L49)

JSON response from Adyen API call

## See

https://docs.adyen.com/api-explorer/Checkout/latest/post/paymentMethods for more information.

## Properties

### paymentMethods

```ts
paymentMethods: any[];
```

Defined in: [src/definitions/index.ts:53](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/index.ts#L53)

Array of available payment methods.

***

### savedPaymentMethods?

```ts
optional savedPaymentMethods: any[];
```

Defined in: [src/definitions/index.ts:58](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/index.ts#L58)

The type of the payment method response, typically "PaymentMethods".
