# Interface: NativeCardState

Defined in: [src/definitions/components/card.ts:243](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/components/card.ts#L243)

State of the native card component

## Properties

### brand

```ts
brand: string;
```

Defined in: [src/definitions/components/card.ts:247](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/components/card.ts#L247)

Card brand (e.g., 'visa', 'mc', 'amex', etc.)

***

### state

```ts
state: "loading" | "submitted";
```

Defined in: [src/definitions/components/card.ts:252](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/components/card.ts#L252)

Component state (loading or submitted)

***

### lastFour

```ts
lastFour: string;
```

Defined in: [src/definitions/components/card.ts:257](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/components/card.ts#L257)

Last four digits of the card number

***

### showForceEditButton

```ts
showForceEditButton: boolean;
```

Defined in: [src/definitions/components/card.ts:263](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/components/card.ts#L263)

Show "Add card" button immediately when rendering loading state

#### Default

```ts
false
```
