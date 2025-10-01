# Interface: PaymentSubmitEventData

Defined in: [index.ts:173](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L173)

## Properties

### paymentMethod

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

### componentType

```ts
componentType: "card";
```

Defined in: [index.ts:177](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L177)

***

### browserInfo?

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

### order?

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

### amount?

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

### storePaymentMethod?

```ts
optional storePaymentMethod: boolean;
```

Defined in: [index.ts:181](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L181)
