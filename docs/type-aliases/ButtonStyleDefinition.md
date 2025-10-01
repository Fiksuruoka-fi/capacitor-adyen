# Type Alias: ButtonStyleDefinition

```ts
type ButtonStyleDefinition = {
  font?: FontDefinition;
  textColor?: string;
  backgroundColor?: string;
  cornerRadius?: number;
};
```

Defined in: [styles.ts:131](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L131)

Defines the styling for a button. These definitions map to
`FormButtonItemStyle.main` in the iOS SDK. All fields are optional.

## Properties

### font?

```ts
optional font: FontDefinition;
```

Defined in: [styles.ts:133](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L133)

Font used for the button's title.

***

### textColor?

```ts
optional textColor: string;
```

Defined in: [styles.ts:135](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L135)

Colour of the button title text.

***

### backgroundColor?

```ts
optional backgroundColor: string;
```

Defined in: [styles.ts:137](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L137)

Main background colour of the button.

***

### cornerRadius?

```ts
optional cornerRadius: number;
```

Defined in: [styles.ts:139](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L139)

Corner radius to round the button's corners.
