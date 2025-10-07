export const envConfig = {
  adyen: {
    environment: import.meta.env.VITE_ADYEN_ENVIRONMENT as 'test' | 'live',
    clientKey: import.meta.env.VITE_ADYEN_CLIENT_KEY,
    countryCode: import.meta.env.VITE_ADYEN_COUNTRY_CODE || 'NL',
    locale: import.meta.env.VITE_ADYEN_LOCALE || 'en-US',
  },
  isDev: import.meta.env.VITE_IS_DEV === 'true' || false,
  testNativePresentation: import.meta.env.VITE_TEST_NATIVE_PRESENTATION === 'true' || false,
};

// Validate on app startup
export const validateEnv = (): void => {
  const missing = [];
  if (!envConfig.adyen.environment) missing.push('VITE_ADYEN_ENVIRONMENT');
  if (!envConfig.adyen.clientKey) missing.push('VITE_ADYEN_CLIENT_KEY');

  if (missing.length > 0) {
    throw new Error(`Missing environment variables: ${missing.join(', ')}`);
  }
};
