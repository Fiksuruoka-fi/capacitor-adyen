/// <reference types="@capacitor/cli" />
import type { PluginListenerHandle } from '@capacitor/core';

import type Card from '../components/card/Card';

import type { CardComponentEvents, CardComponentMethods } from './components/card';

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

      /**
       * Enable or disable Adyen's analytics feature.
       *
       * @since 7.0.0
       * @default false
       */
      enableAnalytics: boolean;
    };
  }
}

declare global {
  interface Window {
    adyenCard?: Card;
  }
}

/**
 * JSON response from Adyen API call
 * @see https://docs.adyen.com/api-explorer/Checkout/latest/post/paymentMethods for more information.
 * @group Configuration
 */
export interface PaymentMethodsResponse {
  /**
   * Array of available payment methods.
   */
  paymentMethods: any[];

  /**
   * The type of the payment method response, typically "PaymentMethods".
   */
  savedPaymentMethods?: any[];
}

/**
 * Base options for Adyen components.
 * @group Configuration
 */
export interface BaseAdyenComponentOptions {
  amount?: number;
  /** ISO-3166-1 alpha-2 format */
  countryCode?: string;
  /** ISO 4217 currency code */
  currencyCode?: string;
}

/**
 * Base events available for all Adyen components.
 * @group Events
 */
export interface BaseEvents {
  /**
   * Listens for payment `onAdditionalDetails` events.
   * @since 7.0.0
   * @example
   * ```typescript
   * import { Adyen } from '@foodello/capacitor-adyen';
   * Adyen.addListener('onAdditionalDetails', async (data) => {
   *   // Handle the additionalDetails event, e.g., send data to your server
   *   console.log('Additional details:', data);
   * });
   * ```
   */
  onAdditionalDetails: (data: AdditionalDetailsEventData) => void;

  /**
   * Listens for payment `submit` events.
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
  onSubmit: (data: PaymentSubmitEventData) => void;

  /**
   * Listens for payment and component `error` events.
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
  onError: (data: PaymentErrorEventData) => void;

  /**
   * Listens for component `present` events.
   *
   * @since 7.0.0
   * @example
   * ```typescript
   * import { Adyen } from '@foodello/capacitor-adyen';
   * Adyen.addListener('onShow', async () => {
   *   // Handle the present event
   *   console.log('Component presented');
   * });
   * ```
   */
  onShow: () => void;

  /**
   * Listens for component `dismiss` events.
   *
   * @since 7.0.0
   * @example
   * ```typescript
   * import { Adyen } from '@foodello/capacitor-adyen';
   * Adyen.addListener('onHide', async (data) => {
   *   // Handle the hide event, e.g., navigate back or reset the UI
   *   console.log('Component hidden:', data.reason);
   * });
   * ```
   */
  onHide: (data: ComponentHideEventData) => void;
}

/**
 * All available Adyen events
 * @group Events
 */
export interface AdyenEvents extends BaseEvents, CardComponentEvents {}

export interface BaseAdyenPlugin {
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
   * Destroys the currently selected Adyen component, if any.
   *
   * @returns A promise that resolves when the component is destroyed.
   * @since 7.0.0
   *
   * @example
   * ```typescript
   * import { Adyen } from '@foodello/capacitor-adyen';
   * await Adyen.destroyComponent();
   * ```
   */
  destroyComponent(): Promise<void>;

  addListener<E extends keyof AdyenEvents>(eventName: E, listener: AdyenEvents[E]): Promise<PluginListenerHandle>;
}

export interface AdyenPlugin extends BaseAdyenPlugin, CardComponentMethods {}
export * from './styles';
export * from './components/card';

// Event data types
export interface AdditionalDetailsEventData {
  [key: string]: any;
}

export interface PaymentSubmitEventData {
  paymentMethod: {
    [key: string]: any;
  };
  componentType: 'card';
  browserInfo?: { userAgent: string };
  order?: { orderData: string; pspReference: string };
  amount?: { value: number; currency: string };
  storePaymentMethod?: boolean;
}

export interface PaymentErrorEventData {
  [key: string]: any;
  message: string;
}

export interface ComponentHideEventData {
  reason: 'user_gesture';
}
