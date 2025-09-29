import { Card } from '@adyen/adyen-web';
import { Capacitor, type PluginListenerHandle } from '@capacitor/core';
import { Adyen, type CardSubmitEventData, type PaymentSubmitEventData } from '@foodello/capacitor-adyen';
import { createElement, Fragment } from 'preact';

interface CardNativeState {
  componentState: 'loading' | 'submitted';
  cardNumber: string;
  cardBrand: string;
}

class CardWithNativeSupport extends Card {
  private onSubmitListener?: PluginListenerHandle = undefined;
  private onCardSubmitListener?: PluginListenerHandle = undefined;

  private isNative = Capacitor.isNativePlatform();

  private cardNativeState: CardNativeState = {
    componentState: 'loading',
    cardNumber: '',
    cardBrand: '',
  };

  mount(domNode: HTMLElement | string) {
    if (this.isNative) {
      this.presentNativeComponent().catch((error) => {
        console.error(error);
        throw error;
      });
    }
    return super.mount(domNode);
  }

  unmount() {
    this.cleanupNativeListeners();
    return super.unmount();
  }

  render() {
    if (!this.isNative) return super.render();

    return createElement(
      Fragment,
      null,
      createElement('h3', null, 'Card Component with Native Support'),
      createElement('p', null, "This is a custom empty component that uses Adyen's native SDK on iOS and Android."),
      createElement('p', null, 'Please use the native card form that has been presented.'),
      createElement('button', { onClick: this.presentNativeComponent }, 'Show Native Card Form again'),
    );
  }

  private presentNativeComponent = async () => {
    if (!this.isNative) return;

    const { amount, countryCode } = this.props;

    try {
      console.log('Initializing native card component');

      const amountValue = amount?.value ?? 0;
      const currencyCode = (amount?.currency || 'EUR').toUpperCase();
      const cc = countryCode?.toUpperCase();

      await Promise.all([
        this.setupListeners(),
        Adyen.presentCardComponent({
          amount: amountValue,
          currencyCode,
          countryCode: cc,
        }),
      ]);
    } catch (error) {
      console.error(error);
      throw error;
    }
  };

  private onPaymentSubmitHandler = async (data: PaymentSubmitEventData) => {
    console.log('Adyen native onSubmit', data);
    this.setState({ data: data.paymentMethod, valid: {}, errors: {}, isValid: true });

    if (data.paymentMethod.brand && data.paymentMethod.brand !== this.cardNativeState.cardBrand) {
      this.cardNativeState.cardBrand = data.paymentMethod.brand;
    }
    if (this.cardNativeState.componentState !== 'submitted') {
      this.cardNativeState.componentState = 'submitted';
    }

    await Adyen.hideComponent();
  };

  private onCardSubmitHandler = async (data: CardSubmitEventData) => {
    console.log('Adyen native onCardSubmit', data);
    this.cardNativeState.cardNumber = `•••• •••• •••• ${data.lastFour}`;
    this.cardNativeState.componentState = 'submitted';
  };

  private setupListeners = async () => {
    const hasListenersSetAlready = this.onCardSubmitListener && this.onSubmitListener;
    if (!hasListenersSetAlready) {
      console.log('Setting up native card component listeners');

      const [cardSubmitListener, submitListener] = await Promise.all([
        this.onCardSubmitListener || Adyen.addListener('onCardSubmit', this.onCardSubmitHandler),
        this.onSubmitListener || Adyen.addListener('onSubmit', this.onPaymentSubmitHandler),
      ]);

      this.onCardSubmitListener = cardSubmitListener;
      this.onSubmitListener = submitListener;
    }
  };

  private cleanupNativeListeners = () => {
    this.onSubmitListener?.remove?.();
    this.onSubmitListener = undefined;

    this.onCardSubmitListener?.remove?.();
    this.onCardSubmitListener = undefined;
  };
}

export default CardWithNativeSupport;
