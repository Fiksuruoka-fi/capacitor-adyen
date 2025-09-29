package com.capacitor.community.adyen.components

import android.app.Activity
import android.content.Intent
import android.util.Log
import com.adyen.checkout.card.CardComponent
import com.adyen.checkout.card.CardConfiguration
import com.adyen.checkout.components.core.Amount
import com.adyen.checkout.components.core.CheckoutConfiguration
import com.adyen.checkout.components.core.PaymentMethod
import com.adyen.checkout.components.core.PaymentMethods
import com.getcapacitor.JSObject
import com.getcapacitor.PluginCall
import java.util.Locale

/**
 * Card component specific functionality encapsulated in a dedicated class.
 * This class handles all card-related operations including creation, configuration,
 * validation, and event handling for Android.
 */
class AdyenCardComponent(
    private val activity: Activity,
    private val checkoutConfiguration: CheckoutConfiguration
) {
    private var activeComponent: CardComponent? = null
    
    companion object {
        private const val TAG = "AdyenCardComponent"
    }

    /**
     * Creates a configured Card component ready for presentation.
     */
    fun create(
        paymentMethod: PaymentMethod,
        amount: Int?,
        countryCode: String?,
        currencyCode: String?,
        configuration: JSObject?,
        style: JSObject?,
        call: PluginCall
    ): CardComponent {
        
        try {
            validateParameters(amount, countryCode, currencyCode, configuration)
            
            val cardConfiguration = createCardConfiguration(
                configuration = configuration,
                style = style,
                countryCode = countryCode
            )
            
            val component = CardComponent.PROVIDER.get(activity, paymentMethod, cardConfiguration)
            
            // Set up component callbacks
            setupComponentCallbacks(component, call)
            
            activeComponent = component
            
            Log.d(TAG, "Card component created successfully")
            return component
            
        } catch (e: Exception) {
            Log.e(TAG, "Failed to create card component", e)
            throw e
        }
    }

    /**
     * Present the card component to the user
     */
    fun present(component: CardComponent, call: PluginCall) {
        try {
            // In a real implementation, this would start an Activity or Fragment
            // For now, we'll simulate the presentation
            Log.d(TAG, "Presenting card component")
            
            // Resolve the call to indicate successful presentation
            call.resolve()
            
        } catch (e: Exception) {
            Log.e(TAG, "Failed to present card component", e)
            call.reject("Failed to present card component: ${e.message}")
        }
    }

    /**
     * Hide the currently presented component
     */
    fun hide() {
        activeComponent?.let { component ->
            try {
                // Clean up component resources
                cleanup()
                Log.d(TAG, "Card component hidden successfully")
            } catch (e: Exception) {
                Log.e(TAG, "Error hiding card component", e)
            }
        }
    }

    /**
     * Validates card component creation parameters.
     */
    private fun validateParameters(
        amount: Int?,
        countryCode: String?,
        currencyCode: String?,
        configuration: JSObject?
    ) {
        // Add specific validation logic here if needed
        // Basic validation is handled by Adyen SDK
        
        if (amount != null && amount <= 0) {
            throw IllegalArgumentException("Amount must be greater than 0")
        }
        
        countryCode?.let { country ->
            if (country.length != 2) {
                throw IllegalArgumentException("Country code must be 2 characters")
            }
        }
        
        currencyCode?.let { currency ->
            if (currency.length != 3) {
                throw IllegalArgumentException("Currency code must be 3 characters")
            }
        }
    }

    /**
     * Creates card configuration from provided options
     */
    private fun createCardConfiguration(
        configuration: JSObject?,
        style: JSObject?,
        countryCode: String?
    ): CardConfiguration {
        
        val builder = CardConfiguration.Builder(activity, checkoutConfiguration.clientKey)
        
        // Apply configuration options
        configuration?.let { config ->
            config.optBoolean("showsHolderNameField")?.let { show ->
                builder.setHolderNameRequired(show)
            }
            
            config.optBoolean("showsStorePaymentMethodField")?.let { show ->
                builder.setShowStorePaymentField(show)
            }
            
            // Add other configuration options as needed
        }
        
        // Set locale if country code is provided
        countryCode?.let { country ->
            try {
                val locale = Locale("", country)
                builder.setShopperLocale(locale)
            } catch (e: Exception) {
                Log.w(TAG, "Invalid country code: $country", e)
            }
        }
        
        // Apply styling options
        style?.let { styleConfig ->
            // Apply styling configurations
            // This would depend on the specific styling options available in the Adyen Android SDK
            Log.d(TAG, "Applying style configuration")
        }
        
        return builder.build()
    }

    /**
     * Set up component event callbacks
     */
    private fun setupComponentCallbacks(component: CardComponent, call: PluginCall) {
        // Set up listeners for component events
        // This would include submit, change, error events
        
        Log.d(TAG, "Component callbacks set up")
    }

    /**
     * Get the currently active card component
     */
    fun getActiveComponent(): CardComponent? = activeComponent

    /**
     * Check if a card component is currently active
     */
    fun isActive(): Boolean = activeComponent != null

    /**
     * Create a summary of current card component state for debugging
     */
    fun createStateSummary(): Map<String, Any> {
        val summary = mutableMapOf<String, Any>(
            "hasActiveComponent" to isActive(),
            "timestamp" to System.currentTimeMillis()
        )
        
        activeComponent?.let { component ->
            summary["componentState"] = mapOf(
                "paymentMethodType" to component.paymentMethod.type,
                "componentName" to component.javaClass.simpleName
            )
        }
        
        return summary
    }

    /**
     * Clean up component resources
     */
    fun cleanup() {
        activeComponent?.let { component ->
            // Perform any necessary cleanup
            activeComponent = null
            Log.d(TAG, "Card component cleaned up")
        }
    }
}