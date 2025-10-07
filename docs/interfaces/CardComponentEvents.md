# Interface: CardComponentEvents

Defined in: [src/definitions/components/card.ts:207](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L207)

## Extended by

- [`AdyenEvents`](AdyenEvents.md)

## Properties

### onCardSubmit()

```ts
onCardSubmit: (data) => void;
```

Defined in: [src/definitions/components/card.ts:221](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L221)

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

Defined in: [src/definitions/components/card.ts:236](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/components/card.ts#L236)

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
