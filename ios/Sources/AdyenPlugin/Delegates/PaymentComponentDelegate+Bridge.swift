import Foundation
import Capacitor

/**
 * PaymentComponentDelegate implementation for AdyenBridge.
 * Handles payment submission and error events from all payment components.
 */
extension AdyenBridge: PaymentComponentDelegate {
    
    /**
     * Called when a payment component submits payment data.
     * Serializes the payment data and forwards it to the JavaScript bridge.
     *
     * - Parameters:
     *   - data: The payment component data containing payment method, browser info, etc.
     *   - component: The payment component that submitted the data
     */
    public func didSubmit(_ data: PaymentComponentData, from component: PaymentComponent) {
        guard let plugin = plugin else {
            CAPLog.print(PluginConstants.identifier, "Plugin reference is nil")
            return
        }
        
        do {
            let jsonData = try PaymentDataSerializer.serialize(data)
            let componentType = getComponentType(from: component)
            
            var eventData = jsonData
            eventData["componentType"] = componentType
            eventData["timestamp"] = Date().timeIntervalSince1970
            
            CAPLog.print(PluginConstants.identifier, "Payment data submitted from \(componentType) component")
            
            plugin.notifyListeners("onSubmit", data: eventData)
            
        } catch {
            let adyenError = AdyenError.from(error, context: "Payment data serialization")
            adyenError.logError(context: "Failed to serialize payment data from \(getComponentType(from: component))")
            
            plugin.notifyListeners("onError", data: adyenError.toCapacitorErrorData().merging([
                "componentType": getComponentType(from: component),
                "source": "paymentComponentDelegate"
            ]) { _, new in new })
        }
    }

    /**
     * Called when a payment component fails with an error.
     * Forwards the error information to the JavaScript bridge.
     *
     * - Parameters:
     *   - error: The error that occurred during payment processing
     *   - component: The payment component where the error occurred
     */
    public func didFail(with error: Error, from component: PaymentComponent) {
        guard let plugin = plugin else {
            CAPLog.print(PluginConstants.identifier, "Plugin reference is nil")
            return
        }
        
        let componentType = getComponentType(from: component)
        let adyenError = AdyenError.from(error, context: "Payment component failure")
        
        adyenError.logError(context: "Payment failed from \(componentType) component")
        
        let errorData = adyenError.toCapacitorErrorData().merging([
            "componentType": componentType,
            "source": "paymentComponentDelegate",
            "nativeErrorCode": (error as NSError).code,
            "nativeErrorDomain": (error as NSError).domain
        ]) { _, new in new }
        
        plugin.notifyListeners("onError", data: errorData)
    }
    
    /**
     * Called when a payment component starts loading.
     * Notifies the JavaScript bridge about the loading state change.
     *
     * - Parameter component: The payment component that started loading
     */
    public func didStartLoading(component: PaymentComponent) {
        guard let plugin = plugin else {
            CAPLog.print(PluginConstants.identifier, "Plugin reference is nil")
            return
        }
        
        let componentType = getComponentType(from: component)
        CAPLog.print(PluginConstants.identifier, "\(componentType) component started loading")
        
        let loadingData: [String: Any] = [
            "componentType": componentType,
            "isLoading": true,
            "timestamp": Date().timeIntervalSince1970,
            "source": "paymentComponentDelegate"
        ]
        
        plugin.notifyListeners("onLoadingStateChange", data: loadingData)
    }
    
    /**
     * Called when a payment component stops loading.
     * Notifies the JavaScript bridge about the loading state change.
     *
     * - Parameter component: The payment component that stopped loading
     */
    public func didStopLoading(component: PaymentComponent) {
        guard let plugin = plugin else {
            CAPLog.print(PluginConstants.identifier, "Plugin reference is nil")
            return
        }
        
        let componentType = getComponentType(from: component)
        CAPLog.print(PluginConstants.identifier, "\(componentType) component stopped loading")
        
        let loadingData: [String: Any] = [
            "componentType": componentType,
            "isLoading": false,
            "timestamp": Date().timeIntervalSince1970,
            "source": "paymentComponentDelegate"
        ]
        
        plugin.notifyListeners("onLoadingStateChange", data: loadingData)
    }
}

/**
 * Internal helper methods for payment component delegate functionality.
 */
internal extension AdyenBridge {
    
    /**
     * Extracts the component type identifier from a payment component.
     * Used for consistent component identification across delegate methods.
     *
     * - Parameter component: The payment component to identify
     * - Returns: String identifier for the component type
     */
    func getComponentType(from component: PaymentComponent) -> String {
        // Map known component types to more user-friendly names
        let paymentMethodType = component.paymentMethod.type.rawValue
        
        switch paymentMethodType {
        case "scheme":
            return "card"
        case "ideal":
            return "ideal"
        case "paypal":
            return "paypal"
        case "googlepay":
            return "googlePay"
        case "applepay":
            return "applePay"
        case "klarna":
            return "klarna"
        case "sofort":
            return "sofort"
        case "bancontact_card":
            return "bancontact"
        case "eps":
            return "eps"
        case "giropay":
            return "giropay"
        case "sepadirectdebit":
            return "sepaDirectDebit"
        default:
            return paymentMethodType
        }
    }
    
    /**
     * Validates that a payment component is in a valid state for processing.
     * Throws an error if the component cannot process payments.
     *
     * - Parameter component: The payment component to validate
     * - Throws: AdyenError if the component is invalid
     */
    func validatePaymentComponent(_ component: PaymentComponent) throws {
        // Check if component is properly initialized
        guard !component.paymentMethod.type.rawValue.isEmpty else {
            throw AdyenError.componentCreationFailed("Payment method type is empty")
        }
        
        // Ensure the component has access to required context
        if component.context.payment == nil {
            CAPLog.print(PluginConstants.identifier, "⚠️ Component created without payment context - some features may be limited")
        }
    }
    
    /**
     * Creates a summary of payment component data for logging purposes.
     * Excludes sensitive information like card numbers or personal data.
     *
     * - Parameter data: The payment component data to summarize
     * - Returns: Dictionary with safe logging information
     */
    func createPaymentDataSummary(_ data: PaymentComponentData) -> [String: Any] {
        var summary: [String: Any] = [
            "hasAmount": data.amount != nil,
            "hasBrowserInfo": data.browserInfo != nil,
            "hasOrder": data.order != nil,
            "storePaymentMethod": data.storePaymentMethod ?? false
        ]
        
        if let amount = data.amount {
            summary["amount"] = [
                "currency": amount.currencyCode,
                "value": amount.value
            ]
        }
        
        if let browserInfo = data.browserInfo {
            summary["browserInfo"] = [
                "userAgent": browserInfo.userAgent?.prefix(50) // Truncate for logging
            ]
        }
        
        return summary
    }
}
