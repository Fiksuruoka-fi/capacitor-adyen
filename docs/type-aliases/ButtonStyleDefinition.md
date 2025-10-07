# Type Alias: ButtonStyleDefinition

```ts
type ButtonStyleDefinition = {
  font?: FontDefinition;
  textColor?: string;
  backgroundColor?: string;
  cornerRadius?: number;
};
```

Defined in: [src/definitions/styles.ts:131](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/styles.ts#L131)

Defines the styling for a button. These definitions map to
`FormButtonItemStyle.main` in the iOS SDK. All fields are optional.

## Properties

### font?

```ts
optional font: FontDefinition;
```

Defined in: [src/definitions/styles.ts:133](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/styles.ts#L133)

Font used for the button's title.

***

### textColor?

```ts
optional textColor: string;
```

Defined in: [src/definitions/styles.ts:135](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/styles.ts#L135)

Colour of the button title text.

***

### backgroundColor?

```ts
optional backgroundColor: string;
```

Defined in: [src/definitions/styles.ts:137](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/styles.ts#L137)

Main background colour of the button.

***

### cornerRadius?

```ts
optional cornerRadius: number;
```

Defined in: [src/definitions/styles.ts:139](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/styles.ts#L139)

Corner radius to round the button's corners.
