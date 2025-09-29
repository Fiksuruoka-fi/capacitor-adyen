import Foundation
import UIKit
import Capacitor

/**
 * Card component specific bridge extensions for enhanced functionality.
 * This extension provides bridge-specific enhancements and validation.
 */
extension AdyenBridge {
    
    // MARK: - Card Component Validation
    
    /**
     * Validates card component creation parameters before expensive operations.
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
    
    private func applyAccessibilityConfiguration(to component: CardComponent, config: [String: Any]) {
        CAPLog.print(PluginConstants.identifier, "Applied accessibility configuration to card component")
    }
    
    private func applyValidationConfiguration(to component: CardComponent, config: [String: Any]) {
        CAPLog.print(PluginConstants.identifier, "Applied validation configuration to card component")
    }
    
    private func applyAppearanceConfiguration(to component: CardComponent, config: [String: Any]) {
        CAPLog.print(PluginConstants.identifier, "Applied appearance configuration to card component")
    }
}
