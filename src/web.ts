import { WebPlugin } from '@capacitor/core';

import type { AdyenPlugin } from './definitions';

export class AdyenWeb extends WebPlugin implements AdyenPlugin {
  async setCurrentPaymentMethods(): Promise<void> {
    throw this.unavailable('method is not available on web, use Adyen Web SDK directly.');
  }

  async presentCardComponent(): Promise<void> {
    throw this.unavailable('method is not available on web, use Adyen Web SDK directly.');
  }

  async presentDropInComponent(): Promise<void> {
    throw this.unavailable('method is not available on web, use Adyen Web SDK directly.');
  }

  async presentIdealComponent(): Promise<void> {
    throw this.unavailable('method is not available on web, use Adyen Web SDK directly.');
  }

  async presentPayPalComponent(): Promise<void> {
    throw this.unavailable('method is not available on web, use Adyen Web SDK directly.');
  }

  async presentBancontactComponent(): Promise<void> {
    throw this.unavailable('method is not available on web, use Adyen Web SDK directly.');
  }

  async hideComponent(): Promise<void> {
    throw this.unavailable('method is not available on web, use Adyen Web SDK directly.');
  }
}
