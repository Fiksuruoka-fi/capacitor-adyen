# Type Alias: FormComponentStyle

```ts
type FormComponentStyle = {
  backgroundColor?: string;
  tintColor?: string;
  separatorColor?: string;
  header?: TextStyleDefinition;
  textField?: TextFieldStyleDefinition;
  switch?: SwitchStyleDefinition;
  toggle?: SwitchStyleDefinition;
  hint?: TextStyleDefinition;
  footnote?: TextStyleDefinition;
  linkText?: TextStyleDefinition;
  button?: ButtonStyleDefinition;
  mainButton?: ButtonStyleDefinition;
  secondaryButton?: ButtonStyleDefinition;
};
```

Defined in: [src/definitions/styles.ts:148](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L148)

Combined style configuration for forms. Includes top-level colours and
nested sub-styles for various form elements. All keys are optional and
unknown keys are ignored.

## Properties

### backgroundColor?

```ts
optional backgroundColor: string;
```

Defined in: [src/definitions/styles.ts:150](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L150)

Background colour applied to the entire form.

***

### tintColor?

```ts
optional tintColor: string;
```

Defined in: [src/definitions/styles.ts:152](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L152)

Tint colour applied to accent elements within the form.

***

### separatorColor?

```ts
optional separatorColor: string;
```

Defined in: [src/definitions/styles.ts:154](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L154)

Colour of separators between form rows.

***

### header?

```ts
optional header: TextStyleDefinition;
```

Defined in: [src/definitions/styles.ts:157](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L157)

Styling for the header text (section title).

***

### textField?

```ts
optional textField: TextFieldStyleDefinition;
```

Defined in: [src/definitions/styles.ts:159](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L159)

Styling for text input fields.

***

### switch?

```ts
optional switch: SwitchStyleDefinition;
```

Defined in: [src/definitions/styles.ts:162](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L162)

Styling for toggle rows. Both `switch` and `toggle` keys are supported.

***

### toggle?

```ts
optional toggle: SwitchStyleDefinition;
```

Defined in: [src/definitions/styles.ts:163](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L163)

***

### hint?

```ts
optional hint: TextStyleDefinition;
```

Defined in: [src/definitions/styles.ts:166](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L166)

Styling for hint labels (usually under a field).

***

### footnote?

```ts
optional footnote: TextStyleDefinition;
```

Defined in: [src/definitions/styles.ts:168](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L168)

Styling for footnote labels at the bottom of the form.

***

### linkText?

```ts
optional linkText: TextStyleDefinition;
```

Defined in: [src/definitions/styles.ts:170](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L170)

Styling for inline link text in informational messages.

***

### button?

```ts
optional button: ButtonStyleDefinition;
```

Defined in: [src/definitions/styles.ts:173](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L173)

Styling for the primary action button. You may use either `button` or `mainButton`.

***

### mainButton?

```ts
optional mainButton: ButtonStyleDefinition;
```

Defined in: [src/definitions/styles.ts:175](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L175)

Styling for the primary action button. Same as `button`.

***

### secondaryButton?

```ts
optional secondaryButton: ButtonStyleDefinition;
```

Defined in: [src/definitions/styles.ts:177](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L177)

Styling for a secondary action button.
