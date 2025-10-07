import Foundation
import Capacitor

/**
 * Centralized error handling for the Adyen Bridge plugin.
 * Provides consistent error messaging and categorization across all components.
 */
enum AdyenError: Error, LocalizedError {
    case sdkInitializationFailed(String)
    case paymentMethodNotFound
    case contextNotInitialized
    case invalidPaymentMethods(String)
    case serializationFailed(String)
    case invalidPaymentParameters(String)
    case componentCreationFailed(String)
    case invalidConfiguration(String)
    case missingRequiredData(String)
    case networkError(String)
    case authenticationFailed(String)

    var errorDescription: String? {
        switch self {
        case .sdkInitializationFailed(let details):
            return "Failed to initialize Adyen SDK: \(details)"
        case .paymentMethodNotFound:
            return "Required payment method not found in available payment methods"
        case .contextNotInitialized:
            return "Adyen context not properly initialized. Call start() first"
        case .invalidPaymentMethods(let details):
            return "Invalid payment methods data: \(details)"
        case .serializationFailed(let details):
            return "Failed to serialize payment data: \(details)"
        case .invalidPaymentParameters(let details):
            return "Invalid payment parameters: \(details)"
        case .componentCreationFailed(let details):
            return "Failed to create payment component: \(details)"
        case .invalidConfiguration(let details):
            return "Invalid component configuration: \(details)"
        case .missingRequiredData(let details):
            return "Missing required data: \(details)"
        case .networkError(let details):
            return "Network error occurred: \(details)"
        case .authenticationFailed(let details):
            return "Authentication failed: \(details)"
        }
    }

    var errorCode: Int {
        switch self {
        case .sdkInitializationFailed:
            return 1001
        case .paymentMethodNotFound:
            return 1002
        case .contextNotInitialized:
            return 1003
        case .invalidPaymentMethods:
            return 1004
        case .serializationFailed:
            return 1005
        case .invalidPaymentParameters:
            return 1006
        case .componentCreationFailed:
            return 1007
        case .invalidConfiguration:
            return 1008
        case .missingRequiredData:
            return 1009
        case .networkError:
            return 1010
        case .authenticationFailed:
            return 1011
        }
    }

    var errorDomain: String {
        return "com.adyen.capacitor.plugin"
    }

    /**
     * Convert to NSError for Capacitor compatibility
     */
    var nsError: NSError {
        return NSError(
            domain: errorDomain,
            code: errorCode,
            userInfo: [
                NSLocalizedDescriptionKey: errorDescription ?? "Unknown error",
                NSLocalizedFailureReasonErrorKey: self.failureReason
            ]
        )
    }

    private var failureReason: String {
        switch self {
        case .sdkInitializationFailed:
            return "SDK initialization process failed"
        case .paymentMethodNotFound:
            return "Payment method lookup failed"
        case .contextNotInitialized:
            return "Context creation prerequisites not met"
        case .invalidPaymentMethods:
            return "Payment methods JSON parsing failed"
        case .serializationFailed:
            return "Data serialization process failed"
        case .invalidPaymentParameters:
            return "Payment parameter validation failed"
        case .componentCreationFailed:
            return "Component instantiation failed"
        case .invalidConfiguration:
            return "Configuration validation failed"
        case .missingRequiredData:
            return "Required data validation failed"
        case .networkError:
            return "Network communication failed"
        case .authenticationFailed:
            return "Authentication process failed"
        }
    }
}

/**
 * Error handling utilities for consistent error reporting
 */
extension AdyenError {

    /**
     * Create AdyenError from system Error with context
     */
    static func from(_ error: Error, context: String) -> AdyenError {
        if let adyenError = error as? AdyenError {
            return adyenError
        }

        // Map common system errors to appropriate AdyenError cases
        if error is DecodingError {
            return .serializationFailed("\(context): \(error.localizedDescription)")
        }

        if (error as NSError).domain == NSURLErrorDomain {
            return .networkError("\(context): \(error.localizedDescription)")
        }

        // Default to generic error with context
        return .componentCreationFailed("\(context): \(error.localizedDescription)")
    }

    /**
     * Create structured error data for JavaScript bridge
     */
    func toCapacitorErrorData() -> [String: Any] {
        return [
            "error": errorDescription ?? "Unknown error",
            "errorCode": errorCode,
            "errorDomain": errorDomain,
            "failureReason": failureReason,
            "timestamp": Date().timeIntervalSince1970
        ]
    }
}

/**
 * Validation helpers that throw appropriate AdyenError cases
 */
struct AdyenValidator {

    /**
     * Validate payment parameters before component creation
     */
    static func validatePaymentParameters(
        amount: Int?,
        currencyCode: String?,
        countryCode: String?
    ) throws {

        if let amount = amount {
            guard amount > 0 else {
                throw AdyenError.invalidPaymentParameters("Amount must be greater than zero")
            }
        }

        if let currencyCode = currencyCode {
            guard currencyCode.count == 3 else {
                throw AdyenError.invalidPaymentParameters("Currency code must be 3 characters (ISO 4217)")
            }
        }

        if let countryCode = countryCode {
            guard countryCode.count == 2 else {
                throw AdyenError.invalidPaymentParameters("Country code must be 2 characters (ISO 3166)")
            }
        }
    }

    /**
     * Validate required SDK initialization state
     */
    static func validateSDKState(
        context: APIContext?,
        analyticsConfig: AnalyticsConfiguration?,
        paymentMethods: PaymentMethods?
    ) throws {

        guard context != nil else {
            throw AdyenError.contextNotInitialized
        }

        guard analyticsConfig != nil else {
            throw AdyenError.contextNotInitialized
        }

        guard paymentMethods != nil else {
            throw AdyenError.missingRequiredData("Payment methods must be set before creating components")
        }
    }
}

/**
 * Error logging utilities with consistent formatting
 */
extension AdyenError {

    /**
     * Log error with consistent format for debugging
     */
    func logError(context: String = "", file: String = #file, function: String = #function, line: Int = #line) {
        let fileName = (file as NSString).lastPathComponent
        let errorMessage = """
        [AdyenError] \(context)
        Error: \(errorDescription ?? "Unknown")
        Code: \(errorCode)
        Location: \(fileName):\(line) in \(function)
        """

        CAPLog.print(
            PluginConstants.identifier,
            errorMessage
        )
    }
}
