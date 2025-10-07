# Interface: CardComponentOptions

Defined in: [src/definitions/components/card.ts:9](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f6b775642775e61e00bb60787472fc2c2f9bd045/src/definitions/components/card.ts#L9)

Options for creating a Adyen Card component.

## Extends

- [`BaseAdyenComponentOptions`](BaseAdyenComponentOptions.md)

## Properties

### amount?

```ts
optional amount: number;
```

Defined in: [src/definitions/components/card.ts:11](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f6b775642775e61e00bb60787472fc2c2f9bd045/src/definitions/components/card.ts#L11)

Payment amount in minor currency units (e.g., cents)

#### Overrides

[`BaseAdyenComponentOptions`](BaseAdyenComponentOptions.md).[`amount`](BaseAdyenComponentOptions.md#amount)

***

### countryCode?

```ts
optional countryCode: string;
```

Defined in: [src/definitions/components/card.ts:13](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f6b775642775e61e00bb60787472fc2c2f9bd045/src/definitions/components/card.ts#L13)

ISO 3166-1 alpha-2 country code (e.g., 'US', 'NL')

#### Overrides

[`BaseAdyenComponentOptions`](BaseAdyenComponentOptions.md).[`countryCode`](BaseAdyenComponentOptions.md#countrycode)

***

### currencyCode?

```ts
optional currencyCode: string;
```

Defined in: [src/definitions/components/card.ts:15](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f6b775642775e61e00bb60787472fc2c2f9bd045/src/definitions/components/card.ts#L15)

ISO 4217 currency code (e.g., 'USD', 'EUR')

#### Overrides

[`BaseAdyenComponentOptions`](BaseAdyenComponentOptions.md).[`currencyCode`](BaseAdyenComponentOptions.md#currencycode)

***

### configuration?

```ts
optional configuration: CardComponentConfiguration;
```

Defined in: [src/definitions/components/card.ts:17](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f6b775642775e61e00bb60787472fc2c2f9bd045/src/definitions/components/card.ts#L17)

Card component behaviour configuration

***

### style?

```ts
optional style: FormComponentStyle;
```

Defined in: [src/definitions/components/card.ts:19](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f6b775642775e61e00bb60787472fc2c2f9bd045/src/definitions/components/card.ts#L19)

Card-specific styling options

***

### viewOptions?

```ts
optional viewOptions: ComponentViewOptions;
```

Defined in: [src/definitions/components/card.ts:21](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/f6b775642775e61e00bb60787472fc2c2f9bd045/src/definitions/components/card.ts#L21)

View options for the component's presentation layout
