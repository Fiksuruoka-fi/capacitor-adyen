# Type Alias: TextStyleDefinition

```ts
type TextStyleDefinition = {
  color?: string;
  font?: FontDefinition;
  backgroundColor?: string;
  textAlignment?: "left" | "center" | "right" | "justified" | "natural";
};
```

Defined in: [styles.ts:43](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L43)

Describes common text styling. Applicable to labels, hints, footers, etc.
You can combine colour, font, background and text alignment.

## Properties

### color?

```ts
optional color: string;
```

Defined in: [styles.ts:45](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L45)

Hex colour string for the text (e.g. '#FF0000' or 'FFFFFF').

***

### font?

```ts
optional font: FontDefinition;
```

Defined in: [styles.ts:47](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L47)

Font specification for the text.

***

### backgroundColor?

```ts
optional backgroundColor: string;
```

Defined in: [styles.ts:49](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L49)

Background colour behind the text.

***

### textAlignment?

```ts
optional textAlignment: "left" | "center" | "right" | "justified" | "natural";
```

Defined in: [styles.ts:51](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/styles.ts#L51)

Alignment for the text within its container.
