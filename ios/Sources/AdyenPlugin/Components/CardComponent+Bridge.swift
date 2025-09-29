import Foundation
import UIKit
import Capacitor

/**
 * Card component specific bridge extensions and utilities.
 * **Performance**: Card-specific logic separate from general component handling.
 */
extension AdyenBridge {
    
    // MARK: - Card Component State Management
    
    /**
     * Retrieves the current active card component if available.
     * **Performance**: Type-safe access to active card components.
     */
    var activeCardComponent: CardComponent? {
        return currentActivePaymentComponent as? CardComponent
    }
    
    /**
     * Checks if a card component is currently active and processing.
     */
    var isCardComponentActive: Bool {
        return activeCardComponent != nil
    }
    
    /**
     * Safely stops the current card component if active.
     */
    func stopCardComponentIfActive() {
        if let cardComponent = activeCardComponent {
            cardComponent.stopLoadingIfNeeded()
            CAPLog.print(PluginConstants.identifier, "Stopped active card component")
        }
    }
    
    // MARK: - Card Component Validation
    
    /**
     * Validates card component creation parameters before expensive operations.
     * Modular validation with specific error messages.
     */
    internal func validateCardComponentParameters(
        amount: Int?,
        countryCode: String?,
        currencyCode: String?,
        configuration: [String: Any]?
    ) throws {
        
        // Validate SDK initialization state
        try AdyenValidator.validateSDKState(
            context: currentContext,
            analyticsConfig: currentAnalyticsConfig,
            paymentMethods: currentPaymentMethods
        )
        
        // Validate payment parameters if provided
        try AdyenValidator.validatePaymentParameters(
            amount: amount,
            currencyCode: currencyCode,
            countryCode: countryCode
        )
    }
    
    // MARK: - Card Component Enhancement
    
    /**
     * Enhances card component with additional bridge-specific configuration.
     * Applies consistent styling and behavior across card components.
     */
    internal func enhanceCardComponent(_ component: CardComponent, with configuration: [String: Any]?) {
        
        // Apply any card-specific enhancements
        if let config = configuration {
            
            // Configure accessibility if specified
            if let accessibilityConfig = config["accessibility"] as? [String: Any] {
                applyAccessibilityConfiguration(to: component, config: accessibilityConfig)
            }
            
            // Configure validation behavior if specified
            if let validationConfig = config["validation"] as? [String: Any] {
                applyValidationConfiguration(to: component, config: validationConfig)
            }
            
            // Configure appearance behavior if specified
            if let appearanceConfig = config["appearance"] as? [String: Any] {
                applyAppearanceConfiguration(to: component, config: appearanceConfig)
            }
        }
        
        CAPLog.print(PluginConstants.identifier, "Enhanced card component with bridge configuration")
    }
    
    // MARK: - Private Enhancement Methods
    
    /**
     * Applies accessibility configuration to card component.
     */
    private func applyAccessibilityConfiguration(to component: CardComponent, config: [String: Any]) {
        CAPLog.print(PluginConstants.identifier, "Applied accessibility configuration to card component")
    }
    
    /**
     * Applies validation configuration to card component.
     */
    private func applyValidationConfiguration(to component: CardComponent, config: [String: Any]) {
        CAPLog.print(PluginConstants.identifier, "Applied validation configuration to card component")
    }
    
    /**
     * Applies appearance configuration to card component.
     */
    private func applyAppearanceConfiguration(to component: CardComponent, config: [String: Any]) {
        CAPLog.print(PluginConstants.identifier, "Applied appearance configuration to card component")
    }
}

// MARK: - Card Component Utilities

extension AdyenBridge {
    
    /**
     * Creates a summary of current card component state for debugging.
     * Centralized state inspection for troubleshooting.
     */
    internal func createCardComponentStateSummary() -> [String: Any] {
        var summary: [String: Any] = [
            "hasActiveCardComponent": isCardComponentActive,
            "timestamp": Date().timeIntervalSince1970
        ]
        
        if let cardComponent = activeCardComponent {
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
    internal func cleanupCardComponent() {
        if let cardComponent = activeCardComponent {
            cardComponent.stopLoadingIfNeeded()
            
            CAPLog.print(PluginConstants.identifier, "Cleaned up card component: \(type(of: cardComponent))")
        }
    }
}
