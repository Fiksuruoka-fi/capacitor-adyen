# Interface: AdyenEvents

Defined in: [src/definitions/index.ts:156](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L156)

All available Adyen events

## Extends

- [`BaseEvents`](BaseEvents.md).[`CardComponentEvents`](CardComponentEvents.md)

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

#### Inherited from

[`CardComponentEvents`](CardComponentEvents.md).[`onCardSubmit`](CardComponentEvents.md#oncardsubmit)

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

#### Inherited from

[`CardComponentEvents`](CardComponentEvents.md).[`onCardChange`](CardComponentEvents.md#oncardchange)

***

### onAdditionalDetails()

```ts
onAdditionalDetails: (data) => void;
```

Defined in: [src/definitions/index.ts:90](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L90)

Listens for payment `onAdditionalDetails` events.

#### Parameters

##### data

[`AdditionalDetailsEventData`](AdditionalDetailsEventData.md)

#### Returns

`void`

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
Adyen.addListener('onAdditionalDetails', async (data) => {
  // Handle the additionalDetails event, e.g., send data to your server
  console.log('Additional details:', data);
});
```

#### Inherited from

[`BaseEvents`](BaseEvents.md).[`onAdditionalDetails`](BaseEvents.md#onadditionaldetails)

***

### onSubmit()

```ts
onSubmit: (data) => void;
```

Defined in: [src/definitions/index.ts:104](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L104)

Listens for payment `submit` events.

#### Parameters

##### data

[`PaymentSubmitEventData`](PaymentSubmitEventData.md)

#### Returns

`void`

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
Adyen.addListener('onSubmit', async (data) => {
  // Handle the submit event, e.g., send payment data to your server
  console.log('Payment submitted:', data);
});
```

#### Inherited from

[`BaseEvents`](BaseEvents.md).[`onSubmit`](BaseEvents.md#onsubmit)

***

### onError()

```ts
onError: (data) => void;
```

Defined in: [src/definitions/index.ts:119](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L119)

Listens for payment and component `error` events.

#### Parameters

##### data

[`PaymentErrorEventData`](PaymentErrorEventData.md)

#### Returns

`void`

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
Adyen.addListener('onError', async (data) => {
  // Handle the error event, e.g., show an error message to the user
  console.error('Payment error:', data);
});
```

#### Inherited from

[`BaseEvents`](BaseEvents.md).[`onError`](BaseEvents.md#onerror)

***

### onShow()

```ts
onShow: () => void;
```

Defined in: [src/definitions/index.ts:134](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L134)

Listens for component `present` events.

#### Returns

`void`

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
Adyen.addListener('onShow', async () => {
  // Handle the present event
  console.log('Component presented');
});
```

#### Inherited from

[`BaseEvents`](BaseEvents.md).[`onShow`](BaseEvents.md#onshow)

***

### onHide()

```ts
onHide: (data) => void;
```

Defined in: [src/definitions/index.ts:149](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/index.ts#L149)

Listens for component `dismiss` events.

#### Parameters

##### data

[`ComponentHideEventData`](ComponentHideEventData.md)

#### Returns

`void`

#### Since

7.0.0

#### Example

```typescript
import { Adyen } from '@foodello/capacitor-adyen';
Adyen.addListener('onHide', async (data) => {
  // Handle the hide event, e.g., navigate back or reset the UI
  console.log('Component hidden:', data.reason);
});
```

#### Inherited from

[`BaseEvents`](BaseEvents.md).[`onHide`](BaseEvents.md#onhide)
