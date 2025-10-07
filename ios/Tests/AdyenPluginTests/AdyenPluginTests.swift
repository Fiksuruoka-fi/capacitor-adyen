import XCTest
import Capacitor
@testable import AdyenPlugin

class AdyenPluginTests: XCTestCase {
    var plugin: AdyenPlugin!
    
    override func setUp() {
        super.setUp()
        plugin = AdyenPlugin()
    }
    
    override func tearDown() {
        plugin = nil
        super.tearDown()
    }
    
    func testPluginIdentifier() {
        XCTAssertEqual(plugin.identifier, "AdyenPlugin")
        XCTAssertEqual(plugin.jsName, "Adyen")
    }
    
    func testPluginMethods() {
        let expectedMethods = [
            "setCurrentPaymentMethods",
            "presentCardComponent",
            "hideComponent"
        ]
        
        let actualMethodNames = plugin.pluginMethods.map { $0.name }
        
        for expectedMethod in expectedMethods {
            XCTAssertTrue(actualMethodNames.contains(expectedMethod), 
                         "Plugin should have method: \(expectedMethod)")
        }
    }
    
    func testSetCurrentPaymentMethodsWithoutInitialization() {
        let call = createMockCall(data: [
            "paymentMethodsJson": [
                "paymentMethods": [
                    ["type": "scheme", "name": "Credit Card"]
                ]
            ]
        ])
        
        plugin.setCurrentPaymentMethods(call)
        
        // Should reject because plugin is not initialized
        XCTAssertTrue(call.isRejected)
        XCTAssertEqual(call.rejectionMessage, "Adyen not initialized")
    }
    
    func testSetCurrentPaymentMethodsWithInvalidData() {
        let call = createMockCall(data: [:])
        
        plugin.setCurrentPaymentMethods(call)
        
        XCTAssertTrue(call.isRejected)
        XCTAssertEqual(call.rejectionMessage, "Invalid or missing payment methods json")
    }
    
    func testPresentCardComponentWithoutInitialization() {
        let call = createMockCall(data: [
            "amount": 1000,
            "countryCode": "US",
            "currencyCode": "USD"
        ])
        
        plugin.presentCardComponent(call)
        
        XCTAssertTrue(call.isRejected)
        XCTAssertEqual(call.rejectionMessage, "Adyen not initialized")
    }
    
    func testHideComponent() {
        let call = createMockCall(data: [:])
        
        plugin.hideComponent(call)
        
        XCTAssertTrue(call.isResolved)
    }
    
    func testPluginLoad() {
        // Test plugin load behavior
        // Note: This will not fully initialize due to missing configuration
        // but we can test that it doesn't crash
        plugin.load()
        
        // Plugin should handle missing configuration gracefully
        XCTAssertNil(plugin.implementation)
    }
    
    // MARK: - Helper Methods
    
    private func createMockCall(data: [String: Any]) -> MockPluginCall {
        return MockPluginCall(data: data)
    }
}

// MARK: - Mock Classes

class MockPluginCall: CAPPluginCall {
    private let mockData: [String: Any]
    private var resolved = false
    private var rejected = false
    private var _rejectionMessage: String?
    
    init(data: [String: Any]) {
        self.mockData = data
        super.init(callbackId: "test", options: data, success: { _ in }, error: { _ in })
    }
    
    var isResolved: Bool { return resolved }
    var isRejected: Bool { return rejected }
    var rejectionMessage: String? { return _rejectionMessage }
    
    override func resolve() {
        resolved = true
    }
    
    override func resolve(_ data: PluginCallResultData) {
        resolved = true
    }
    
    override func reject(_ message: String) {
        rejected = true
        _rejectionMessage = message
    }
    
    override func reject(_ message: String, _ error: Error?) {
        rejected = true
        _rejectionMessage = message
    }
    
    override func reject(_ message: String, _ code: String?) {
        rejected = true
        _rejectionMessage = message
    }
    
    override func reject(_ message: String, _ code: String?, _ error: Error?) {
        rejected = true
        _rejectionMessage = message
    }
    
    override func getObject(_ key: String) -> JSObject? {
        return mockData[key] as? JSObject
    }
    
    override func getString(_ key: String) -> String? {
        return mockData[key] as? String
    }
    
    override func getInt(_ key: String) -> Int? {
        return mockData[key] as? Int
    }
    
    override func getBool(_ key: String) -> Bool? {
        return mockData[key] as? Bool
    }
}
