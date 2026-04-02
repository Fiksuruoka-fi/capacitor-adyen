# Interface: CardBrandData

Defined in: [src/definitions/components/card.ts:157](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/0e19236823a007dd09c9876ed28b8e1e5b19a059/src/definitions/components/card.ts#L157)

## Properties

### cardBrands

```ts
cardBrands: CardBrand | CardBrand[];
```

Defined in: [src/definitions/components/card.ts:162](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/0e19236823a007dd09c9876ed28b8e1e5b19a059/src/definitions/components/card.ts#L162)

iOS: List of detected card brands
Android: Detected card brand

***

### primaryBrand

```ts
primaryBrand: CardBrand;
```

Defined in: [src/definitions/components/card.ts:167](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/0e19236823a007dd09c9876ed28b8e1e5b19a059/src/definitions/components/card.ts#L167)

First card brand in the list (iOS) or the detected brand (Android)
