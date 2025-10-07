# Interface: CardBrandData

Defined in: [src/definitions/components/card.ts:156](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/components/card.ts#L156)

## Properties

### cardBrands

```ts
cardBrands: CardBrand | CardBrand[];
```

Defined in: [src/definitions/components/card.ts:161](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/components/card.ts#L161)

iOS: List of detected card brands
Android: Detected card brand

***

### primaryBrand

```ts
primaryBrand: CardBrand;
```

Defined in: [src/definitions/components/card.ts:166](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/9b0313d4b12ecff6be224a053e54e78b3d689f08/src/definitions/components/card.ts#L166)

First card brand in the list (iOS) or the detected brand (Android)
