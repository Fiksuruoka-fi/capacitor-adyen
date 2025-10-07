# Type Alias: FontDefinition

```ts
type FontDefinition = {
  size?: number;
  weight?:   | "thin"
     | "light"
     | "regular"
     | "medium"
     | "semibold"
     | "bold"
     | "heavy"
     | "black";
};
```

Defined in: [src/definitions/styles.ts:31](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f6b775642775e61e00bb60787472fc2c2f9bd045/src/definitions/styles.ts#L31)

Defines a font used within a text element. Both fields are optional; if
omitted, the default system font is used.

## Properties

### size?

```ts
optional size: number;
```

Defined in: [src/definitions/styles.ts:33](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f6b775642775e61e00bb60787472fc2c2f9bd045/src/definitions/styles.ts#L33)

The font size in points.

***

### weight?

```ts
optional weight: 
  | "thin"
  | "light"
  | "regular"
  | "medium"
  | "semibold"
  | "bold"
  | "heavy"
  | "black";
```

Defined in: [src/definitions/styles.ts:35](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f6b775642775e61e00bb60787472fc2c2f9bd045/src/definitions/styles.ts#L35)

Weight name matching iOS font weights.
