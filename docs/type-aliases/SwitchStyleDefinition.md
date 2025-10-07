# Type Alias: SwitchStyleDefinition

```ts
type SwitchStyleDefinition = {
  title?: TextStyleDefinition;
  titleColor?: string;
  titleFont?: FontDefinition;
  tintColor?: string;
  separatorColor?: string;
  backgroundColor?: string;
};
```

Defined in: [src/definitions/styles.ts:111](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/styles.ts#L111)

Styling for a toggle (switch) row. Supports a title style and colours for
tint, separator and background. This type is used for both the `switch` and
`toggle` keys when specifying form styles.

## Properties

### title?

```ts
optional title: TextStyleDefinition;
```

Defined in: [src/definitions/styles.ts:113](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/styles.ts#L113)

Styling for the title label next to the toggle.

***

### titleColor?

```ts
optional titleColor: string;
```

Defined in: [src/definitions/styles.ts:115](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/styles.ts#L115)

Colour of the title label (legacy shortcut).

***

### titleFont?

```ts
optional titleFont: FontDefinition;
```

Defined in: [src/definitions/styles.ts:117](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/styles.ts#L117)

Font for the title label (legacy shortcut).

***

### tintColor?

```ts
optional tintColor: string;
```

Defined in: [src/definitions/styles.ts:119](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/styles.ts#L119)

Tint colour of the toggle when turned on.

***

### separatorColor?

```ts
optional separatorColor: string;
```

Defined in: [src/definitions/styles.ts:121](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/styles.ts#L121)

Colour of the separator line beneath the toggle row.

***

### backgroundColor?

```ts
optional backgroundColor: string;
```

Defined in: [src/definitions/styles.ts:123](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/styles.ts#L123)

Background colour of the toggle row.
