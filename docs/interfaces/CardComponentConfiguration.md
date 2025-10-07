# Interface: CardComponentConfiguration

Defined in: [src/definitions/components/card.ts:30](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/components/card.ts#L30)

Configuration options specific to the Card component.

## See

 - [Android](https://docs.adyen.com/payment-methods/cards/android-component/#components-configuration)
 - [iOS](https://docs.adyen.com/payment-methods/cards/ios-component/#optional-configuration)

## Properties

### showsHolderNameField?

```ts
optional showsHolderNameField: boolean;
```

Defined in: [src/definitions/components/card.ts:35](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/components/card.ts#L35)

Display cardholder name input field

#### Default

```ts
false
```

***

### showsSecurityCodeField?

```ts
optional showsSecurityCodeField: boolean;
```

Defined in: [src/definitions/components/card.ts:41](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/components/card.ts#L41)

Display security code input field

#### Default

```ts
true
```

***

### showsStorePaymentMethodField?

```ts
optional showsStorePaymentMethodField: boolean;
```

Defined in: [src/definitions/components/card.ts:47](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/components/card.ts#L47)

Display store payment method checkbox

#### Default

```ts
false
```

***

### allowedCardTypes?

```ts
optional allowedCardTypes: string[];
```

Defined in: [src/definitions/components/card.ts:54](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/components/card.ts#L54)

Supported card types
Same as `supportedCardTypes` on Android

#### Default

`AnyCardPaymentMethod`

***

### showsSubmitButton?

```ts
optional showsSubmitButton: boolean;
```

Defined in: [src/definitions/components/card.ts:60](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/components/card.ts#L60)

Display submit button

#### Default

```ts
true
```

***

### shopperReference?

```ts
optional shopperReference: string;
```

Defined in: [src/definitions/components/card.ts:65](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/components/card.ts#L65)

Your unique shopper reference.

***

### billingAddress?

```ts
optional billingAddress: {
  requirementPolicy: boolean;
  mode: "none" | "full" | "postalCode";
  countryCodes?: string[];
};
```

Defined in: [src/definitions/components/card.ts:70](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/components/card.ts#L70)

Billing address configuration

#### requirementPolicy

```ts
requirementPolicy: boolean;
```

Set to `true` to collect the shopper's billing address and mark the fields as required.

##### Default

```ts
false
```

#### mode

```ts
mode: "none" | "full" | "postalCode";
```

Sets which billing address fields to show in the payment form. Possible values:
 - full: show all billing address fields.
 - none: do not show billing address fields.
 - postalCode: show only the postal code field.

##### Default

`none`

#### countryCodes?

```ts
optional countryCodes: string[];
```

Array of allowed country codes for the billing address. For example, `['US', 'CA', 'BR']`.

##### Default

```ts
all countries supported by Adyen
```

***

### koreanAuthenticationMode?

```ts
optional koreanAuthenticationMode: "auto" | "hide" | "show";
```

Defined in: [src/definitions/components/card.ts:100](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/components/card.ts#L100)

For Korean cards, sets if security fields show in the payment form. Possible values:
  - show: show the fields.
  - hide: do not show the fields.
  - auto: the field appears for cards issued in South Korea.

#### Default

`auto`

***

### socialSecurityNumberMode?

```ts
optional socialSecurityNumberMode: "auto" | "hide" | "show";
```

Defined in: [src/definitions/components/card.ts:109](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/components/card.ts#L109)

For Brazilian cards, sets if the CPF/CNPJ social security number field shows in the payment form. Possible values:
  - show: show the field.
  - hide: do not show the field.
  - auto: the field appears based on the detected card number.

#### Default

`auto`

***

### localizationParameters?

```ts
optional localizationParameters: {
  languageOverride?: string;
  tableName?: string;
  keySeparator?: string;
};
```

Defined in: [src/definitions/components/card.ts:112](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/components/card.ts#L112)

Localization parameters for the component

#### languageOverride?

```ts
optional languageOverride: string;
```

ISO 639-1 language code

##### Default

```ts
not-set, defaults to device language
```

#### tableName?

```ts
optional tableName: string;
```

iOS only

##### See

https://adyen.github.io/adyen-ios/5.20.1/documentation/adyen/localization/

#### keySeparator?

```ts
optional keySeparator: string;
```

iOS only

##### See

https://adyen.github.io/adyen-ios/5.20.1/documentation/adyen/localization/
