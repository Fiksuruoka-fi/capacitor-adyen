package com.foodello.adyen

import android.app.Activity
import android.util.Log
import com.adyen.checkout.components.core.AnalyticsConfiguration
import com.adyen.checkout.components.core.AnalyticsLevel
import com.adyen.checkout.components.core.CheckoutConfiguration
import com.adyen.checkout.components.core.PaymentMethodTypes
import com.adyen.checkout.components.core.PaymentMethodsApiResponse
import com.adyen.checkout.core.Environment
import com.foodello.adyen.components.AdyenCardComponent
import com.getcapacitor.JSObject
import org.json.JSONObject

class AdyenImplementation(private val plugin: AdyenPlugin, private val activity: Activity) {
    private var checkoutConfiguration: CheckoutConfiguration? = null
    private var paymentMethods: PaymentMethodsApiResponse? = null
    private var activeComponent: AdyenCardComponent? = null

    companion object {
        private const val TAG = "AdyenImplementation"
    }

    /** Initialize the Adyen SDK with the provided configuration */
    fun start(clientKey: String, environment: String, enableAnalytics: Boolean) {
        val adyenEnvironment =
                when (environment.lowercase()) {
                    "test" -> Environment.TEST
                    "liveeu" -> Environment.EUROPE
                    "liveus" -> Environment.UNITED_STATES
                    "liveapse" -> Environment.APSE
                    "liveau" -> Environment.AUSTRALIA
                    else -> Environment.TEST
                }

        val analyticsConfiguration =
                when (enableAnalytics) {
                    true -> AnalyticsConfiguration(AnalyticsLevel.ALL)
                    false -> AnalyticsConfiguration(AnalyticsLevel.NONE)
                }

        checkoutConfiguration =
                CheckoutConfiguration(
                        environment = adyenEnvironment,
                        clientKey = clientKey,
                        analyticsConfiguration = analyticsConfiguration,
                )

        // Initialize card component
        checkoutConfiguration?.let { config ->
            activeComponent = AdyenCardComponent(activity, config, plugin)
        }

        Log.d(TAG, "Adyen SDK initialized successfully with environment: $environment")
    }

    /** Set current payment methods from the server response */
    fun setPaymentMethods(paymentMethodsJson: JSObject) {
        try {
            val jsonString = paymentMethodsJson.toString()
            paymentMethods =
                    PaymentMethodsApiResponse.SERIALIZER.deserialize(JSONObject(jsonString))
            Log.d(TAG, "Payment methods set successfully")
        } catch (e: Exception) {
            Log.e(TAG, "Failed to parse payment methods", e)
            throw e
        }
    }

    /** Present the Card component for payment */
    fun presentCardComponent(
            amount: Int?,
            countryCode: String?,
            currencyCode: String?,
            configuration: JSObject?,
            style: JSObject?,
            viewOptions: JSObject?
    ) {
        activity.runOnUiThread {
            hideComponent()

            val config = checkoutConfiguration
            val methods = paymentMethods

            if (config == null) {
                throw IllegalStateException("Adyen not initialized")
            }

            if (methods == null) {
                throw IllegalStateException("Payment methods not set")
            }

            // Find card payment method
            val cardPaymentMethod =
                    methods.paymentMethods?.find { it.type == PaymentMethodTypes.SCHEME }
                            ?: throw IllegalStateException("Card payment method not found")

            // Always create fresh CardComponent instance to avoid cached configurations
            val cardComp = AdyenCardComponent(activity, config, plugin)

            // Create fresh component with current parameters
            val component =
                    cardComp.create(
                            amount = amount,
                            currencyCode = currencyCode,
                            paymentMethod = cardPaymentMethod,
                            countryCode = countryCode,
                            configuration = configuration
                    )

            cardComp.present(component, style, viewOptions)

            // Update reference to new component
            activeComponent = cardComp

            Log.d(TAG, "Card component created and presented")
        }
    }

    /** Hide the currently presented component */
    fun hideComponent() {
        activity.runOnUiThread {
            activeComponent?.hide()
            Log.d(TAG, "Component hidden")
        }
    }

    fun destroyComponent() {
        activity.runOnUiThread {
            activeComponent?.destroy()
            Log.d(TAG, "Component destroyed")
        }
    }
}
