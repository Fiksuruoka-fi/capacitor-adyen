# Type Alias: ComponentViewOptions

```ts
type ComponentViewOptions = {
  title?: string;
  titleColor?: string;
  titleBackgroundColor?: string;
  titleTintColor?: string;
  showsCloseButton?: boolean;
  closeButtonText?: string;
  ios?: {
     titleColor?: string;
     titleBackgroundColor?: string;
     titleTintColor?: string;
  };
};
```

Defined in: [src/definitions/styles.ts:5](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/styles.ts#L5)

Options for customizing the appearance of the component navbar's view.

## Properties

### title?

```ts
optional title: string;
```

Defined in: [src/definitions/styles.ts:7](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/styles.ts#L7)

Custom text for the title

***

### titleColor?

```ts
optional titleColor: string;
```

Defined in: [src/definitions/styles.ts:9](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/styles.ts#L9)

Color for the title text

***

### titleBackgroundColor?

```ts
optional titleBackgroundColor: string;
```

Defined in: [src/definitions/styles.ts:11](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/styles.ts#L11)

Title bar's background color

***

### titleTintColor?

```ts
optional titleTintColor: string;
```

Defined in: [src/definitions/styles.ts:13](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/styles.ts#L13)

Tint color for buttons in the title bar

***

### showsCloseButton?

```ts
optional showsCloseButton: boolean;
```

Defined in: [src/definitions/styles.ts:15](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/styles.ts#L15)

Whether to show a close button in the title bar

***

### closeButtonText?

```ts
optional closeButtonText: string;
```

Defined in: [src/definitions/styles.ts:17](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/styles.ts#L17)

Custom text for the close button

***

### ios?

```ts
optional ios: {
  titleColor?: string;
  titleBackgroundColor?: string;
  titleTintColor?: string;
};
```

Defined in: [src/definitions/styles.ts:19](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/styles.ts#L19)

iOS specific styling options to override defaults

#### titleColor?

```ts
optional titleColor: string;
```

#### titleBackgroundColor?

```ts
optional titleBackgroundColor: string;
```

#### titleTintColor?

```ts
optional titleTintColor: string;
```
