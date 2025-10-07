// Jest setup file for Capacitor Adyen plugin tests

// Mock Capacitor core
jest.mock('@capacitor/core', () => ({
  registerPlugin: jest.fn(() => ({
    setCurrentPaymentMethods: jest.fn().mockResolvedValue(undefined),
    hideComponent: jest.fn().mockResolvedValue(undefined),
    destroyComponent: jest.fn().mockResolvedValue(undefined),
    addListener: jest.fn().mockResolvedValue({ remove: jest.fn() }),
    removeAllListeners: jest.fn().mockResolvedValue(undefined),
    // Card component methods
    presentCardComponent: jest.fn().mockResolvedValue(undefined)
  })),
  WebPlugin: class MockWebPlugin {
    unavailable(message: string) {
      return new Error(message);
    }
  },
  Capacitor: {
    getPlatform: jest.fn(() => 'web'),
    isNativePlatform: jest.fn(() => false)
  }
}));

// Setup global environment for tests

// Mock console to avoid noise in tests unless explicitly testing logging
global.console = {
  ...console,
  log: jest.fn(),
  debug: jest.fn(),
  info: jest.fn(),
  warn: jest.fn(),
  error: jest.fn()
};