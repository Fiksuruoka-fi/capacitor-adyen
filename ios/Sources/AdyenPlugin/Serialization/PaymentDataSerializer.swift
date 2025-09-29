import Foundation
import Capacitor

/**
 * Centralized serialization utilities for Adyen payment data.
 * Handles conversion between native Adyen objects and JavaScript-compatible dictionaries.
 */
internal struct PaymentDataSerializer {
    
    // MARK: - JSON Encoders & Decoders
    
    private static let jsonEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = []
        return encoder
    }()

    private static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    // MARK: - Payment Methods Handling
    
    /**
     * Decodes payment methods from JSON data received from the server.
     * **Performance**: Uses cached decoder for efficiency.
     *
     * - Parameter data: JSON data containing payment methods
     * - Returns: Decoded PaymentMethods object
     * - Throws: AdyenError.invalidPaymentMethods if decoding fails
     */
    static func decodePaymentMethods(from data: Data) throws -> PaymentMethods {
        do {
            return try jsonDecoder.decode(PaymentMethods.self, from: data)
        } catch let decodingError as DecodingError {
            throw AdyenError.invalidPaymentMethods(decodingError.localizedDescription)
        }
    }
    
    // MARK: - Payment Component Data Serialization
    
    /**
     * Serializes PaymentComponentData to a dictionary for JavaScript bridge.
     * **Style Consistency**: Converts all nested objects to compatible formats.
     *
     * - Parameter data: Payment component data to serialize
     * - Returns: Dictionary representation suitable for Capacitor bridge
     * - Throws: AdyenError.serializationFailed if conversion fails
     */
    static func serialize(_ data: PaymentComponentData) throws -> [String: Any] {
        var jsonData: [String: Any] = [:]
        
        do {
            // Serialize payment method data
            let paymentMethodData = try JSONSerialization.jsonObject(
                with: jsonEncoder.encode(data.paymentMethod.encodable),
                options: []
            )
            
            if let paymentMethodDict = paymentMethodData as? [String: Any] {
                jsonData["paymentMethod"] = paymentMethodDict
            }
            
            // Add browser info if available
            if let browserInfo = data.browserInfo {
                jsonData["browserInfo"] = serializeBrowserInfo(browserInfo)
            }
            
            // Add order information if available
            if let order = data.order {
                jsonData["order"] = serializeOrder(order)
            }
            
            // Add amount if available
            if let amount = data.amount {
                jsonData["amount"] = serializeAmount(amount)
            }
            
            // Add store payment method preference if available
            if let storePaymentMethod = data.storePaymentMethod {
                jsonData["storePaymentMethod"] = storePaymentMethod
            }
            
            return jsonData
            
        } catch {
            throw AdyenError.serializationFailed("Failed to serialize PaymentComponentData: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Action Component Data Serialization
    
    /**
     * Serializes ActionComponentData for additional payment actions.
     *
     * - Parameter data: Action component data to serialize
     * - Returns: Dictionary representation for JavaScript bridge
     * - Throws: AdyenError.serializationFailed if conversion fails
     */
    static func serialize(_ data: ActionComponentData) throws -> [String: Any] {
        do {
            let actionData = try JSONSerialization.jsonObject(
                with: jsonEncoder.encode(data.details),
                options: []
            )
            
            return [
                "details": actionData,
                "timestamp": Date().timeIntervalSince1970,
                "actionType": "additionalDetails"
            ]
            
        } catch {
            throw AdyenError.serializationFailed("Failed to serialize ActionComponentData: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Private Helper Methods
    
    /**
     * Serializes browser information for payment context.
     */
    private static func serializeBrowserInfo(_ browserInfo: BrowserInfo) -> [String: Any] {
        let info: [String: Any] = [
            "userAgent": browserInfo.userAgent ?? ""
        ]
        
        return info
    }
    
    /**
     * Serializes order information for payment tracking.
     */
    private static func serializeOrder(_ order: PartialPaymentOrder) -> [String: Any] {
        var orderInfo: [String: Any] = [
            "orderData": order.orderData ?? [:],
            "pspReference": order.pspReference
        ]
        
        // Add remaining amount if available
        if let remainingAmount = order.remainingAmount {
            orderInfo["remainingAmount"] = serializeAmount(remainingAmount)
        }
        
        return orderInfo
    }
    
    /**
     * Serializes amount information consistently across all payment data.
     */
    private static func serializeAmount(_ amount: Amount) -> [String: Any] {
        return [
            "value": amount.value,
            "currency": amount.currencyCode
        ]
    }
    
    // MARK: - Validation Helpers
    
    /**
     * Validates PaymentComponentData before serialization.
     * Ensures data integrity before expensive serialization operations.
     */
    static func validate(_ data: PaymentComponentData) throws {
        // Validate amount if present
        if let amount = data.amount {
            guard amount.value >= 0 else {
                throw AdyenError.invalidPaymentParameters("Amount value must be greater than or equal to zero")
            }
            
            guard amount.currencyCode.count == 3 else {
                throw AdyenError.invalidPaymentParameters("Currency code must be 3 characters (ISO 4217)")
            }
        }
        
        // Validate browser info if present
        if let browserInfo = data.browserInfo {
            guard browserInfo.userAgent == nil else {
                throw AdyenError.invalidPaymentParameters("Browser user agent cannot be empty")
            }
        }
    }
    
    // MARK: - Error Recovery Helpers
    
    /**
     * Creates a safe serialization of payment data when full serialization fails.
     * Provides fallback data for error reporting.
     */
    static func createSafePaymentSummary(_ data: PaymentComponentData) -> [String: Any] {
        return [
            "hasAmount": data.amount != nil,
            "hasBrowserInfo": data.browserInfo != nil,
            "hasOrder": data.order != nil,
            "storePaymentMethod": data.storePaymentMethod ?? false,
            "timestamp": Date().timeIntervalSince1970,
            "fallbackSerialization": true
        ]
    }
    
    /**
     * Attempts to serialize with fallback to safe summary on failure.
     * **DRY**: Prevents duplicate error handling in calling code.
     */
    static func serializeWithFallback(_ data: PaymentComponentData) -> [String: Any] {
        do {
            try validate(data)
            return try serialize(data)
        } catch {
            CAPLog.print(PluginConstants.identifier, "⚠️ Payment serialization failed, using safe summary: \(error.localizedDescription)")
            return createSafePaymentSummary(data)
        }
    }
}

// MARK: - Extensions for Additional Serialization

extension PaymentDataSerializer {
    
    /**
     * Serializes payment component state for debugging purposes.
     */
    static func serializeComponentState(_ component: PaymentComponent) -> [String: Any] {
        return [
            "paymentMethodType": component.paymentMethod.type.rawValue,
            "componentName": String(describing: type(of: component)),
            "timestamp": Date().timeIntervalSince1970
        ]
    }
    
    /**
     * Creates structured error data for payment failures.
     */
    static func serializePaymentError(_ error: Error, component: PaymentComponent) -> [String: Any] {
        let adyenError = AdyenError.from(error, context: "Payment processing")
        
        var errorData = adyenError.toCapacitorErrorData()
        errorData["componentType"] = component.paymentMethod.type.rawValue
        errorData["componentName"] = String(describing: type(of: component))
        errorData["nativeErrorCode"] = (error as NSError).code
        errorData["nativeErrorDomain"] = (error as NSError).domain
        
        return errorData
    }
}
