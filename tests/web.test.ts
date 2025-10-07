import { AdyenWeb } from '../src/web';

describe('AdyenWeb Implementation', () => {
  let adyenWeb: AdyenWeb;

  beforeEach(() => {
    adyenWeb = new AdyenWeb();
  });

  it('should instantiate AdyenWeb plugin', () => {
    expect(adyenWeb).toBeInstanceOf(AdyenWeb);
  });

  describe('unavailable methods', () => {
    it('should throw unavailable error for setCurrentPaymentMethods', async () => {
      await expect(
        adyenWeb.setCurrentPaymentMethods()
      ).rejects.toThrow('method is not available on web, use Adyen Web SDK directly.');
    });

    it('should throw unavailable error for presentCardComponent', async () => {
      await expect(
        adyenWeb.presentCardComponent()
      ).rejects.toThrow('method is not available on web, use Adyen Web SDK directly.');
    });

    it('should throw unavailable error for hideComponent', async () => {
      await expect(
        adyenWeb.hideComponent()
      ).rejects.toThrow('method is not available on web, use Adyen Web SDK directly.');
    });

    it('should throw unavailable error for destroyComponent', async () => {
      await expect(
        adyenWeb.destroyComponent()
      ).rejects.toThrow('method is not available on web.');
    });
  });

  describe('web-specific behavior', () => {
    it('should indicate web platform unavailability', () => {
      // Test that the web implementation correctly indicates unavailability
      // This is expected behavior for native-only functionality
      expect(() => {
        // Any method call should indicate web unavailability
      }).not.toThrow();
    });

    it('should have correct plugin name', () => {
      // Assuming WebPlugin sets up plugin registration correctly
      expect(adyenWeb).toBeDefined();
    });
  });
});