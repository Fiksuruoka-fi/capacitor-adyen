# Interface: ExtendedCardConfiguration

Defined in: [src/definitions/components/card.ts:331](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/4ec12391e08800da9ed0c6dd7ddc94c6929d4f96/src/definitions/components/card.ts#L331)

Extended Card component configuration including native options

## See

https://docs.adyen.com/payment-methods/cards/web-component/#optional-configuration

## Extends

- `CardConfiguration`

## Properties

### order?

```ts
optional order: Order;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:627

#### Inherited from

```ts
CardConfiguration.order
```

***

### modules?

```ts
optional modules: {
  srPanel?: SRPanel;
  analytics?: AnalyticsModule;
  resources?: Resources;
  risk?: RiskElement;
};
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:628

#### srPanel?

```ts
optional srPanel: SRPanel;
```

#### analytics?

```ts
optional analytics: AnalyticsModule;
```

#### resources?

```ts
optional resources: Resources;
```

#### risk?

```ts
optional risk: RiskElement;
```

#### Inherited from

```ts
CardConfiguration.modules
```

***

### isDropin?

```ts
optional isDropin: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:634

#### Inherited from

```ts
CardConfiguration.isDropin
```

***

### environment?

```ts
optional environment: string;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:696

#### Inherited from

```ts
CardConfiguration.environment
```

***

### session?

```ts
optional session: Session;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:697

#### Inherited from

```ts
CardConfiguration.session
```

***

### onComplete()?

```ts
optional onComplete: (state, element) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:698

#### Parameters

##### state

`any`

##### element

`UIElement`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onComplete
```

***

### isInstantPayment?

```ts
optional isInstantPayment: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:699

#### Inherited from

```ts
CardConfiguration.isInstantPayment
```

***

### icon?

```ts
optional icon: string;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:723

#### Inherited from

```ts
CardConfiguration.icon
```

***

### amount?

```ts
optional amount: PaymentAmount;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:724

#### Inherited from

```ts
CardConfiguration.amount
```

***

### secondaryAmount?

```ts
optional secondaryAmount: PaymentAmountExtended;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:725

#### Inherited from

```ts
CardConfiguration.secondaryAmount
```

***

### showPayButton?

```ts
optional showPayButton: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:730

Show/Hide pay button

#### Default Value

```ts
true
```

#### Inherited from

```ts
CardConfiguration.showPayButton
```

***

### originalAction?

```ts
optional originalAction: PaymentAction;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:757

Reference to the action object found in a /payments response. This, in most cases, is passed on to the onActionHandled callback

#### Inherited from

```ts
CardConfiguration.originalAction
```

***

### autoFocus?

```ts
optional autoFocus: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:775

Automatically shift the focus from one field to another. Usually happens from a valid Expiry Date field to the Security Code field,
but some BINS also allow us to know that the PAN is complete, in which case we can shift focus to the date field

#### Default Value

`true`

- merchant set config option

#### Inherited from

```ts
CardConfiguration.autoFocus
```

***

### billingAddressAllowedCountries?

```ts
optional billingAddressAllowedCountries: string[];
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:780

Config t olimit the countries that will show in the country dropdown
- merchant set config option

#### Inherited from

```ts
CardConfiguration.billingAddressAllowedCountries
```

***

### billingAddressMode?

```ts
optional billingAddressMode: "none" | "full" | "partial";
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:787

If billingAddressRequired is set to true, you can set this to partial to require the shopper's postal code instead of the full address.

#### Default Value

```ts
full

- merchant set config option
```

#### Inherited from

```ts
CardConfiguration.billingAddressMode
```

***

### billingAddressRequired?

```ts
optional billingAddressRequired: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:794

Show Address fields

#### Default Value

`false`

- merchant set config option

#### Inherited from

```ts
CardConfiguration.billingAddressRequired
```

***

### billingAddressRequiredFields?

```ts
optional billingAddressRequiredFields: string[];
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:799

Config to specify which address field are required
- merchant set config option

#### Inherited from

```ts
CardConfiguration.billingAddressRequiredFields
```

***

### brandsConfiguration?

```ts
optional brandsConfiguration: CardBrandsConfiguration;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:816

Configuration specific to brands
- merchant set config option

#### Inherited from

```ts
CardConfiguration.brandsConfiguration
```

***

### challengeWindowSize?

```ts
optional challengeWindowSize: "01" | "02" | "03" | "04" | "05";
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:830

Defines the size of the challenge Component

01: [250px, 400px]
02: [390px, 400px]
03: [500px, 600px]
04: [600px, 400px]
05: [100%, 100%]

#### Default Value

```ts
'02'

- merchant set config option
```

#### Inherited from

```ts
CardConfiguration.challengeWindowSize
```

***

### clickToPayConfiguration?

```ts
optional clickToPayConfiguration: ClickToPayProps;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:835

Configuration for Click to Pay
- merchant set config option

#### Inherited from

```ts
CardConfiguration.clickToPayConfiguration
```

***

### fastlaneConfiguration?

```ts
optional fastlaneConfiguration: FastlaneSignupConfiguration;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:839

Configuration for displaying the Fastlane consent UI.

#### Inherited from

```ts
CardConfiguration.fastlaneConfiguration
```

***

### data?

```ts
optional data: {
  holderName?: string;
  billingAddress?: Partial<AddressData>;
};
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:854

Object that contains placeholder information that you can use to prefill fields.
- merchant set config option

#### holderName?

```ts
optional holderName: string;
```

#### billingAddress?

```ts
optional billingAddress: Partial<AddressData>;
```

#### Inherited from

```ts
CardConfiguration.data
```

***

### disableIOSArrowKeys?

```ts
optional disableIOSArrowKeys: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:870

Turn on the procedure to force the arrow keys on an iOS soft keyboard to always be disabled

#### Default Value

`false`

- merchant set config option

#### Inherited from

```ts
CardConfiguration.disableIOSArrowKeys
```

***

### disclaimerMessage?

```ts
optional disclaimerMessage: DisclaimerMsgObject;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:875

Object to configure the message and text for a disclaimer message, added after the Card input fields
- merchant set config option

#### Inherited from

```ts
CardConfiguration.disclaimerMessage
```

***

### doBinLookup?

```ts
optional doBinLookup: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:882

Allow binLookup process to occur

#### Default Value

`true`

- merchant set config option

#### Inherited from

```ts
CardConfiguration.doBinLookup
```

***

### enableStoreDetails?

```ts
optional enableStoreDetails: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:887

Config option related to whether we set storePaymentMethod in the card data, and showing/hiding the "store details" checkbox
- merchant set config option

#### Inherited from

```ts
CardConfiguration.enableStoreDetails
```

***

### exposeExpiryDate?

```ts
optional exposeExpiryDate: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:897

Allows SF to return an unencrypted expiryDate
- merchant set config option

#### Inherited from

```ts
CardConfiguration.exposeExpiryDate
```

***

### forceCompat?

```ts
optional forceCompat: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:902

Force securedFields to use the 'compat' version of JWE. (Use case: running custom http:// test environment
- merchant set config option

#### Inherited from

```ts
CardConfiguration.forceCompat
```

***

### hasHolderName?

```ts
optional hasHolderName: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:919

Show/hide the card holder name field
- merchant set config option

#### Inherited from

```ts
CardConfiguration.hasHolderName
```

***

### hideCVC?

```ts
optional hideCVC: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:929

Show/hide the Security Code field
- merchant set config option

#### Inherited from

```ts
CardConfiguration.hideCVC
```

***

### holderNameRequired?

```ts
optional holderNameRequired: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:934

Whether the card holder name field will be required
- merchant set config option

#### Inherited from

```ts
CardConfiguration.holderNameRequired
```

***

### installmentOptions?

```ts
optional installmentOptions: InstallmentOptions;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:944

Configure the installment options for the card
- merchant set config option

#### Inherited from

```ts
CardConfiguration.installmentOptions
```

***

### keypadFix?

```ts
optional keypadFix: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:951

Implements a workaround for iOS/Safari bug where keypad doesn't retract when SF paymentMethod is no longer active

#### Default Value

`true`

- merchant set config option

#### Inherited from

```ts
CardConfiguration.keypadFix
```

***

### legacyInputMode?

```ts
optional legacyInputMode: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:963

For some scenarios make the card input fields (PAN, Expiry Date, Security Code) have type="tel" rather than type="text" inputmode="numeric"

#### Default Value

`false`

- merchant set config option

#### Inherited from

```ts
CardConfiguration.legacyInputMode
```

***

### maskSecurityCode?

```ts
optional maskSecurityCode: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:970

Adds type="password" to the Security code input field, causing its value to be masked

#### Default Value

`false`

- merchant set config option

#### Inherited from

```ts
CardConfiguration.maskSecurityCode
```

***

### minimumExpiryDate?

```ts
optional minimumExpiryDate: string;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:976

Specify the minimum expiry date that will be considered valid

- merchant set config option

#### Inherited from

```ts
CardConfiguration.minimumExpiryDate
```

***

### onAddressLookup?

```ts
optional onAddressLookup: OnAddressLookupType;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:987

Function used to perform 3rd party Address lookup
- merchant set config option

#### Inherited from

```ts
CardConfiguration.onAddressLookup
```

***

### onAddressSelected?

```ts
optional onAddressSelected: OnAddressSelectedType;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:992

Function used to handle the selected address from 3rd party Address lookup
- merchant set config option

#### Inherited from

```ts
CardConfiguration.onAddressSelected
```

***

### onBinLookup()?

```ts
optional onBinLookup: (event) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:997

After binLookup call - provides the brand(s) we detect the user is entering, and if we support the brand(s)
- merchant set config option

#### Parameters

##### event

`CardBinLookupData`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onBinLookup
```

***

### onBinValue()?

```ts
optional onBinValue: (event) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1002

Provides the BIN Number of the card (up to 6 digits), called as the user types in the PAN.
- merchant set config option

#### Parameters

##### event

`CardBinValueData`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onBinValue
```

***

### onBlur()?

```ts
optional onBlur: (event) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1007

Called when a field loses focus.
- merchant set config option

#### Parameters

##### event

`CardFocusData` | `ComponentFocusObject`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onBlur
```

***

### onBrand()?

```ts
optional onBrand: (event) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1012

Called once we detect the card brand.
- merchant set config option

#### Parameters

##### event

`CardBrandData`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onBrand
```

***

### onConfigSuccess()?

```ts
optional onConfigSuccess: (event) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1017

Called once the card input fields are ready to use.
- merchant set config option

#### Parameters

##### event

`CardConfigSuccessData`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onConfigSuccess
```

***

### onAllValid()?

```ts
optional onAllValid: (event) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1022

Called when *all* the securedFields becomes valid
 Also called again if one of the fields moves out of validity.

#### Parameters

##### event

`CardAllValidData`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onAllValid
```

***

### onFieldValid()?

```ts
optional onFieldValid: (event) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1028

Called when a field becomes valid and also if a valid field changes and becomes invalid.
For the card number field, it returns the last 4 digits of the card number.
- merchant set config option

#### Parameters

##### event

`CardFieldValidData`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onFieldValid
```

***

### onFocus()?

```ts
optional onFocus: (event) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1033

Called when a field gains focus.
- merchant set config option

#### Parameters

##### event

`CardFocusData` | `ComponentFocusObject`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onFocus
```

***

### onLoad()?

```ts
optional onLoad: (event) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1038

Called once all the card input fields have been created but are not yet ready to use.
- merchant set config option

#### Parameters

##### event

`CardLoadData`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onLoad
```

***

### placeholders?

```ts
optional placeholders: Partial<Record<PlaceholderKeys, string>>;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1043

Configure placeholder text for holderName, cardNumber, expirationDate, securityCode and password.
- merchant set config option

#### Inherited from

```ts
CardConfiguration.placeholders
```

***

### positionHolderNameOnTop?

```ts
optional positionHolderNameOnTop: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1050

Position holder name above card number field (instead of having it after the security code field)

#### Default Value

`false`

- merchant set config option

#### Inherited from

```ts
CardConfiguration.positionHolderNameOnTop
```

***

### showBrandIcon?

```ts
optional showBrandIcon: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1057

Show/hide the brand logo when the card brand has been recognized

#### Default Value

`true`

- merchant set config option

#### Inherited from

```ts
CardConfiguration.showBrandIcon
```

***

### showContextualElement?

```ts
optional showContextualElement: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1064

Show/hide the contextual text under each form field. The contextual text is to assist shoppers filling in the payment form.

#### Default Value

`true`

- merchant set config option

#### Inherited from

```ts
CardConfiguration.showContextualElement
```

***

### showInstallmentAmounts?

```ts
optional showInstallmentAmounts: boolean;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1071

Set whether to show installments broken down into amounts or months

#### Default Value

`true`

- merchant set config option

#### Inherited from

```ts
CardConfiguration.showInstallmentAmounts
```

***

### styles?

```ts
optional styles: StylesObject;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:1086

Object to configure the styling of the inputs in the iframes that are used to present the PAN, Expiry Date & Security Code fields
- merchant set config option

#### Inherited from

```ts
CardConfiguration.styles
```

***

### beforeRedirect()?

```ts
optional beforeRedirect: (resolve, reject, redirectData) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:5981

Called before the page redirect happens.
Allows you to perform any sort of action before redirecting the shopper to another page.

#### Parameters

##### resolve

() => `void`

##### reject

() => `void`

##### redirectData

###### url

`string`

###### method

`string`

###### data?

`any`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.beforeRedirect
```

***

### beforeSubmit()?

```ts
optional beforeSubmit: (state, component, actions) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:5996

Called when the shopper selects the Pay button (it only works on Sessions flow)

Allows you to add details which will be sent in the payment request to Adyen's servers.
For example, you can add shopper details like 'billingAddress', 'deliveryAddress', 'shopperEmail' or 'shopperName'

#### Parameters

##### state

`PaymentData`

##### component

`UIElement`

##### actions

`BeforeSubmitActions`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.beforeSubmit
```

***

### onPaymentCompleted()?

```ts
optional onPaymentCompleted: (data, component?) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:6005

Called when the payment succeeds.

The first parameter is the sessions response (when using sessions flow), or the result code.

#### Parameters

##### data

`PaymentCompletedData`

##### component?

`UIElement`\<`UIElementProps`\>

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onPaymentCompleted
```

***

### onPaymentFailed()?

```ts
optional onPaymentFailed: (data?, component?) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:6015

Called when the payment fails.

The first parameter is populated when merchant is using sessions, or when the payment was rejected
with an object. (Ex: 'action.reject(obj)' ). Otherwise, it will be empty.

#### Parameters

##### data?

`PaymentFailedData`

session response or resultCode. It can also be undefined if payment was rejected without argument ('action.reject()')

##### component?

`UIElement`\<`UIElementProps`\>

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onPaymentFailed
```

***

### onSubmit()?

```ts
optional onSubmit: (state, component, actions) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:6026

Callback used in the Advanced flow to perform the /payments API call

The payment response must be passed to the 'resolve' function, even if the payment wasn't authorized (Ex: resultCode = Refused).
The 'reject' should be used only if a critical error occurred.

#### Parameters

##### state

`SubmitData`

##### component

`UIElement`

##### actions

`SubmitActions`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onSubmit
```

***

### onAdditionalDetails()?

```ts
optional onAdditionalDetails: (state, component, actions) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:6037

Callback used in the Advanced flow to perform the /payments/details API call.

The payment response must be passed to the 'resolve' function, even if the payment wasn't authorized (Ex: resultCode = Refused).
The 'reject' should be used only if a critical error occurred.

#### Parameters

##### state

`AdditionalDetailsData`

##### component

`UIElement`

Component submitting details. It is undefined when using checkout.submitDetails()

##### actions

`AdditionalDetailsActions`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onAdditionalDetails
```

***

### onActionHandled()?

```ts
optional onActionHandled: (actionHandled) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:6053

Callback called when an action (for example a QR code or 3D Secure 2 authentication screen) is shown to the shopper.

#### Parameters

##### actionHandled

`ActionHandledReturnObject`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onActionHandled
```

***

### onChange()?

```ts
optional onChange: (state, component) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:6054

#### Parameters

##### state

`OnChangeData`

##### component

`UIElement`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onChange
```

***

### onError()?

```ts
optional onError: (error, component?) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:6063

Callback called in two different scenarios:
- when a critical error happened (network error; implementation error; script failed to load)
- when the shopper cancels the payment flow in payment methods that have an overlay (GooglePay, PayPal, ApplePay)

#### Parameters

##### error

`AdyenCheckoutError`

##### component?

`UIElement`\<`UIElementProps`\>

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onError
```

***

### onEnterKeyPressed()?

```ts
optional onEnterKeyPressed: (activeElement, component) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:6070

Called when a Component detects, or is told by a SecuredField, that the Enter key has been pressed.
- merchant set config option

#### Parameters

##### activeElement

`Element`

##### component

`UIElement`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onEnterKeyPressed
```

***

### onPaymentMethodsRequest()?

```ts
optional onPaymentMethodsRequest: (data, actions) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:6080

Callback called when it is required to fetch/update the payment methods list.
It is currently used mainly on Giftcard flow (Partial orders), since the payment method list might change depending on the amount left to be paid

The /paymentMethods response must be passed to the 'resolve' function

#### Parameters

##### data

`PaymentMethodsRequestData`

##### actions

###### resolve

(`response`) => `void`

###### reject

() => `void`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onPaymentMethodsRequest
```

***

### onOrderUpdated()?

```ts
optional onOrderUpdated: (data) => void;
```

Defined in: node\_modules/@adyen/adyen-web/dist/es/index.d.ts:6090

Called when the gift card balance is less than the transaction amount.
Returns an Order object that includes the remaining amount to be paid.
https://docs.adyen.com/payment-methods/gift-cards/web-component?tab=config-sessions_1

#### Parameters

##### data

###### order

`Order`

#### Returns

`void`

#### Inherited from

```ts
CardConfiguration.onOrderUpdated
```

***

### nativeCard?

```ts
optional nativeCard: NativeCardConfiguration;
```

Defined in: [src/definitions/components/card.ts:332](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/4ec12391e08800da9ed0c6dd7ddc94c6929d4f96/src/definitions/components/card.ts#L332)

***

### isDev?

```ts
optional isDev: boolean;
```

Defined in: [src/definitions/components/card.ts:333](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/4ec12391e08800da9ed0c6dd7ddc94c6929d4f96/src/definitions/components/card.ts#L333)

***

### testNativePresentation?

```ts
optional testNativePresentation: boolean;
```

Defined in: [src/definitions/components/card.ts:334](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/4ec12391e08800da9ed0c6dd7ddc94c6929d4f96/src/definitions/components/card.ts#L334)
