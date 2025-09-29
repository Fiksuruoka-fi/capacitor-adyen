import Foundation
import UIKit
import Capacitor

/**
 * Card component specific functionality encapsulated in a dedicated class.
 * This class handles all card-related operations including creation, configuration,
 * validation, and event handling.
 */
internal class AdyenCardComponent {
    private weak var bridge: AdyenBridge?
    
    init(bridge: AdyenBridge) {
        self.bridge = bridge
    }
    
    /**
     * Creates a configured Card component ready for presentation.
     * 
     * - Parameters:
     *   - amount: Payment amount in minor units
     *   - countryCode: ISO country code
     *   - currencyCode: ISO currency code
     *   - configuration: Card component configuration options
     *   - style: Styling configuration for the component
     * - Returns: A configured UIViewController ready for presentation
     * - Throws: AdyenError if creation fails
     */
    func create(
        amount: Int?,
        countryCode: String?,
        currencyCode: String?,
        configuration: [String: Any]? = nil,
        style: [String: Any]? = nil
    ) throws -> UIViewController {
        
        guard let bridge = bridge,
              let paymentMethods = bridge.currentPaymentMethods,
              let paymentMethod = paymentMethods.paymentMethod(ofType: CardPaymentMethod.self) else {
            throw AdyenError.paymentMethodNotFound
        }

        // Create payment if needed
        let payment = createPaymentIfNeeded(amount: amount, currencyCode: currencyCode, countryCode: countryCode)
        
        // Create Adyen context
        let adyenContext = try AdyenContextFactory.createContext(
            apiContext: bridge.currentContext,
            analyticsConfig: bridge.currentAnalyticsConfig,
            payment: payment
        )
        
        // Create component configuration
        let config = StyleFactory.createCardConfiguration(from: configuration, style: style)
        
        CAPLog.print(PluginConstants.identifier, "Creating card component")
        
        let component = CardComponent(
            paymentMethod: paymentMethod,
            context: adyenContext,
            configuration: config
        )

        // Setup component with bridge delegates
        component.cardComponentDelegate = bridge
        bridge.setActivePaymentComponent(component)
        
        return component.viewController
    }
    
    /**
     * Validates card component creation parameters.
     */
    func validateParameters(
        amount: Int?,
        countryCode: String?,
        currencyCode: String?,
        configuration: [String: Any]?
    ) throws {
        // Add specific validation logic here if needed
        // For now, basic validation is handled by Adyen SDK
    }
    
    /**
     * Creates payment object if all required parameters are provided.
     */
    private func createPaymentIfNeeded(amount: Int?, currencyCode: String?, countryCode: String?) -> Payment? {
        guard let value = amount, let currency = currencyCode, let country = countryCode else { return nil }
        let adyenAmount = Amount(value: value, currencyCode: currency)
        return Payment(amount: adyenAmount, countryCode: country)
    }
    
    /**
     * Retrieves the current active card component if available.
     */
    var activeComponent: CardComponent? {
        return bridge?.currentActivePaymentComponent as? CardComponent
    }
    
    /**
     * Checks if a card component is currently active.
     */
    var isActive: Bool {
        return activeComponent != nil
    }
    
    /**
     * Safely stops the current card component if active.
     */
    func stopIfActive() {
        if let cardComponent = activeComponent {
            cardComponent.stopLoadingIfNeeded()
            CAPLog.print(PluginConstants.identifier, "Stopped active card component")
        }
    }
    
    /**
     * Creates a summary of current card component state for debugging.
     */
    func createStateSummary() -> [String: Any] {
        var summary: [String: Any] = [
            "hasActiveComponent": isActive,
            "timestamp": Date().timeIntervalSince1970
        ]
        
        if let cardComponent = activeComponent {
            summary["componentState"] = [
                "paymentMethodType": cardComponent.paymentMethod.type.rawValue,
                "componentName": String(describing: type(of: cardComponent))
            ]
        }
        
        return summary
    }
    
    /**
     * Handles card component cleanup when dismissing or switching components.
     */
    func cleanup() {
        if let cardComponent = activeComponent {
            cardComponent.stopLoadingIfNeeded()
            CAPLog.print(PluginConstants.identifier, "Cleaned up card component: \(type(of: cardComponent))")
        }
    }
}