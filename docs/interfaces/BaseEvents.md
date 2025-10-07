# Interface: BaseEvents

Defined in: [src/definitions/index.ts:77](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/4ec12391e08800da9ed0c6dd7ddc94c6929d4f96/src/definitions/index.ts#L77)

Base events available for all Adyen components.

## Extended by

- [`AdyenEvents`](AdyenEvents.md)

## Properties

### onAdditionalDetails()

```ts
onAdditionalDetails: (data) => void;
```

Defined in: [src/definitions/index.ts:90](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/4ec12391e08800da9ed0c6dd7ddc94c6929d4f96/src/definitions/index.ts#L90)

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

***

### onSubmit()

```ts
onSubmit: (data) => void;
```

Defined in: [src/definitions/index.ts:104](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/4ec12391e08800da9ed0c6dd7ddc94c6929d4f96/src/definitions/index.ts#L104)

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

***

### onError()

```ts
onError: (data) => void;
```

Defined in: [src/definitions/index.ts:119](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/4ec12391e08800da9ed0c6dd7ddc94c6929d4f96/src/definitions/index.ts#L119)

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

***

### onShow()

```ts
onShow: () => void;
```

Defined in: [src/definitions/index.ts:134](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/4ec12391e08800da9ed0c6dd7ddc94c6929d4f96/src/definitions/index.ts#L134)

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

***

### onHide()

```ts
onHide: (data) => void;
```

Defined in: [src/definitions/index.ts:149](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/4ec12391e08800da9ed0c6dd7ddc94c6929d4f96/src/definitions/index.ts#L149)

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
