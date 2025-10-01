# Interface: CardComponentOptions

Defined in: [components/card.ts:8](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L8)

Options for creating a Adyen Card component.

## Extends

- [`BaseAdyenComponentOptions`](BaseAdyenComponentOptions.md)

## Properties

### amount?

```ts
optional amount: number;
```

Defined in: [components/card.ts:10](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L10)

Payment amount in minor currency units (e.g., cents)

#### Overrides

[`BaseAdyenComponentOptions`](BaseAdyenComponentOptions.md).[`amount`](BaseAdyenComponentOptions.md#amount)

***

### countryCode?

```ts
optional countryCode: string;
```

Defined in: [components/card.ts:12](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L12)

ISO 3166-1 alpha-2 country code (e.g., 'US', 'NL')

#### Overrides

[`BaseAdyenComponentOptions`](BaseAdyenComponentOptions.md).[`countryCode`](BaseAdyenComponentOptions.md#countrycode)

***

### currencyCode?

```ts
optional currencyCode: string;
```

Defined in: [components/card.ts:14](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L14)

ISO 4217 currency code (e.g., 'USD', 'EUR')

#### Overrides

[`BaseAdyenComponentOptions`](BaseAdyenComponentOptions.md).[`currencyCode`](BaseAdyenComponentOptions.md#currencycode)

***

### configuration?

```ts
optional configuration: CardComponentConfiguration;
```

Defined in: [components/card.ts:16](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L16)

Card component behaviour configuration

***

### style?

```ts
optional style: FormComponentStyle;
```

Defined in: [components/card.ts:18](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L18)

Card-specific styling options

***

### viewOptions?

```ts
optional viewOptions: ComponentViewOptions;
```

Defined in: [components/card.ts:20](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L20)

View options for the component's presentation layout
