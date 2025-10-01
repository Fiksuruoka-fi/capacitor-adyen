# Interface: BaseEvents

Defined in: [index.ts:61](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L61)

Base events available for all Adyen components.

## Extended by

- [`AdyenEvents`](AdyenEvents.md)

## Properties

### onSubmit()

```ts
onSubmit: (data) => void;
```

Defined in: [index.ts:74](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L74)

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

Defined in: [index.ts:89](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L89)

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

Defined in: [index.ts:104](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L104)

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

Defined in: [index.ts:119](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/index.ts#L119)

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
