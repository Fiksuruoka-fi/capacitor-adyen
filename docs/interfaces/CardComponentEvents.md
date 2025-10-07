# Interface: CardComponentEvents

Defined in: [src/definitions/components/card.ts:206](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f6b775642775e61e00bb60787472fc2c2f9bd045/src/definitions/components/card.ts#L206)

## Extended by

- [`AdyenEvents`](AdyenEvents.md)

## Properties

### onCardSubmit()

```ts
onCardSubmit: (data) => void;
```

Defined in: [src/definitions/components/card.ts:220](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f6b775642775e61e00bb60787472fc2c2f9bd045/src/definitions/components/card.ts#L220)

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

Defined in: [src/definitions/components/card.ts:235](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f6b775642775e61e00bb60787472fc2c2f9bd045/src/definitions/components/card.ts#L235)

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
