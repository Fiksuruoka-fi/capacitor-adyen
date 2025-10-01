# Interface: PaymentMethodsResponse

Defined in: [index.ts:33](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L33)

JSON response from Adyen API call

## See

https://docs.adyen.com/api-explorer/Checkout/latest/post/paymentMethods for more information.

## Properties

### paymentMethods

```ts
paymentMethods: any[];
```

Defined in: [index.ts:37](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L37)

Array of available payment methods.

***

### savedPaymentMethods?

```ts
optional savedPaymentMethods: any[];
```

Defined in: [index.ts:42](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L42)

The type of the payment method response, typically "PaymentMethods".
