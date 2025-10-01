# Interface: CardComponentEvents

Defined in: [components/card.ts:205](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L205)

## Extended by

- [`AdyenEvents`](AdyenEvents.md)

## Properties

### onCardSubmit()

```ts
onCardSubmit: (data) => void;
```

Defined in: [components/card.ts:219](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L219)

Listens for Card component `submit` events.

#### Parameters

##### data

[`CardSubmitEventData`](CardSubmitEventData.md)

#### Returns

`void`

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
Adyen.addListener('onCardSubmit', async (data) => {
  // Handle the submit event, e.g., show selected card details to the user
  console.log('Card submitted:', data);
});
```

***

### onCardChange()

```ts
onCardChange: (data) => void;
```

Defined in: [components/card.ts:234](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L234)

Listens for Card component's `change` events.

#### Parameters

##### data

[`CardChangeEventData`](CardChangeEventData.md)

#### Returns

`void`

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
Adyen.addListener('onCardChange', async (data) => {
  // Handle the change event, e.g., show selected card details to the user
  console.log('Card changed:', data);
});
```
