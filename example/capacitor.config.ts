import type { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.example.app',
  appName: 'adyen-example',
  webDir: 'dist',
  loggingBehavior: 'debug',
  plugins: {
    Adyen: {
      environment: 'test', // Change to 'live' for production
      clientKey: 'test_O3LEH54C3JDPREE3QOEPOCRG4QGEICBQ', // Client key from Adyen's https://mystoredemo.io -> Does not work on localhost, use your own key in real implementation
    },
  },
};

export default config;
