import { Adyen } from '../src/bridge';

describe('Adyen Bridge', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('should export Adyen plugin instance', () => {
    expect(Adyen).toBeDefined();
    expect(typeof Adyen).toBe('object');
  });

  it('should have required methods', () => {
    expect(Adyen.setCurrentPaymentMethods).toBeDefined();
    expect(Adyen.hideComponent).toBeDefined();
    expect(Adyen.destroyComponent).toBeDefined();
    expect(Adyen.addListener).toBeDefined();
  });

  it('should have card component methods', () => {
    expect(Adyen.presentCardComponent).toBeDefined();
  });

  describe('setCurrentPaymentMethods', () => {
    it('should accept valid payment methods response', async () => {
      const paymentMethodsResponse = {
        paymentMethods: [
          {
            type: 'scheme',
            name: 'Credit Card'
          }
        ]
      };

      await expect(
        Adyen.setCurrentPaymentMethods({ paymentMethodsJson: paymentMethodsResponse })
      ).resolves.toBeUndefined();

      expect(Adyen.setCurrentPaymentMethods).toHaveBeenCalledWith({
        paymentMethodsJson: paymentMethodsResponse
      });
    });
  });

  describe('component lifecycle', () => {
    it('should hide component', async () => {
      await expect(Adyen.hideComponent()).resolves.toBeUndefined();
      expect(Adyen.hideComponent).toHaveBeenCalled();
    });

    it('should destroy component', async () => {
      await expect(Adyen.destroyComponent()).resolves.toBeUndefined();
      expect(Adyen.destroyComponent).toHaveBeenCalled();
    });
  });

  describe('event listeners', () => {
    it('should add event listeners', async () => {
      const mockListener = jest.fn();
      
      await Adyen.addListener('onSubmit', mockListener);
      
      expect(Adyen.addListener).toHaveBeenCalledWith('onSubmit', mockListener);
    });

    it('should support all required event types', async () => {
      const mockListener = jest.fn();
      
      const eventTypes = [
        'onSubmit',
        'onAdditionalDetails', 
        'onError',
        'onShow',
        'onHide',
        'onCardSubmit',
        'onCardChange'
      ];

      for (const eventType of eventTypes) {
        await Adyen.addListener(eventType as any, mockListener);
        expect(Adyen.addListener).toHaveBeenCalledWith(eventType, mockListener);
      }
    });
  });
});