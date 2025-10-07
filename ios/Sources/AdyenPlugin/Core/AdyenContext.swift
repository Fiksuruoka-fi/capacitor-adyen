import Foundation

/**
 * Extensions and factory methods for creating AdyenContext instances.
 * Provides reusable context creation with proper error handling.
 */
extension AdyenContext {

    /**
     * Factory method to create an AdyenContext with standardized configuration.
     *
     * - Parameters:
     *   - apiContext: The API context containing environment and client key
     *   - payment: Optional payment information for analytics and amount tracking
     *   - analyticsConfiguration: Analytics configuration for tracking
     *
     * - Returns: Configured AdyenContext ready for component creation
     * - Throws: AdyenError if context creation fails
     */
    static func create(
        apiContext: APIContext,
        payment: Payment? = nil,
        analyticsConfiguration: AnalyticsConfiguration? = nil
    ) throws -> AdyenContext {

        guard let analytics = analyticsConfiguration else {
            throw AdyenError.contextNotInitialized
        }

        return AdyenContext(
            apiContext: apiContext,
            payment: payment,
            analyticsConfiguration: analytics
        )
    }

    /**
     * Creates an AdyenContext with payment details from individual components.
     * Convenience method when you have separate amount/currency/country values.
     *
     * - Parameters:
     *   - apiContext: The API context
     *   - amount: Payment amount in minor units (e.g., cents)
     *   - currencyCode: ISO currency code (e.g., "EUR", "USD")
     *   - countryCode: ISO country code (e.g., "NL", "US")
     *   - analyticsConfiguration: Analytics configuration
     *
     * - Returns: AdyenContext with payment information
     * - Throws: AdyenError if context or payment creation fails
     */
    static func createWithPayment(
        apiContext: APIContext,
        amount: Int,
        currencyCode: String,
        countryCode: String,
        analyticsConfiguration: AnalyticsConfiguration
    ) throws -> AdyenContext {

        let adyenAmount = Amount(value: amount, currencyCode: currencyCode)
        let payment = Payment(amount: adyenAmount, countryCode: countryCode)

        return AdyenContext(
            apiContext: apiContext,
            payment: payment,
            analyticsConfiguration: analyticsConfiguration
        )
    }
}

/**
 * Factory class for centralized AdyenContext creation.
 * Follows the factory pattern used throughout the codebase.
 */
internal struct AdyenContextFactory {

    /**
     * Creates an AdyenContext using the bridge's current configuration.
     * This is the primary method used by ComponentFactory.
     *
     * - Parameters:
     *   - apiContext: Current API context from the bridge
     *   - analyticsConfig: Current analytics configuration from the bridge
     *   - payment: Optional payment for the context
     *
     * - Returns: Configured AdyenContext
     * - Throws: AdyenError.contextNotInitialized if required components are missing
     */
    static func createContext(
        apiContext: APIContext?,
        analyticsConfig: AnalyticsConfiguration?,
        payment: Payment? = nil
    ) throws -> AdyenContext {

        guard let apiContext = apiContext,
              let analyticsConfig = analyticsConfig else {
            throw AdyenError.contextNotInitialized
        }

        return try AdyenContext.create(
            apiContext: apiContext,
            payment: payment,
            analyticsConfiguration: analyticsConfig
        )
    }

    /**
     * Creates a context with payment information when all components are available.
     * Used when creating components that need amount/currency context.
     */
    static func createContextWithPayment(
        apiContext: APIContext?,
        analyticsConfig: AnalyticsConfiguration?,
        amount: Int,
        currencyCode: String,
        countryCode: String
    ) throws -> AdyenContext {

        guard let apiContext = apiContext,
              let analyticsConfig = analyticsConfig else {
            throw AdyenError.contextNotInitialized
        }

        return try AdyenContext.createWithPayment(
            apiContext: apiContext,
            amount: amount,
            currencyCode: currencyCode,
            countryCode: countryCode,
            analyticsConfiguration: analyticsConfig
        )
    }
}

/**
 * Validation helpers for context creation parameters.
 */
internal struct AdyenContextValidator {

    /**
     * Validates that payment parameters are valid before context creation.
     *
     * - Parameters:
     *   - amount: Payment amount (should be positive)
     *   - currencyCode: Currency code (should be valid ISO code)
     *   - countryCode: Country code (should be valid ISO code)
     *
     * - Throws: AdyenError.invalidPaymentParameters if validation fails
     */
    static func validatePaymentParameters(
        amount: Int,
        currencyCode: String,
        countryCode: String
    ) throws {

        guard amount > 0 else {
            throw AdyenError.invalidPaymentParameters("Amount must be greater than zero")
        }

        guard currencyCode.count == 3 else {
            throw AdyenError.invalidPaymentParameters("Currency code must be 3 characters (ISO 4217)")
        }

        guard countryCode.count == 2 else {
            throw AdyenError.invalidPaymentParameters("Country code must be 2 characters (ISO 3166)")
        }
    }
}
