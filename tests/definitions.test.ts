import type { 
  PaymentMethodsResponse,
  BaseAdyenComponentOptions,
  PaymentSubmitEventData,
  PaymentErrorEventData,
  ComponentHideEventData
} from '../src/definitions';

describe('Type Definitions', () => {
  describe('PaymentMethodsResponse', () => {
    it('should have valid structure', () => {
      const paymentMethods: PaymentMethodsResponse = {
        paymentMethods: [
          {
            type: 'scheme',
            name: 'Credit Card',
            brands: ['visa', 'mc']
          }
        ],
        savedPaymentMethods: []
      };

      expect(paymentMethods.paymentMethods).toBeDefined();
      expect(Array.isArray(paymentMethods.paymentMethods)).toBe(true);
      expect(paymentMethods.savedPaymentMethods).toBeDefined();
    });

    it('should work without savedPaymentMethods', () => {
      const paymentMethods: PaymentMethodsResponse = {
        paymentMethods: [
          {
            type: 'ideal',
            name: 'iDEAL'
          }
        ]
      };

      expect(paymentMethods.paymentMethods).toBeDefined();
      expect(paymentMethods.savedPaymentMethods).toBeUndefined();
    });
  });

  describe('BaseAdyenComponentOptions', () => {
    it('should accept valid options', () => {
      const options: BaseAdyenComponentOptions = {
        amount: 1000,
        countryCode: 'US',
        currencyCode: 'USD'
      };

      expect(options.amount).toBe(1000);
      expect(options.countryCode).toBe('US');
      expect(options.currencyCode).toBe('USD');
    });

    it('should work with partial options', () => {
      const options: BaseAdyenComponentOptions = {
        currencyCode: 'EUR'
      };

      expect(options.currencyCode).toBe('EUR');
      expect(options.amount).toBeUndefined();
      expect(options.countryCode).toBeUndefined();
    });
  });

  describe('Event Data Types', () => {
    it('should validate PaymentSubmitEventData structure', () => {
      const eventData: PaymentSubmitEventData = {
        paymentMethod: {
          type: 'scheme',
          encryptedCardNumber: 'adyen_cse_encrypted_card_number',
          encryptedExpiryMonth: 'adyen_cse_encrypted_expiry_month',
          encryptedExpiryYear: 'adyen_cse_encrypted_expiry_year',
          encryptedSecurityCode: 'adyen_cse_encrypted_security_code'
        },
        componentType: 'card',
        browserInfo: {
          userAgent: 'Mozilla/5.0 (Test Browser)'
        },
        amount: {
          value: 1000,
          currency: 'USD'
        },
        storePaymentMethod: false
      };

      expect(eventData.paymentMethod).toBeDefined();
      expect(eventData.componentType).toBe('card');
      expect(eventData.browserInfo?.userAgent).toContain('Mozilla');
      expect(eventData.amount?.value).toBe(1000);
      expect(eventData.storePaymentMethod).toBe(false);
    });

    it('should validate PaymentErrorEventData structure', () => {
      const errorData: PaymentErrorEventData = {
        message: 'Invalid card number',
        code: 'validation_error',
        field: 'cardNumber'
      };

      expect(errorData.message).toBe('Invalid card number');
      expect(errorData.code).toBe('validation_error');
    });

    it('should validate ComponentHideEventData structure', () => {
      const hideData: ComponentHideEventData = {
        reason: 'user_gesture'
      };

      expect(hideData.reason).toBe('user_gesture');
    });
  });

  describe('Environment Configuration', () => {
    it('should accept valid environment values', () => {
      const validEnvironments = ['test', 'liveApse', 'liveUs', 'liveEu', 'liveAu'] as const;
      
      validEnvironments.forEach(env => {
        expect(validEnvironments).toContain(env);
      });
    });
  });
});