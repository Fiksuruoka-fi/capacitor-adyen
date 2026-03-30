---
name: capacitor-adyen-payment-flow
description: Implement the payment lifecycle with @foodello/capacitor-adyen — fetching payment methods, presenting the card component, handling submit/error/hide events, and forwarding payment data to a backend. Use when a user is wiring up the full payment flow, handling Adyen events in their app, or asking about the correct order of operations.
---

# Payment Flow with @foodello/capacitor-adyen

The plugin owns the native presentation layer. Your app owns the payment lifecycle: fetching payment methods, forwarding data to your backend, and calling the Adyen `/payments` API.

## Required call order

```
1. Fetch payment methods from your backend  (/paymentMethods Adyen API)
2. Adyen.setCurrentPaymentMethods({ paymentMethodsJson })   ← native only
3. Adyen.presentCardComponent(options)
4. Listen: onCardSubmit  → update UI with card details (lastFour, brand)
5. Listen: onSubmit      → forward paymentMethod data to your backend
6. Backend calls Adyen /payments → returns resultCode
7. Adyen.hideComponent()         ← call after processing, or on onHide
```

**`setCurrentPaymentMethods` must succeed before any `present*` call.** Both iOS and Android throw `"Payment methods not set"` if you skip it. Only call it on native — it throws `unavailable` on web.

## Minimal implementation

```typescript
import { Capacitor } from '@capacitor/core';
import { Adyen, type PaymentSubmitEventData } from '@foodello/capacitor-adyen';

async function startCardPayment() {
  // 1. Fetch from your backend
  const paymentMethodsJson = await fetch('/api/payment-methods').then(r => r.json());

  // 2. Set methods on native (skip on web — use Adyen Web SDK directly there)
  if (Capacitor.isNativePlatform()) {
    await Adyen.setCurrentPaymentMethods({ paymentMethodsJson });
  }

  // 3. Set up listeners before presenting
  const submitListener = await Adyen.addListener('onSubmit', handleSubmit);
  const errorListener  = await Adyen.addListener('onError', handleError);
  const hideListener   = await Adyen.addListener('onHide', () => cleanup());

  // 4. Present the card sheet
  await Adyen.presentCardComponent({
    amount: 1000,          // minor units (e.g. cents)
    currencyCode: 'EUR',
    countryCode: 'NL',
  });

  function cleanup() {
    submitListener.remove();
    errorListener.remove();
    hideListener.remove();
  }
}

async function handleSubmit(data: PaymentSubmitEventData) {
  try {
    // Forward to your backend, which calls Adyen /payments
    const result = await fetch('/api/payments', {
      method: 'POST',
      body: JSON.stringify(data.paymentMethod),
    }).then(r => r.json());

    if (result.resultCode === 'Authorised') {
      await Adyen.hideComponent();
      // navigate to success screen
    } else {
      await Adyen.hideComponent();
      // show failure
    }
  } catch (err) {
    await Adyen.hideComponent();
    // handle network error
  }
}

function handleError(data: { message: string }) {
  console.error('Adyen error:', data.message);
  Adyen.hideComponent();
}
```

## All events

| Event | Payload | When it fires |
|---|---|---|
| `onSubmit` | `PaymentSubmitEventData` | User taps the pay button and the form is valid |
| `onCardSubmit` | `{ lastFour: string, finalBIN: string }` | Same submit, carries card display info |
| `onCardChange` | `CardChangeEventData` | Card number changes (brand detection, BIN updates) |
| `onAdditionalDetails` | raw object | 3DS or redirect additional details required |
| `onError` | `{ message: string }` | SDK or network error inside the component |
| `onShow` | — | Sheet appeared |
| `onHide` | `{ reason: 'user_gesture' }` | Sheet dismissed (by user or by `hideComponent()`) |

## Listener cleanup

Listeners survive `hideComponent()` — they persist until explicitly removed. Always store the `PluginListenerHandle` and call `.remove()` when the component is no longer needed, or you will accumulate duplicate listeners across multiple payment sessions.

```typescript
const handle = await Adyen.addListener('onSubmit', handler);
// later:
handle.remove();
```

## Handling 3DS / additional details

If your `/payments` response includes an `action` object, Adyen may fire `onAdditionalDetails` after the shopper completes a redirect or 3DS challenge. Forward this data to your backend's `/payments/details` endpoint:

```typescript
Adyen.addListener('onAdditionalDetails', async (data) => {
  const result = await fetch('/api/payments/details', {
    method: 'POST',
    body: JSON.stringify(data),
  }).then(r => r.json());

  await Adyen.hideComponent();
});
```

## Using the extended Card component (web + native)

For apps using Adyen Web SDK alongside the plugin, use the bundled `Card` class instead of the stock `@adyen/adyen-web` card. It auto-detects the platform and presents the native sheet on device while rendering the standard Adyen Web form in a browser.

```typescript
import { AdyenCheckout } from '@adyen/adyen-web';
import { Adyen, Card, type ExtendedCardConfiguration } from '@foodello/capacitor-adyen';

const checkout = await AdyenCheckout({
  environment: 'test',
  clientKey: 'test_XXXX',
  countryCode: 'NL',
  paymentMethodsResponse: paymentMethodsJson,
  onSubmit: (state, component, actions) => {
    // web-only path — on native, use Adyen.addListener('onSubmit') instead
    actions.resolve({ resultCode: 'Authorised', type: 'scheme' });
  },
  onError: console.error,
});

// Set methods on native
if (Capacitor.isNativePlatform()) {
  await Adyen.setCurrentPaymentMethods({ paymentMethodsJson });
}

const cardConfig: ExtendedCardConfiguration = {
  isDev: true,             // optional: enables debug logging + window.adyenCard
  testNativePresentation: false,
};

const card = new Card(checkout, cardConfig);
card.mount('#card-container');
// On native: automatically calls presentCardComponent and renders CardDetails UI
// On web:    renders the standard Adyen card form
```

## `presentCardComponent` options

All fields are optional. When omitted, Adyen uses the values already set on the session or payment methods response.

```typescript
await Adyen.presentCardComponent({
  amount: 1000,
  currencyCode: 'EUR',
  countryCode: 'NL',
  configuration: {
    showsHolderNameField: false,
    showsSecurityCodeField: true,
    showsStorePaymentMethodField: false,
    allowedCardTypes: ['mc', 'visa'],
    showsSubmitButton: true,
    billingAddress: {
      mode: 'none',            // 'none' | 'full' | 'postalCode'
      requirementPolicy: false,
    },
  },
  viewOptions: {
    title: 'Pay',
    showsCloseButton: true,
    titleBackgroundColor: '#FFFFFF',
    titleColor: '#000000',
  },
});
```

## What `onSubmit` payload looks like

```json
{
  "paymentMethod": {
    "type": "scheme",
    "encryptedCardNumber": "...",
    "encryptedExpiryMonth": "...",
    "encryptedExpiryYear": "...",
    "encryptedSecurityCode": "...",
    "brand": "visa"
  },
  "componentType": "card",
  "browserInfo": { "userAgent": "..." },
  "amount": { "value": 1000, "currency": "EUR" },
  "storePaymentMethod": false
}
```

Forward `paymentMethod` (and optionally `browserInfo`, `amount`) to your backend's `/payments` call.
