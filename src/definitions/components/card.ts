import { CardConfiguration } from '@adyen/adyen-web';
import type { BaseAdyenComponentOptions } from '..';
import type { ComponentViewOptions, FormComponentStyle } from '../styles';

/**
 * Options for creating a Adyen Card component.
 * @group Card Component
 */
export interface CardComponentOptions extends BaseAdyenComponentOptions {
  /** Payment amount in minor currency units (e.g., cents) */
  amount?: number;
  /** ISO 3166-1 alpha-2 country code (e.g., 'US', 'NL') */
  countryCode?: string;
  /** ISO 4217 currency code (e.g., 'USD', 'EUR') */
  currencyCode?: string;
  /** Card component behaviour configuration */
  configuration?: CardComponentConfiguration;
  /** Card-specific styling options */
  style?: FormComponentStyle;
  /** View options for the component's presentation layout */
  viewOptions?: ComponentViewOptions;
}

/**
 * Configuration options specific to the Card component.
 * @see [Android](https://docs.adyen.com/payment-methods/cards/android-component/#components-configuration)
 * @see [iOS](https://docs.adyen.com/payment-methods/cards/ios-component/#optional-configuration)
 * @group Card Component
 */
export interface CardComponentConfiguration {
  /**
   * Display cardholder name input field
   * @default false
   */
  showsHolderNameField?: boolean;

  /**
   * Display security code input field
   * @default true
   */
  showsSecurityCodeField?: boolean;

  /**
   * Display store payment method checkbox
   * @default false
   */
  showsStorePaymentMethodField?: boolean;

  /**
   * Supported card types
   * Same as `supportedCardTypes` on Android
   * @default `AnyCardPaymentMethod`
   */
  allowedCardTypes?: string[];

  /**
   * Display submit button
   * @default true
   */
  showsSubmitButton?: boolean;

  /**
   * Your unique shopper reference.
   */
  shopperReference?: string;

  /**
   * Billing address configuration
   */
  billingAddress?: {
    /**
     * Set to `true` to collect the shopper's billing address and mark the fields as required.
     * @default false
     */
    requirementPolicy: boolean;

    /**
     * 	Sets which billing address fields to show in the payment form. Possible values:
     *  - full: show all billing address fields.
     *  - none: do not show billing address fields.
     *  - postalCode: show only the postal code field.
     * @default `none`
     */
    mode: 'none' | 'full' | 'postalCode';

    /**
     * Array of allowed country codes for the billing address. For example, `['US', 'CA', 'BR']`.
     * @default all countries supported by Adyen
     */
    countryCodes?: string[];
  };

  /**
   * 	For Korean cards, sets if security fields show in the payment form. Possible values:
   *   - show: show the fields.
   *   - hide: do not show the fields.
   *   - auto: the field appears for cards issued in South Korea.
   * @default `auto`
   */
  koreanAuthenticationMode?: 'show' | 'hide' | 'auto';

  /**
   * For Brazilian cards, sets if the CPF/CNPJ social security number field shows in the payment form. Possible values:
   *   - show: show the field.
   *   - hide: do not show the field.
   *   - auto: the field appears based on the detected card number.
   * @default `auto`
   */
  socialSecurityNumberMode?: 'show' | 'hide' | 'auto';

  /** Localization parameters for the component */
  localizationParameters?: {
    /**
     * ISO 639-1 language code
     * @default not-set, defaults to device language
     */
    languageOverride?: string;
    /**
     * iOS only
     * @see https://adyen.github.io/adyen-ios/5.20.1/documentation/adyen/localization/
     */
    tableName?: string;

    /**
     * iOS only
     * @see https://adyen.github.io/adyen-ios/5.20.1/documentation/adyen/localization/
     */
    keySeparator?: string;
  };
}

export interface CardSubmitEventData {
  /**
   * Last four digits of the card number
   */
  lastFour: string;

  /**
   * Final Bank Identification Number (BIN) of the card
   */
  finalBIN: string;
}

export interface CardChangeEventData {
  /**
   * Card brand information
   */
  cardBrands?: CardBrandData;

  /**
   * Bank Identification Number (BIN) of the card
   */
  cardBIN?: string;
}

export interface CardBrandData {
  /**
   * iOS: List of detected card brands
   * Android: Detected card brand
   */
  cardBrands: CardBrand[] | CardBrand;

  /**
   * First card brand in the list (iOS) or the detected brand (Android)
   */
  primaryBrand: CardBrand;
}

export interface CardBrand {
  /**
   * Card brand name, e.g., 'visa', 'mc', 'amex', etc.
   */
  type: string;

  /**
   * Only on iOS
   */
  isSupported: boolean;
}

/** @group Card Component */
export interface CardComponentMethods {
  /**
   * Creates a Adyen Card component for handling card payments.
   *
   * @param options - Options for creating the card component.
   * @since 7.0.0
   * @see {@link https://docs.adyen.com/api-explorer/Checkout/latest/post/paymentMethods} for more information on how to retrieve available payment methods.
   *
   * @example
   * ```typescript
   * import { Adyen } from '@foodello/capacitor-adyen';
   *
   * const paymentMethodsResponse: PaymentMethodsResponse = await fetchPaymentMethodsFromYourServer();
   * await Adyen.presentCardComponent({
   *   amount: 1000,
   *   countryCode: 'NL',
   *   currencyCode: 'EUR',
   * });
   *
   */
  presentCardComponent(options?: CardComponentOptions): Promise<void>;
}

/** @group Card Component */
export interface CardComponentEvents {
  /**
   * Listens for Card component `submit` events.
   *
   * @since 7.0.0
   * @example
   * ```typescript
   * import { Adyen } from '@foodello/capacitor-adyen';
   * Adyen.addListener('onCardSubmit', async (data) => {
   *   // Handle the submit event, e.g., show selected card details to the user
   *   console.log('Card submitted:', data);
   * });
   * ```
   */
  onCardSubmit: (data: CardSubmitEventData) => void;

  /**
   * Listens for Card component's `change` events.
   *
   * @since 7.0.0
   * @example
   * ```typescript
   * import { Adyen } from '@foodello/capacitor-adyen';
   * Adyen.addListener('onCardChange', async (data) => {
   *   // Handle the change event, e.g., show selected card details to the user
   *   console.log('Card changed:', data);
   * });
   * ```
   */
  onCardChange: (data: CardChangeEventData) => void;
}

/**
 * State of the native card component
 * @group Card Component
 */
export interface NativeCardState {
  /**
   * Card brand (e.g., 'visa', 'mc', 'amex', etc.)
   */
  brand: string;

  /**
   * Component state (loading or submitted)
   */
  state: 'loading' | 'submitted';

  /**
   * Last four digits of the card number
   */
  lastFour: string;

  /**
   * Show "Add card" button immediately when rendering loading state
   * @default false
   */
  showForceEditButton: boolean;
}

/**
 * Native card component configuration options
 *
 * @group Card Component
 */
export interface NativeCardConfiguration {
  /**
   * Override card brand image `src` strings
   * @example
   * ```json
   * { "mc": "https://example.com/mc.png", "visa": "https://example.com/visa.png" }
   * ```
   */
  brandImages?: Record<string, string>;

  /**
   * i18n strings to use in Web presentation on native platforms.
   * Fallbacks to English strings.
   */
  labels?: {
    /**
     * Label for the button to add a new card
     * @default "Add card"
     */
    addCard?: string;

    /**
     * Title on top of filled card brand and number
     * @default "Card:"
     */
    submittedCardTitle?: string;

    /**
     * Label for the button to change the payment method once filled
     * @default "Change"
     */
    changePaymentMethod?: string;
  };

  /**
   * Override default behaviour when the user taps "Edit" or "Add card" button.
   * You can use this to present your own card form or handle the event differently.
   *
   * @default presents the native Card component form
   * @example
   * ```typescript
   * async function onClickEdit() {
   *   // Present your own card form or handle differently
   * }
   * ```
   */
  onClickEdit?: () => void;

  /**
   * Component options for the native bottom sheet card form presentation
   */
  componentOptions?: Omit<CardComponentOptions, 'amount' | 'countryCode' | 'currencyCode'>;
}

/**
 * Extended Card component configuration including native options
 *
 * @group Card Component
 * @see https://docs.adyen.com/payment-methods/cards/web-component/#optional-configuration
 */
export interface ExtendedCardConfiguration extends CardConfiguration {
  nativeCard?: NativeCardConfiguration;
  isDev?: boolean;
  testNativePresentation?: boolean;
}
