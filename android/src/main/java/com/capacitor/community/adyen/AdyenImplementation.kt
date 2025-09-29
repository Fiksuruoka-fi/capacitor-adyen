package com.capacitor.community.adyen

import android.app.Activity
import android.util.Log
import com.adyen.checkout.components.core.CheckoutConfiguration
import com.adyen.checkout.components.core.PaymentMethods
import com.adyen.checkout.core.Environment
import com.capacitor.community.adyen.components.AdyenCardComponent
import com.getcapacitor.JSObject
import com.getcapacitor.Plugin
import com.getcapacitor.PluginCall
import org.json.JSONObject

class AdyenImplementation(
    private val plugin: Plugin,
    private val activity: Activity
) {
    private var checkoutConfiguration: CheckoutConfiguration? = null
    private var paymentMethods: PaymentMethods? = null
    private var cardComponent: AdyenCardComponent? = null
    
    companion object {
        private const val TAG = "AdyenImplementation"
    }

    /**
     * Initialize the Adyen SDK with the provided configuration
     */
    fun start(clientKey: String, environment: String, enableAnalytics: Boolean) {
        val adyenEnvironment = when (environment.lowercase()) {
            "test" -> Environment.TEST
            "liveeurope", "liveeu" -> Environment.EUROPE
            "liveunitedstates", "liveus" -> Environment.UNITED_STATES
            "liveaustralia", "liveaus", "liveapac" -> Environment.APSE
            else -> Environment.TEST
        }
        
        checkoutConfiguration = CheckoutConfiguration.Builder(adyenEnvironment, clientKey)
            .build()
            
        // Initialize card component
        checkoutConfiguration?.let { config ->
            cardComponent = AdyenCardComponent(activity, config)
        }
            
        Log.d(TAG, "Adyen SDK initialized successfully with environment: $environment")
    }

    /**
     * Set current payment methods from the server response
     */
    fun setPaymentMethods(paymentMethodsJson: JSObject) {
        try {
            val jsonString = paymentMethodsJson.toString()
            paymentMethods = PaymentMethods.SERIALIZER.deserialize(JSONObject(jsonString))
            Log.d(TAG, "Payment methods set successfully")
        } catch (e: Exception) {
            Log.e(TAG, "Failed to parse payment methods", e)
            throw e
        }
    }

    /**
     * Present the Card component for payment
     */
    fun presentCardComponent(
        amount: Int?,
        countryCode: String?,
        currencyCode: String?,
        configuration: JSObject?,
        style: JSObject?,
        viewOptions: JSObject?,
        call: PluginCall
    ) {
        val config = checkoutConfiguration
        val methods = paymentMethods
        val cardComp = cardComponent
        
        if (config == null) {
            throw IllegalStateException("Adyen not initialized")
        }
        
        if (methods == null) {
            throw IllegalStateException("Payment methods not set")
        }
        
        if (cardComp == null) {
            throw IllegalStateException("Card component not initialized")
        }
        
        // Find card payment method
        val cardPaymentMethod = methods.paymentMethods?.find { 
            it.type == "scheme" || it.type == "card"
        } ?: throw IllegalStateException("Card payment method not found")
        
        // Create and present card component
        val component = cardComp.create(
            paymentMethod = cardPaymentMethod,
            amount = amount,
            countryCode = countryCode,
            currencyCode = currencyCode,
            configuration = configuration,
            style = style,
            call = call
        )
        
        cardComp.present(component, call)
        
        Log.d(TAG, "Card component created and presented")
    }

    /**
     * Hide the currently presented component
     */
    fun hideComponent() {
        cardComponent?.hide()
        Log.d(TAG, "Component hidden")
    }

    /**
     * Get the currently active card component
     */
    fun getActiveCardComponent(): AdyenCardComponent? = cardComponent

    /**
     * Check if a card component is currently active
     */
    fun isCardComponentActive(): Boolean = cardComponent?.isActive() == true
}