# Interface: CardComponentOptions

Defined in: [src/definitions/components/card.ts:10](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/4ec12391e08800da9ed0c6dd7ddc94c6929d4f96/src/definitions/components/card.ts#L10)

Options for creating a Adyen Card component.

## Extends

- [`BaseAdyenComponentOptions`](BaseAdyenComponentOptions.md)

## Properties

### amount?

```ts
optional amount: number;
```

Defined in: [src/definitions/components/card.ts:12](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/4ec12391e08800da9ed0c6dd7ddc94c6929d4f96/src/definitions/components/card.ts#L12)

Payment amount in minor currency units (e.g., cents)

#### Overrides

[`BaseAdyenComponentOptions`](BaseAdyenComponentOptions.md).[`amount`](BaseAdyenComponentOptions.md#amount)

***

### countryCode?

```ts
optional countryCode: string;
```

Defined in: [src/definitions/components/card.ts:14](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/4ec12391e08800da9ed0c6dd7ddc94c6929d4f96/src/definitions/components/card.ts#L14)

ISO 3166-1 alpha-2 country code (e.g., 'US', 'NL')

#### Overrides

[`BaseAdyenComponentOptions`](BaseAdyenComponentOptions.md).[`countryCode`](BaseAdyenComponentOptions.md#countrycode)

***

### currencyCode?

```ts
optional currencyCode: string;
```

Defined in: [src/definitions/components/card.ts:16](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/4ec12391e08800da9ed0c6dd7ddc94c6929d4f96/src/definitions/components/card.ts#L16)

ISO 4217 currency code (e.g., 'USD', 'EUR')

#### Overrides

[`BaseAdyenComponentOptions`](BaseAdyenComponentOptions.md).[`currencyCode`](BaseAdyenComponentOptions.md#currencycode)

***

### configuration?

```ts
optional configuration: CardComponentConfiguration;
```

Defined in: [src/definitions/components/card.ts:18](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/4ec12391e08800da9ed0c6dd7ddc94c6929d4f96/src/definitions/components/card.ts#L18)

Card component behaviour configuration

***

### style?

```ts
optional style: FormComponentStyle;
```

Defined in: [src/definitions/components/card.ts:20](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/4ec12391e08800da9ed0c6dd7ddc94c6929d4f96/src/definitions/components/card.ts#L20)

Card-specific styling options

***

### viewOptions?

```ts
optional viewOptions: ComponentViewOptions;
```

Defined in: [src/definitions/components/card.ts:22](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/4ec12391e08800da9ed0c6dd7ddc94c6929d4f96/src/definitions/components/card.ts#L22)

View options for the component's presentation layout
