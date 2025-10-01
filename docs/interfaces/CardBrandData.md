# Interface: CardBrandData

Defined in: [components/card.ts:155](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L155)

## Properties

### cardBrands

```ts
cardBrands: CardBrand | CardBrand[];
```

Defined in: [components/card.ts:160](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L160)

iOS: List of detected card brands
Android: Detected card brand

***

### primaryBrand

```ts
primaryBrand: CardBrand;
```

Defined in: [components/card.ts:165](https://github.com/Fiksuruoka-fi/capacitor-adyen/blob/11440fe41a762b3d0bd5e9f1d1bfe680598119ee/src/definitions/components/card.ts#L165)

First card brand in the list (iOS) or the detected brand (Android)
