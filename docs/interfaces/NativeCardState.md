# Interface: NativeCardState

Defined in: [src/definitions/components/card.ts:242](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/components/card.ts#L242)

State of the native card component

## Properties

### brand

```ts
brand: string;
```

Defined in: [src/definitions/components/card.ts:246](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/components/card.ts#L246)

Card brand (e.g., 'visa', 'mc', 'amex', etc.)

***

### state

```ts
state: "loading" | "submitted";
```

Defined in: [src/definitions/components/card.ts:251](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/components/card.ts#L251)

Component state (loading or submitted)

***

### lastFour

```ts
lastFour: string;
```

Defined in: [src/definitions/components/card.ts:256](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/components/card.ts#L256)

Last four digits of the card number

***

### showForceEditButton

```ts
showForceEditButton: boolean;
```

Defined in: [src/definitions/components/card.ts:262](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/components/card.ts#L262)

Show "Add card" button immediately when rendering loading state

#### Default

```ts
false
```
