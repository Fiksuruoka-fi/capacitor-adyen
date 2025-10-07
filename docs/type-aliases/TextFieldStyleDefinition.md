# Type Alias: TextFieldStyleDefinition

```ts
type TextFieldStyleDefinition = {
  title?: TextStyleDefinition;
  titleColor?: string;
  titleFont?: FontDefinition;
  text?: TextStyleDefinition;
  textColor?: string;
  textFont?: FontDefinition;
  placeholder?: TextStyleDefinition;
  placeholderColor?: string;
  placeholderFont?: FontDefinition;
  icon?: {
     tintColor?: string;
     backgroundColor?: string;
     borderColor?: string;
     borderWidth?: number;
     cornerRadius?: number;
  };
  tintColor?: string;
  separatorColor?: string;
  backgroundColor?: string;
  errorColor?: string;
};
```

Defined in: [src/definitions/styles.ts:59](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L59)

Describes styling for a text field in the form. This includes styling
for the title label, user input text, placeholder text, and trailing icon.

## Properties

### title?

```ts
optional title: TextStyleDefinition;
```

Defined in: [src/definitions/styles.ts:61](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L61)

Styling for the field's title label.

***

### titleColor?

```ts
optional titleColor: string;
```

Defined in: [src/definitions/styles.ts:63](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L63)

Colour of the title label (legacy shortcut).

***

### titleFont?

```ts
optional titleFont: FontDefinition;
```

Defined in: [src/definitions/styles.ts:65](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L65)

Font used for the title label (legacy shortcut).

***

### text?

```ts
optional text: TextStyleDefinition;
```

Defined in: [src/definitions/styles.ts:68](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L68)

Styling for the user-entered text.

***

### textColor?

```ts
optional textColor: string;
```

Defined in: [src/definitions/styles.ts:70](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L70)

Colour of the user-entered text (legacy shortcut).

***

### textFont?

```ts
optional textFont: FontDefinition;
```

Defined in: [src/definitions/styles.ts:72](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L72)

Font for the user-entered text (legacy shortcut).

***

### placeholder?

```ts
optional placeholder: TextStyleDefinition;
```

Defined in: [src/definitions/styles.ts:75](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L75)

Styling for the placeholder text.

***

### placeholderColor?

```ts
optional placeholderColor: string;
```

Defined in: [src/definitions/styles.ts:77](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L77)

Colour of the placeholder text (legacy shortcut).

***

### placeholderFont?

```ts
optional placeholderFont: FontDefinition;
```

Defined in: [src/definitions/styles.ts:79](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L79)

Font for the placeholder text (legacy shortcut).

***

### icon?

```ts
optional icon: {
  tintColor?: string;
  backgroundColor?: string;
  borderColor?: string;
  borderWidth?: number;
  cornerRadius?: number;
};
```

Defined in: [src/definitions/styles.ts:82](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L82)

Styling for the trailing icon.

#### tintColor?

```ts
optional tintColor: string;
```

Tint colour of the icon.

#### backgroundColor?

```ts
optional backgroundColor: string;
```

Background colour behind the icon.

#### borderColor?

```ts
optional borderColor: string;
```

Border colour of the icon container.

#### borderWidth?

```ts
optional borderWidth: number;
```

Border width of the icon container.

#### cornerRadius?

```ts
optional cornerRadius: number;
```

Corner radius of the icon container.

***

### tintColor?

```ts
optional tintColor: string;
```

Defined in: [src/definitions/styles.ts:96](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L96)

Tint colour applied to the text field (cursor/accent).

***

### separatorColor?

```ts
optional separatorColor: string;
```

Defined in: [src/definitions/styles.ts:98](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L98)

Colour of the separator line beneath the text field.

***

### backgroundColor?

```ts
optional backgroundColor: string;
```

Defined in: [src/definitions/styles.ts:100](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L100)

Background colour of the entire text field cell.

***

### errorColor?

```ts
optional errorColor: string;
```

Defined in: [src/definitions/styles.ts:102](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/ec0298b54122e01d83010c917a8a16a8b41bbdb4/src/definitions/styles.ts#L102)

Colour used to highlight error states.
