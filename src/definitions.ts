/// <reference types="@capacitor/cli" />
import type { PluginListenerHandle } from '@capacitor/core';
declare module '@capacitor/cli' {
  export interface PluginsConfig {
    Adyen?: {
      /**
       * Your Adyen client key. Available in Customer Area under Developers &gt; API Credentials.
       *
       * @since 7.0.0
       * @example "xyz"
       */
      clientKey: string;

      /**
       * Adyen environment to use. Can be either "test" or "live".
       *
       * @since 7.0.0
       * @example "test"
       */
      environment: 'test' | 'liveApse' | 'liveUs' | 'liveEu' | 'liveAu';
    };
  }
}

export interface AdyenPlugin {
  /**
   * Set current available payment methods for the Adyen components.
   *
   * @param options - Options for creating the card component.
   * @returns A promise that resolves when the card component is created.
   * @since 7.0.0
   *
   * @example
   * ```typescript
   * import { Adyen } from '@foodello/capacitor-adyen';
   *
   * const paymentMethodsResponse: PaymentMethodsResponse = await fetchPaymentMethodsFromYourServer();
   * await Adyen.setCurrentPaymentMethods({
   *   paymentMethodsJson: paymentMethodsResponse,
   * });
   *
   * @see {@link https://docs.adyen.com/api-explorer/Checkout/latest/post/paymentMethods} for more information on how to retrieve available payment methods.
   *
   * @throws Will throw an error if the Adyen SDK is not initialized or if required parameters are missing.
   */
  setCurrentPaymentMethods(options: { paymentMethodsJson: PaymentMethodsResponse }): Promise<void>;

  /**
   * Creates a Adyen Card component for handling card payments.
   *
   * @param options - Options for creating the card component.
   * @returns A promise that resolves when the card component is created.
   * @since 7.0.0
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
   * @see {@link https://docs.adyen.com/api-explorer/Checkout/latest/post/paymentMethods} for more information on how to retrieve available payment methods.
   *
   * @throws Will throw an error if the Adyen SDK is not initialized or if there is an issue creating the card component.
   */
  presentCardComponent(options?: CardComponentOptions): Promise<void>;

  /**
   * Hides the currently presented Adyen component, if any.
   *
   * @returns A promise that resolves when the component is hidden.
   * @since 7.0.0
   *
   * @example
   * ```typescript
   * import { Adyen } from '@foodello/capacitor-adyen';
   * await Adyen.hideComponent();
   * ```
   */
  hideComponent(): Promise<void>;

  /**
   * Listens for component `submit` events.
   *
   * @since 7.0.0
   * @example
   * ```typescript
   * import { Adyen } from '@foodello/capacitor-adyen';
   * Adyen.addListener('onSubmit', async (data) => {
   *   // Handle the submit event, e.g., send payment data to your server
   *   console.log('Payment submitted:', data);
   * });
   * ```
   */
  addListener(
    eventName: 'onSubmit',
    listenerFunc: (data: PaymentSubmitEventData) => void,
  ): Promise<PluginListenerHandle>;

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
  addListener(
    eventName: 'onCardSubmit',
    listenerFunc: (data: CardSubmitEventData) => void,
  ): Promise<PluginListenerHandle>;

  /**
   * Listens for Card component's `change` events.
   *
   * @since 7.0.0
   * @example
   * ```typescript
   * import { Adyen } from '@foodello/capacitor-adyen';
   * Adyen.onCardChange('onSubmit', async (data) => {
   *   // Handle the change event, e.g., show selected card details to the user
   *   console.log('Card changed:', data);
   * });
   * ```
   */
  addListener(
    eventName: 'onCardChange',
    listenerFunc: (data: CardChangeEventData) => void,
  ): Promise<PluginListenerHandle>;

  /**
   * Listens for component `error` events.
   *
   * @since 7.0.0
   * @example
   * ```typescript
   * import { Adyen } from '@foodello/capacitor-adyen';
   * Adyen.addListener('onError', async (data) => {
   *   // Handle the error event, e.g., show an error message to the user
   *   console.error('Payment error:', data);
   * });
   * ```
   */
  addListener(eventName: 'onError', listenerFunc: (data: PaymentErrorEventData) => void): Promise<PluginListenerHandle>;

  /**
   * Listens for component `action` events.
   *
   * @since 7.0.0
   * @example
   * ```typescript
   * import { Adyen } from '@foodello/capacitor-adyen';
   * Adyen.addListener('onAction', async (data) => {
   *   // Handle the action event, e.g., process additional details
   *   console.log('Payment action required:', data);
   * });
   * ```
   */
  addListener(
    eventName: 'onAction',
    listenerFunc: (data: PaymentActionEventData) => void,
  ): Promise<PluginListenerHandle>;

  /**
   * Listens for component `complete` events.
   *
   * @since 7.0.0
   * @example
   * ```typescript
   * import { Adyen } from '@foodello/capacitor-adyen';
   * Adyen.addListener('onComplete', async (data) => {
   *   // Handle the complete event, e.g., show a success message to the user
   *   console.log('Payment completed:', data);
   * });
   * ```
   */
  addListener(
    eventName: 'onComplete',
    listenerFunc: (data: PaymentCompleteEventData) => void,
  ): Promise<PluginListenerHandle>;

  /**
   * Listens for component `cancel` events.
   *
   * @since 7.0.0
   * @example
   * ```typescript
   * import { Adyen } from '@foodello/capacitor-adyen';
   * Adyen.addListener('onCancel', async (data) => {
   *   // Handle the cancel event, e.g., navigate back or reset the UI
   *   console.log('Payment cancelled:', data);
   * });
   * ```
   */
  addListener(
    eventName: 'onCancel',
    listenerFunc: (data: PaymentCancelEventData) => void,
  ): Promise<PluginListenerHandle>;

  /**
   * Listens for component `dismiss` events.
   *
   * @since 7.0.0
   * @example
   * ```typescript
   * import { Adyen } from '@foodello/capacitor-adyen';
   * Adyen.addListener('onComponentDismissed', async (data) => {
   *   // Handle the dismiss event, e.g., navigate back or reset the UI
   *   console.log('Component dismissed:', data.reason);
   * });
   * ```
   */
  addListener(
    eventName: 'onComponentDismissed',
    listenerFunc: (data: ComponentDissmissEventData) => void,
  ): Promise<PluginListenerHandle>;
}

/** JSON response from [Adyen API call](https://docs.adyen.com/api-explorer/Checkout/latest/post/paymentMethods) */
export type PaymentMethodsResponse = any;

/**
 * Options for creating a Adyen component.
 */
export type BaseAdyenComponentOptions = {
  amount?: number;
  /** ISO-3166-1 alpha-2 format */
  countryCode?: string;
  /** ISO 4217 currency code */
  currencyCode?: string;
};

/**
 * Options for creating a Adyen Card component.
 */
export type CardComponentOptions = BaseAdyenComponentOptions & {
  amount?: number;
  countryCode?: string;
  currencyCode?: string;
  configuration?: CardComponentConfiguration;
  style?: FormComponentStyle;
  viewOptions?: ComponentViewOptions;
};

export type CardComponentConfiguration = {
  showsHolderNameField?: boolean;
  showsSecurityCodeField?: boolean;
  showsStorePaymentMethodField?: boolean;
  supportedCardTypes?: string[];
  localizationParameters?: {
    tableName?: string;
    keySeparator?: string;
  };
};

/**
 * Options for customizing the appearance of the component navbar's view.
 */
export type ComponentViewOptions = {
  /** Custom text for the title */
  title?: string;
  /** Color for the title text */
  titleColor?: string;
  /** Title bar's background color */
  titleBackgroundColor?: string;
  /** Tint color for buttons in the title bar */
  titleTintColor?: string;
  /** Whether to show a close button in the title bar */
  showsCloseButton?: boolean;
  /** Custom text for the close button */
  closeButtonText?: string;
  /** iOS specific styling options to override defaults */
  ios?: {
    titleColor?: string;
    titleBackgroundColor?: string;
    titleTintColor?: string;
  };
};

/**
 * Defines a font used within a text element. Both fields are optional; if
 * omitted, the default system font is used.
 */
export type FontDefinition = {
  /** The font size in points. */
  size?: number;
  /** Weight name matching iOS font weights. */
  weight?: 'thin' | 'light' | 'regular' | 'medium' | 'semibold' | 'bold' | 'heavy' | 'black';
};

/**
 * Describes common text styling. Applicable to labels, hints, footers, etc.
 * You can combine colour, font, background and text alignment.
 */
export type TextStyleDefinition = {
  /** Hex colour string for the text (e.g. '#FF0000' or 'FFFFFF'). */
  color?: string;
  /** Font specification for the text. */
  font?: FontDefinition;
  /** Background colour behind the text. */
  backgroundColor?: string;
  /** Alignment for the text within its container. */
  textAlignment?: 'left' | 'center' | 'right' | 'justified' | 'natural';
};

/**
 * Describes styling for a text field in the form. This includes styling
 * for the title label, user input text, placeholder text, and trailing icon.
 */
export type TextFieldStyleDefinition = {
  /** Styling for the field's title label. */
  title?: TextStyleDefinition;
  /** Colour of the title label (legacy shortcut). */
  titleColor?: string;
  /** Font used for the title label (legacy shortcut). */
  titleFont?: FontDefinition;

  /** Styling for the user-entered text. */
  text?: TextStyleDefinition;
  /** Colour of the user-entered text (legacy shortcut). */
  textColor?: string;
  /** Font for the user-entered text (legacy shortcut). */
  textFont?: FontDefinition;

  /** Styling for the placeholder text. */
  placeholder?: TextStyleDefinition;
  /** Colour of the placeholder text (legacy shortcut). */
  placeholderColor?: string;
  /** Font for the placeholder text (legacy shortcut). */
  placeholderFont?: FontDefinition;

  /** Styling for the trailing icon. */
  icon?: {
    /** Tint colour of the icon. */
    tintColor?: string;
    /** Background colour behind the icon. */
    backgroundColor?: string;
    /** Border colour of the icon container. */
    borderColor?: string;
    /** Border width of the icon container. */
    borderWidth?: number;
    /** Corner radius of the icon container. */
    cornerRadius?: number;
  };

  /** Tint colour applied to the text field (cursor/accent). */
  tintColor?: string;
  /** Colour of the separator line beneath the text field. */
  separatorColor?: string;
  /** Background colour of the entire text field cell. */
  backgroundColor?: string;
  /** Colour used to highlight error states. */
  errorColor?: string;
};

/**
 * Styling for a toggle (switch) row. Supports a title style and colours for
 * tint, separator and background. This type is used for both the `switch` and
 * `toggle` keys when specifying form styles.
 */
export type SwitchStyleDefinition = {
  /** Styling for the title label next to the toggle. */
  title?: TextStyleDefinition;
  /** Colour of the title label (legacy shortcut). */
  titleColor?: string;
  /** Font for the title label (legacy shortcut). */
  titleFont?: FontDefinition;
  /** Tint colour of the toggle when turned on. */
  tintColor?: string;
  /** Colour of the separator line beneath the toggle row. */
  separatorColor?: string;
  /** Background colour of the toggle row. */
  backgroundColor?: string;
};

/**
 * Defines the styling for a button. These definitions map to
 * `FormButtonItemStyle.main` in the iOS SDK. All fields are optional.
 */
export type ButtonStyleDefinition = {
  /** Font used for the button's title. */
  font?: FontDefinition;
  /** Colour of the button title text. */
  textColor?: string;
  /** Main background colour of the button. */
  backgroundColor?: string;
  /** Corner radius to round the button's corners. */
  cornerRadius?: number;
};

/**
 * Combined style configuration for forms. Includes top-level colours and
 * nested sub-styles for various form elements. All keys are optional and
 * unknown keys are ignored.
 */
export type FormComponentStyle = {
  /** Background colour applied to the entire form. */
  backgroundColor?: string;
  /** Tint colour applied to accent elements within the form. */
  tintColor?: string;
  /** Colour of separators between form rows. */
  separatorColor?: string;

  /** Styling for the header text (section title). */
  header?: TextStyleDefinition;
  /** Styling for text input fields. */
  textField?: TextFieldStyleDefinition;

  /** Styling for toggle rows. Both `switch` and `toggle` keys are supported. */
  switch?: SwitchStyleDefinition;
  toggle?: SwitchStyleDefinition;

  /** Styling for hint labels (usually under a field). */
  hint?: TextStyleDefinition;
  /** Styling for footnote labels at the bottom of the form. */
  footnote?: TextStyleDefinition;
  /** Styling for inline link text in informational messages. */
  linkText?: TextStyleDefinition;

  /** Styling for the primary action button. You may use either `button` or `mainButton`. */
  button?: ButtonStyleDefinition;
  /** Styling for the primary action button. Same as `button`. */
  mainButton?: ButtonStyleDefinition;
  /** Styling for a secondary action button. */
  secondaryButton?: ButtonStyleDefinition;
};

// Event data types
export type CardSubmitEventData = {
  lastFour: string;
  finalBIN: string;
};

export type CardChangeEventData = {
  cardBrands?: CardBrandData;
  cardBIN?: string;
};

export type PaymentSubmitEventData = {
  paymentMethod: {
    [key: string]: any;
  };
  componentType: 'card' | 'dropIn' | 'ideal' | 'paypal' | 'bcmcMobile';
  browserInfo?: {
    userAgent: string;
  };
  order?: {
    orderData: string;
    pspReference: string;
  };
  amount?: {
    value: number;
    currency: string;
  };
  storePaymentMethod?: boolean;
};

export type PaymentErrorEventData = {
  error: string;
  errorCode: number;
  errorDomain: string;
  componentType: string;
  details?: string;
  componentName?: string;
  source?: string;
};

export type PaymentActionEventData = {
  componentType: 'dropIn';
  actionType: 'additionalDetails';
  details: {
    [key: string]: any;
  };
};

export type PaymentCompleteEventData = {
  componentType: 'dropIn';
  action: 'actionCompleted' | 'completed';
  componentName?: string;
};

export type PaymentCancelEventData = {
  componentType: 'dropIn';
  action: 'cancelled';
};

export type ComponentDissmissEventData = {
  reason: 'user_gesture';
};

export type CardBrandData = {
  cardBrands: CardBrand[];
  primaryBrand: CardBrand;
};

export type CardBrand = {
  type: string;
  isSupported: boolean;
};
