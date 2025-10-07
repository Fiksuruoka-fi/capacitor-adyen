import { Card as AdyenCardComponent, type ICore } from '@adyen/adyen-web';
import { Capacitor, type PluginListenerHandle } from '@capacitor/core';
import { Adyen } from '../../bridge';
import type {
  CardComponentOptions,
  CardSubmitEventData,
  ExtendedCardConfiguration,
  NativeCardState,
  PaymentSubmitEventData,
} from '../../definitions';
import CardDetails from './CardDetails';
import { h } from 'preact';

import '@adyen/adyen-web/styles/adyen.css';
import './styles.scss';

class Card extends AdyenCardComponent {
  declare public props: ExtendedCardConfiguration;

  private onSubmitListener?: PluginListenerHandle;
  private onCardSubmitListener?: PluginListenerHandle;
  private onCardChangeListener?: PluginListenerHandle;
  private onShowListener?: PluginListenerHandle;
  private onHideListener?: PluginListenerHandle;

  private forceEditTimeout?: ReturnType<typeof setTimeout>;
  private isNative: boolean;
  private isNativeComponentOpen = false;

  /**
   * Base URL for Adyen assets (logos, etc.) - changes based on environment
   */
  private imageBaseUrl: string;

  constructor(checkoutCore: ICore, props: ExtendedCardConfiguration) {
    const { isDev, testNativePresentation, ...rest } = props || {};
    super(checkoutCore, rest);

    this.isNative = Capacitor.isNativePlatform();
    this.imageBaseUrl = `https://checkoutshopper-${checkoutCore.options.environment}.cdn.adyen.com/checkoutshopper/images`;

    if (isDev) {
      console.log('CardWithNativeSupport instance assigned to window.adyenCard for debugging');
      window.adyenCard = this;

      if (testNativePresentation && !this.isNative) {
        console.warn(
          'testNativePresentation is true but platform is not native - showing native card presentation anyway',
        );
        this.isNative = true;
      }
    }
  }

  /**
   * Public API to update native card state from external code
   */
  public updateNativeCard = (updates: Partial<NativeCardState>): void => {
    this.updateNativeCardState(updates);
  };

  /**
   * Public API to get current native card state
   */
  public getNativeCardState = (): NativeCardState => {
    return this.state.nativeCardState;
  };

  /**
   * Public API to get card brand images (either from props or default set)
   * Prioritizes `props.nativeCard.brandImages` over `props.brandsConfiguration`
   */
  public getCardBrandImages = (): Record<string, string> => {
    const { brandsConfiguration, nativeCard: { brandImages: nativeBrandImages } = {} } = this.props ?? {};

    if (nativeBrandImages) {
      console.log('Using native brand images:', nativeBrandImages);
      return nativeBrandImages;
    }

    if (brandsConfiguration && Object.keys(brandsConfiguration ?? {}).length) {
      console.log('Using brands configuration:', brandsConfiguration);
      return Object.entries(brandsConfiguration).reduce(
        (acc, [brand, config]) => {
          if (config?.icon) acc[brand] = config.icon;
          return acc;
        },
        {} as Record<string, string>,
      );
    }

    console.log('Using default brand images from Adyen CDN');
    return {
      amex: `${this.imageBaseUrl}/logos/amex.svg`,
      bcmc: `${this.imageBaseUrl}/logos/bcmc.svg`,
      card: `${this.imageBaseUrl}/logos/card.svg`,
      diners: `${this.imageBaseUrl}/logos/diners.svg`,
      discover: `${this.imageBaseUrl}/logos/discover.svg`,
      elo: `${this.imageBaseUrl}/logos/elo.svg`,
      hiper: `${this.imageBaseUrl}/logos/hiper.svg`,
      hipercard: `${this.imageBaseUrl}/logos/hipercard.svg`,
      jcb: `${this.imageBaseUrl}/logos/jcb.svg`,
      maestro: `${this.imageBaseUrl}/logos/maestro.svg`,
      mc: `${this.imageBaseUrl}/logos/mc.svg`,
      mir: `${this.imageBaseUrl}/logos/mir.svg`,
      nocard: `${this.imageBaseUrl}/logos/nocard.svg`,
      unionpay: `${this.imageBaseUrl}/logos/unionpay.svg`,
      visa: `${this.imageBaseUrl}/logos/visa.svg`,
    };
  };

  /**
   * Updates native card state and triggers reactive re-render for presented component
   */
  private updateNativeCardState = (updates: Partial<NativeCardState>): void => {
    console.log('Updating native card state:', updates);

    // Update the parent component's state first
    this.setState({
      nativeCardState: {
        ...this.state.nativeCardState,
        ...updates,
      },
    });

    // Then update the child component if it's mounted
    if (this.componentRef?.updateCardState) {
      this.componentRef.updateCardState(updates);
    }
  };

  /**
   * Reference to the NativeCard component instance (if mounted)
   */
  private setNativeCardRef = (ref: any): void => {
    this.componentRef = ref;
  };

  /**
   * Renders the NativeCard component with current state and props
   */
  private renderNativeCard = (): h.JSX.Element => {
    console.log('Rendering native card component', this.state.nativeCardState);
    const nativeConfig = this.props.nativeCard;
    const brandImages = this.getCardBrandImages();

    return h(CardDetails, {
      ref: this.setNativeCardRef,
      initialState: 'loading',
      initialLastFour: '••••',
      initialBrand: 'nocard',
      brandImages,
      onClickEdit: nativeConfig?.onClickEdit || this.presentNativeComponent,
      labels: {
        addCard: nativeConfig?.labels?.addCard || 'Add card',
        submittedCardTitle: nativeConfig?.labels?.submittedCardTitle || 'Selected card:',
        changePaymentMethod: nativeConfig?.labels?.changePaymentMethod || 'Change',
      },
    });
  };

  /**
   * Formats and sanitizes CardComponentOptions before passing to Adyen native SDK
   * (removes any non-serializable fields, functions, etc.)
   */
  private formatOptions = (options: CardComponentOptions): CardComponentOptions => {
    const safeOptions = JSON.parse(JSON.stringify(options));
    return safeOptions;
  };

  /**
   * Presents the native card component using Capacitor Adyen plugin
   * (only on native platforms, otherwise does nothing)
   */
  private presentNativeComponent = async (): Promise<void> => {
    if (!this.isNative) return;

    const {
      amount: { value: amount, currency: currencyCode } = {},
      billingAddressAllowedCountries,
      billingAddressMode,
      billingAddressRequired,
      brands,
      countryCode,
      hasHolderName,
      hideCVC,
      nativeCard: { componentOptions = {} } = {},
    } = this.props;

    try {
      console.log('Presenting native card component');

      this.updateNativeCard({
        state: 'loading',
        showForceEditButton: false,
      });

      this.startForceEditTimeout();

      const options: CardComponentOptions = this.formatOptions({
        ...componentOptions,
        amount: amount ?? 0,
        currencyCode: currencyCode?.toUpperCase(),
        countryCode: countryCode?.toUpperCase(),
        configuration: {
          ...componentOptions.configuration,
          allowedCardTypes: componentOptions.configuration?.allowedCardTypes || brands,
          billingAddress: {
            countryCodes:
              componentOptions.configuration?.billingAddress?.countryCodes ?? billingAddressAllowedCountries,
            mode:
              componentOptions.configuration?.billingAddress?.mode ??
              (billingAddressMode === 'partial' ? undefined : 'none') ??
              'none',
            requirementPolicy:
              componentOptions.configuration?.billingAddress?.requirementPolicy ?? billingAddressRequired ?? false,
          },
          showsHolderNameField: componentOptions.configuration?.showsHolderNameField ?? hasHolderName,
          showsSecurityCodeField: componentOptions.configuration?.showsSecurityCodeField ?? !hideCVC,
        },
      });

      await Promise.all([this.setupListeners(), Adyen.presentCardComponent(options)]);
    } catch (error) {
      console.error('Native component presentation error:', error);
      throw error;
    }
  };

  /**
   * Starts timeout to show "Edit" button if loading takes too long
   * (5 seconds by default)
   */
  private startForceEditTimeout = (): void => {
    if (this.forceEditTimeout) {
      clearTimeout(this.forceEditTimeout);
    }

    this.forceEditTimeout = setTimeout(() => {
      const { state } = this.getNativeCardState();
      if (state === 'loading') {
        this.updateNativeCard({ showForceEditButton: true });
        this.setElementStatus('ready');
      }
    }, 5000);
  };

  /**
   * Handles Adyen native SDK `onSubmit` events
   */
  private onPaymentSubmitHandler = async (data: PaymentSubmitEventData): Promise<void> => {
    console.log('Adyen native onSubmit', data);

    this.setState({
      data: data.paymentMethod,
      valid: {},
      errors: {},
      isValid: true,
    });

    const updates: Partial<NativeCardState> = {
      state: 'submitted',
    };

    if (data.paymentMethod.brand) {
      const { brand } = this.getNativeCardState();
      if (data.paymentMethod.brand !== brand) {
        updates.brand = data.paymentMethod.brand;
      }
    }

    this.updateNativeCard(updates);
    await Adyen.hideComponent();
  };

  /**
   * Handles Adyen native SDK `onCardSubmit` events
   */
  private onCardSubmitHandler = async (data: CardSubmitEventData): Promise<void> => {
    console.log('Adyen native onCardSubmit', data);

    this.updateNativeCard({
      lastFour: data.lastFour,
      state: 'submitted',
      showForceEditButton: false,
    });

    if (this.forceEditTimeout) {
      clearTimeout(this.forceEditTimeout);
    }
  };

  /**
   * Handles Adyen native SDK `onShow` and `onHide` events
   */
  private onShowHandler = (): void => {
    console.log(`Adyen native component's onShow`);
    this.isNativeComponentOpen = true;
  };

  /**
   * Handles Adyen native SDK `onShow` and `onHide` events
   */
  private onHideHandler = (): void => {
    console.log(`Adyen native component's onHide`);
    this.isNativeComponentOpen = false;
  };

  /**
   * Sets up the native listeners only if they don't exist yet
   */
  private setupListeners = async (): Promise<void> => {
    const hasListenersSetAlready = this.onCardSubmitListener && this.onSubmitListener;

    if (!hasListenersSetAlready) {
      console.log('Setting up native card component listeners');

      const [cardSubmitListener, submitListener, showListener, hideListener] = await Promise.all([
        this.onCardSubmitListener || Adyen.addListener('onCardSubmit', this.onCardSubmitHandler),
        this.onSubmitListener || Adyen.addListener('onSubmit', this.onPaymentSubmitHandler),
        this.onShowListener || Adyen.addListener('onShow', this.onShowHandler),
        this.onHideListener || Adyen.addListener('onHide', this.onHideHandler),
      ]);

      this.onCardSubmitListener = cardSubmitListener;
      this.onSubmitListener = submitListener;
      this.onShowListener = showListener;
      this.onHideListener = hideListener;
    }
  };

  /**
   * Cleans up the native listeners
   */
  private cleanupNativeListeners = (): void => {
    this.onSubmitListener?.remove?.();
    this.onSubmitListener = undefined;

    this.onCardSubmitListener?.remove?.();
    this.onCardSubmitListener = undefined;

    this.onCardChangeListener?.remove?.();
    this.onCardChangeListener = undefined;

    this.onShowListener?.remove?.();
    this.onShowListener = undefined;

    this.onHideListener?.remove?.();
    this.onHideListener = undefined;
  };

  mount(domNode: HTMLElement | string) {
    if (this.isNative && !this.isNativeComponentOpen) {
      this.presentNativeComponent().catch((error) => {
        console.error('Native component mount error:', error);
        throw error;
      });
    }

    return super.mount(domNode);
  }

  unmount() {
    if (this.isNativeComponentOpen) {
      Adyen.hideComponent()
        .then(() => {
          this.isNativeComponentOpen = false;
        })
        .catch((error) => {
          console.error('Error hiding native component during unmount:', error);
        });
    }

    this.cleanupNativeListeners();

    if (this.forceEditTimeout) clearTimeout(this.forceEditTimeout);

    return super.unmount();
  }

  render() {
    if (!this.isNative) return super.render();
    return this.renderNativeCard();
  }
}

export default Card;
