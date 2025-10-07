# Interface: NativeCardConfiguration

Defined in: [src/definitions/components/card.ts:271](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/components/card.ts#L271)

Native card component configuration options

## Properties

### brandImages?

```ts
optional brandImages: Record<string, string>;
```

Defined in: [src/definitions/components/card.ts:279](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/components/card.ts#L279)

Override card brand image `src` strings

#### Example

```json
{ "mc": "https://example.com/mc.png", "visa": "https://example.com/visa.png" }
```

***

### labels?

```ts
optional labels: {
  addCard?: string;
  submittedCardTitle?: string;
  changePaymentMethod?: string;
};
```

Defined in: [src/definitions/components/card.ts:285](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/components/card.ts#L285)

i18n strings to use in Web presentation on native platforms.
Fallbacks to English strings.

#### addCard?

```ts
optional addCard: string;
```

Label for the button to add a new card

##### Default

```ts
"Add card"
```

#### submittedCardTitle?

```ts
optional submittedCardTitle: string;
```

Title on top of filled card brand and number

##### Default

```ts
"Card:"
```

#### changePaymentMethod?

```ts
optional changePaymentMethod: string;
```

Label for the button to change the payment method once filled

##### Default

```ts
"Change"
```

***

### onClickEdit()?

```ts
optional onClickEdit: () => void;
```

Defined in: [src/definitions/components/card.ts:317](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/components/card.ts#L317)

Override default behaviour when the user taps "Edit" or "Add card" button.
You can use this to present your own card form or handle the event differently.

#### Returns

`void`

#### Default

```ts
presents the native Card component form
```

#### Example

```typescript
async function onClickEdit() {
  // Present your own card form or handle differently
}
```

***

### componentOptions?

```ts
optional componentOptions: Omit<CardComponentOptions, "countryCode" | "amount" | "currencyCode">;
```

Defined in: [src/definitions/components/card.ts:322](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/components/card.ts#L322)

Component options for the native bottom sheet card form presentation
