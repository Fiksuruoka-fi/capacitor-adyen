# Interface: CardComponentEvents

Defined in: [src/definitions/components/card.ts:207](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/0e19236823a007dd09c9876ed28b8e1e5b19a059/src/definitions/components/card.ts#L207)

## Extended by

- [`AdyenEvents`](AdyenEvents.md)

## Properties

### onCardSubmit()

```ts
onCardSubmit: (data) => void;
```

Defined in: [src/definitions/components/card.ts:221](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/0e19236823a007dd09c9876ed28b8e1e5b19a059/src/definitions/components/card.ts#L221)

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

Defined in: [src/definitions/components/card.ts:236](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/0e19236823a007dd09c9876ed28b8e1e5b19a059/src/definitions/components/card.ts#L236)

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
