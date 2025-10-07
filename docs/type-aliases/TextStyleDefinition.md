# Type Alias: TextStyleDefinition

```ts
type TextStyleDefinition = {
  color?: string;
  font?: FontDefinition;
  backgroundColor?: string;
  textAlignment?: "left" | "center" | "right" | "justified" | "natural";
};
```

Defined in: [src/definitions/styles.ts:43](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/styles.ts#L43)

Describes common text styling. Applicable to labels, hints, footers, etc.
You can combine colour, font, background and text alignment.

## Properties

### color?

```ts
optional color: string;
```

Defined in: [src/definitions/styles.ts:45](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/styles.ts#L45)

Hex colour string for the text (e.g. '#FF0000' or 'FFFFFF').

***

### font?

```ts
optional font: FontDefinition;
```

Defined in: [src/definitions/styles.ts:47](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/styles.ts#L47)

Font specification for the text.

***

### backgroundColor?

```ts
optional backgroundColor: string;
```

Defined in: [src/definitions/styles.ts:49](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/styles.ts#L49)

Background colour behind the text.

***

### textAlignment?

```ts
optional textAlignment: "left" | "center" | "right" | "justified" | "natural";
```

Defined in: [src/definitions/styles.ts:51](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f7f5e96f21755ab2c8662363cc5f5c74dae6561a/src/definitions/styles.ts#L51)

Alignment for the text within its container.
