# Interface: PaymentSubmitEventData

Defined in: [src/definitions/index.ts:221](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/index.ts#L221)

## Properties

### paymentMethod

```ts
paymentMethod: {
[key: string]: any;
};
```

Defined in: [src/definitions/index.ts:222](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/index.ts#L222)

#### Index Signature

```ts
[key: string]: any
```

***

### componentType

```ts
componentType: "card";
```

Defined in: [src/definitions/index.ts:225](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/index.ts#L225)

***

### browserInfo?

```ts
optional browserInfo: {
  userAgent: string;
};
```

Defined in: [src/definitions/index.ts:226](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/index.ts#L226)

#### userAgent

```ts
userAgent: string;
```

***

### order?

```ts
optional order: {
  orderData: string;
  pspReference: string;
};
```

Defined in: [src/definitions/index.ts:227](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/index.ts#L227)

#### orderData

```ts
orderData: string;
```

#### pspReference

```ts
pspReference: string;
```

***

### amount?

```ts
optional amount: {
  value: number;
  currency: string;
};
```

Defined in: [src/definitions/index.ts:228](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/index.ts#L228)

#### value

```ts
value: number;
```

#### currency

```ts
currency: string;
```

***

### storePaymentMethod?

```ts
optional storePaymentMethod: boolean;
```

Defined in: [src/definitions/index.ts:229](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/index.ts#L229)
