# Interface: PaymentMethodsResponse

Defined in: [src/definitions/index.ts:49](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L49)

JSON response from Adyen API call

## See

https://docs.adyen.com/api-explorer/Checkout/latest/post/paymentMethods for more information.

## Properties

### paymentMethods

```ts
paymentMethods: any[];
```

Defined in: [src/definitions/index.ts:53](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L53)

Array of available payment methods.

***

### savedPaymentMethods?

```ts
optional savedPaymentMethods: any[];
```

Defined in: [src/definitions/index.ts:58](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L58)

The type of the payment method response, typically "PaymentMethods".
