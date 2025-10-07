import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { AdyenCheckout, Core, type CoreConfiguration, type PaymentResponseData } from '@adyen/adyen-web';
import { Capacitor } from '@capacitor/core';
import {
  Adyen,
  Card as CardWithNativeSupport,
  type ExtendedCardConfiguration,
  type CardComponentOptions,
} from '@foodello/capacitor-adyen';
import { useEffect, useRef, useState } from 'react';
import { envConfig } from './config/env';

import '@adyen/adyen-web/styles/adyen.css';
import '@foodello/capacitor-adyen/dist/esm/styles.css';

function App() {
  const environment = envConfig.adyen.environment;
  const clientKey = envConfig.adyen.clientKey;
  const countryCode = envConfig.adyen.countryCode;
  const locale = envConfig.adyen.locale;
  const isDev = envConfig.isDev;
  const testNativePresentation = envConfig.testNativePresentation;

  const PAYMENT_METHOD_JSON = {
    // Your payment methods response here
    paymentMethods: [
      {
        type: 'scheme',
        name: 'Cards',
        brands: ['mc', 'visa'],
      },
    ],
  };

  const globalConfiguration: CoreConfiguration = {
    countryCode,
    locale,
    environment,
    clientKey,
    analytics: {
      enabled: false,
    },
    paymentMethodsResponse: PAYMENT_METHOD_JSON,
    onPaymentCompleted: (result, component) => {
      console.log('Payment completed', result, component);
    },
    onPaymentFailed: (error, component) => {
      console.error('Payment failed', error, component);
    },
    onError: (error) => {
      console.error(error);
    },
    beforeSubmit: (state, component, actions) => {
      console.log('beforeSubmit', state, component, actions);
    },
    onSubmit: (state, component, actions) => {
      console.log('onSubmit', state, component, actions);
      // Mimic a successful payment submission
      // In real implementation, you would send `state.data` to your server
      // and get the payment response from Adyen's /payments API
      // and then call `actions.handleResponse` with that response.
      // Here we just call it with an empty object to simulate success.
      const response: PaymentResponseData = {
        resultCode: 'Authorised',
        type: 'scheme',
      };
      actions.resolve(response);
    },
    onAdditionalDetails: (state, component, actions) => {
      console.log('onAdditionalDetails', state, component, actions);
    },
    onActionHandled: () => {
      console.log('onActionHandled');
    },
    onChange: (state, component) => {
      console.log('onChange', state, component);
    },
  };

  const cardConfiguration: ExtendedCardConfiguration = {
    /** Your Adyen card configuration here */
    isDev,
    testNativePresentation,
  };

  const containerRef = useRef(null);
  const coreRef = useRef<Core>(null);
  const [isInitialized, setIsInitialized] = useState(false);

  const initializeAdyen = async () => {
    if (isInitialized || !containerRef.current) return;

    try {
      await new Promise((resolve) => setTimeout(resolve, 100));

      console.log('Initializing Adyen checkout...', globalConfiguration);
      coreRef.current = await AdyenCheckout(globalConfiguration);
      console.log('Adyen checkout created successfully');

      if (Capacitor.isNativePlatform()) {
        await Adyen.setCurrentPaymentMethods({
          paymentMethodsJson: PAYMENT_METHOD_JSON,
        });
        console.log('Payment methods set for native platform');
      }

      if (containerRef.current && coreRef.current) {
        const cardComponent = new CardWithNativeSupport(coreRef.current, cardConfiguration);
        cardComponent.mount(containerRef.current);
        setIsInitialized(true);
      }
    } catch (error) {
      console.error('Failed to initialize Adyen:', error);
    }
  };

  useEffect(() => {
    initializeAdyen();
  }, [initializeAdyen]);

  const presentCardComponent = async (options?: CardComponentOptions) => {
    if (!Capacitor.isNativePlatform()) return;

    try {
      await Adyen.presentCardComponent(options);
    } catch (error) {
      console.error('Error presenting native card component', error);
    }
  };

  // This should now render Adyen's web card component on web,
  // and your custom component on native platforms by opening
  // native Adyen Card component when component is mounted.

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <div className="text-center mb-12">
          <h1 className="text-4xl font-bold text-slate-900 mb-4">Capacitor Adyen Example</h1>
          <p className="text-lg text-slate-600 max-w-2xl mx-auto">
            Test the Adyen payment integration with both web and native components
          </p>
        </div>

        {/* Default Hybrid Card Component */}
        <div className="max-w-2xl mx-auto mb-12">
          <Card className="shadow-lg border-0 bg-white/80 backdrop-blur-sm">
            <CardHeader className="pb-4">
              <CardTitle className="text-2xl font-semibold text-slate-800 flex items-center gap-2">
                <div className="w-2 h-2 bg-green-500 rounded-full"></div>
                Card Component
              </CardTitle>
              <p className="text-sm text-slate-600">
                Default implementation - works on all platforms
                <br />
                <small>Loads form in web and opens native component on mobile</small>
              </p>
            </CardHeader>
            <CardContent className="pt-0">
              <div ref={containerRef} className="min-h-[200px] rounded-lg border border-slate-200 bg-slate-50/50 p-4" />
            </CardContent>
          </Card>
        </div>

        {/* Native Form Styling Options */}
        <div className="max-w-4xl mx-auto">
          <Card className="shadow-lg border-0 bg-white/80 backdrop-blur-sm">
            <CardHeader className="pb-6">
              <CardTitle className="text-2xl font-semibold text-slate-800 flex items-center gap-2">
                <div className="w-2 h-2 bg-blue-500 rounded-full"></div>
                Native Form Styling
              </CardTitle>
              <p className="text-sm text-slate-600">
                Test different Adyen form styling configurations
                {!Capacitor.isNativePlatform() && (
                  <span className="ml-2 inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-amber-100 text-amber-800">
                    Web Platform - Native buttons disabled
                  </span>
                )}
              </p>
            </CardHeader>
            <CardContent className="pt-0">
              <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
                <Button
                  onClick={() =>
                    presentCardComponent({
                      amount: 0, // Preauthorizing card requires zero amount
                      countryCode: 'NL',
                      currencyCode: 'EUR',
                    })
                  }
                  disabled={!Capacitor.isNativePlatform()}
                  className="h-auto py-4 px-6 flex-col items-start text-left bg-slate-900 hover:bg-slate-800"
                >
                  <span className="font-semibold text-white">Default</span>
                  <span className="text-xs text-slate-300 mt-1">Pre-authorize card only</span>
                </Button>

                <Button
                  onClick={() =>
                    presentCardComponent({
                      amount: 2500,
                      currencyCode: 'EUR',
                      countryCode: 'FI',
                      configuration: {
                        localizationParameters: {
                          languageOverride: 'fi',
                        },
                      },
                      viewOptions: {
                        title: 'Quick Payment',
                        titleColor: '#1e293b',
                        titleTintColor: '#3b82f6',
                        titleBackgroundColor: '#f8fafc',
                        showsCloseButton: true,
                      },
                      style: {
                        backgroundColor: '#f8fafc',
                        tintColor: '#3b82f6',
                        textField: {
                          titleColor: '#1e293b',
                          textColor: '#0f172a',
                          tintColor: '#3b82f6',
                        },
                        switch: {
                          titleColor: '#1e293b',
                          tintColor: '#3b82f6',
                        },
                      },
                    })
                  }
                  disabled={!Capacitor.isNativePlatform()}
                  className="h-auto py-4 px-6 flex-col items-start text-left bg-blue-600 hover:bg-blue-700"
                  variant="default"
                >
                  <span className="font-semibold text-white">Blue Theme</span>
                  <span className="text-xs text-blue-100 mt-1">€25.00 with dark title</span>
                </Button>

                <Button
                  onClick={() =>
                    presentCardComponent({
                      amount: 15000,
                      currencyCode: 'GBP',
                      countryCode: 'GB',
                      viewOptions: {
                        title: 'Dark Mode Payment',
                        titleColor: '#ffffff',
                        titleTintColor: '#10b981',
                        titleBackgroundColor: '#1e293b',
                        showsCloseButton: true,
                      },
                      style: {
                        backgroundColor: '#1e293b',
                        tintColor: '#10b981',
                        separatorColor: '#374151',
                        textField: {
                          titleColor: '#f1f5f9',
                          textColor: '#ffffff',
                          placeholderColor: '#94a3b8',
                          backgroundColor: '#334155',
                          tintColor: '#10b981',
                          separatorColor: '#475569',
                        },
                        switch: {
                          titleColor: '#f1f5f9',
                          tintColor: '#10b981',
                        },
                        button: {
                          backgroundColor: '#10b981',
                          textColor: '#ffffff',
                          cornerRadius: 8,
                        },
                      },
                    })
                  }
                  disabled={!Capacitor.isNativePlatform()}
                  className="h-auto py-4 px-6 flex-col items-start text-left bg-slate-800 hover:bg-slate-900"
                  variant="default"
                >
                  <span className="font-semibold text-white">Dark Theme</span>
                  <span className="text-xs text-slate-300 mt-1">£150.00 with white title</span>
                </Button>

                <Button
                  onClick={() =>
                    presentCardComponent({
                      amount: 500,
                      currencyCode: 'USD',
                      countryCode: 'US',
                      configuration: {
                        showsHolderNameField: true,
                        showsSecurityCodeField: true,
                        showsStorePaymentMethodField: true,
                      },
                      viewOptions: {
                        title: 'Premium Card Storage',
                        titleColor: '#92400e',
                        titleTintColor: '#f59e0b',
                        showsCloseButton: true,
                      },
                      style: {
                        backgroundColor: '#fef3c7',
                        tintColor: '#f59e0b',
                        textField: {
                          titleColor: '#92400e',
                          textColor: '#451a03',
                          backgroundColor: '#fffbeb',
                          tintColor: '#f59e0b',
                          titleFont: {
                            size: 16,
                            weight: 'semibold',
                          },
                          textFont: {
                            size: 18,
                            weight: 'medium',
                          },
                        },
                        switch: {
                          titleColor: '#92400e',
                          tintColor: '#f59e0b',
                        },
                        button: {
                          backgroundColor: '#f59e0b',
                          textColor: '#ffffff',
                          cornerRadius: 12,
                          font: {
                            size: 18,
                            weight: 'bold',
                          },
                        },
                      },
                    })
                  }
                  disabled={!Capacitor.isNativePlatform()}
                  className="h-auto py-4 px-6 flex-col items-start text-left bg-amber-600 hover:bg-amber-700"
                  variant="default"
                >
                  <span className="font-semibold text-white">Golden Theme</span>
                  <span className="text-xs text-amber-100 mt-1">$5.00 with amber title</span>
                </Button>

                <Button
                  onClick={() =>
                    presentCardComponent({
                      amount: 9999,
                      currencyCode: 'EUR',
                      countryCode: 'BE',
                      viewOptions: {
                        title: 'Sky Theme Payment',
                        titleColor: '#0c4a6e',
                        titleTintColor: '#0ea5e9',
                        titleBackgroundColor: '#f0f9ff',
                        showsCloseButton: true,
                      },
                      style: {
                        backgroundColor: '#f0f9ff',
                        tintColor: '#0ea5e9',
                        textField: {
                          titleColor: '#0c4a6e',
                          textColor: '#0f172a',
                          backgroundColor: '#ffffff',
                          separatorColor: '#0ea5e9',
                          tintColor: '#0ea5e9',
                          icon: {
                            tintColor: '#0ea5e9',
                            backgroundColor: '#f0f9ff',
                            borderColor: '#0ea5e9',
                            borderWidth: 1,
                            cornerRadius: 6,
                          },
                        },
                        switch: {
                          titleColor: '#0c4a6e',
                          tintColor: '#0ea5e9',
                        },
                        button: {
                          backgroundColor: '#0ea5e9',
                          textColor: '#ffffff',
                          cornerRadius: 6,
                        },
                      },
                    })
                  }
                  disabled={!Capacitor.isNativePlatform()}
                  className="h-auto py-4 px-6 flex-col items-start text-left bg-sky-600 hover:bg-sky-700"
                  variant="default"
                >
                  <span className="font-semibold text-white">Sky Theme</span>
                  <span className="text-xs text-sky-100 mt-1">€99.99 with blue title</span>
                </Button>

                <Button
                  onClick={() =>
                    presentCardComponent({
                      configuration: {
                        allowedCardTypes: ['visa'],
                      },
                      viewOptions: {
                        title: 'Pink Theme',
                        titleColor: '#be185d',
                        titleBackgroundColor: '#fdf2f8',
                        titleTintColor: '#ec4899',
                        showsCloseButton: true,
                      },
                      style: {
                        backgroundColor: '#fdf2f8',
                        tintColor: '#ec4899',
                        textField: {
                          titleColor: '#be185d',
                          textColor: '#831843',
                          placeholderColor: '#f9a8d4',
                          backgroundColor: '#fce7f3',
                          tintColor: '#ec4899',
                          titleFont: {
                            size: 14,
                            weight: 'medium',
                          },
                          textFont: {
                            size: 16,
                            weight: 'regular',
                          },
                        },
                        switch: {
                          titleColor: '#be185d',
                          tintColor: '#ec4899',
                        },
                        hint: {
                          color: '#be185d',
                          font: {
                            size: 12,
                            weight: 'light',
                          },
                        },
                        button: {
                          backgroundColor: '#ec4899',
                          textColor: '#ffffff',
                          cornerRadius: 16,
                        },
                      },
                    })
                  }
                  disabled={!Capacitor.isNativePlatform()}
                  className="h-auto py-4 px-6 flex-col items-start text-left bg-pink-600 hover:bg-pink-700"
                  variant="default"
                >
                  <span className="font-semibold text-white">Pink Theme</span>
                  <span className="text-xs text-pink-100 mt-1">Visa only with pink title</span>
                </Button>
              </div>

              {!Capacitor.isNativePlatform() && (
                <div className="mt-6 p-4 bg-amber-50 border border-amber-200 rounded-lg">
                  <p className="text-sm text-amber-800">
                    <strong>Note:</strong> Native form styling buttons are disabled in web environment. Test on iOS or
                    Android to see the custom Adyen form themes in action.
                  </p>
                </div>
              )}
            </CardContent>
          </Card>
        </div>

        {/* Footer */}
        <div className="text-center mt-12 text-sm text-slate-500">
          <p>Built with Capacitor + Adyen + Tailwind CSS</p>
        </div>
      </div>
    </div>
  );
}

export default App;
