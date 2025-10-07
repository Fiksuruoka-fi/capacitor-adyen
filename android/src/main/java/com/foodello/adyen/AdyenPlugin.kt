package com.foodello.adyen

import com.getcapacitor.JSObject
import com.getcapacitor.Logger
import com.getcapacitor.Plugin
import com.getcapacitor.PluginCall
import com.getcapacitor.PluginMethod
import com.getcapacitor.annotation.CapacitorPlugin

@CapacitorPlugin(name = "Adyen")
class AdyenPlugin : Plugin() {

    private lateinit var implementation: AdyenImplementation

    override fun load() {
        super.load()
        implementation = AdyenImplementation(this, bridge.activity)

        // Initialize Adyen SDK with configuration
        val clientKey = config.getString("clientKey")
        val environment = config.getString("environment")
        val enableAnalytics = config.getBoolean("enableAnalytics", false)

        if (clientKey != null && environment != null) {
            try {
                implementation.start(clientKey, environment, enableAnalytics)
            } catch (e: Exception) {
                Logger.error("AdyenPlugin", "Failed to initialize Adyen: ${e.message}", e)
            }
        } else {
            Logger.error(
                    "AdyenPlugin",
                    "Missing required configuration: clientKey or environment",
                    null
            )
        }
    }

    @PluginMethod
    fun setCurrentPaymentMethods(call: PluginCall) {
        val paymentMethodsJson = call.getObject("paymentMethodsJson")

        if (paymentMethodsJson == null) {
            call.reject("Invalid or missing payment methods json")
            return
        }

        try {
            implementation.setPaymentMethods(paymentMethodsJson)
            call.resolve()
        } catch (e: Exception) {
            call.reject("Failed to set payment methods: ${e.message}")
        }
    }

    @PluginMethod
    fun presentCardComponent(call: PluginCall) {
        val amount = call.getInt("amount")
        val countryCode = call.getString("countryCode")
        val currencyCode = call.getString("currencyCode")
        val configuration = call.getObject("configuration")
        val style = call.getObject("style")
        val viewOptions = call.getObject("viewOptions")

        try {
            implementation.presentCardComponent(
                    amount = amount,
                    countryCode = countryCode,
                    currencyCode = currencyCode,
                    configuration = configuration,
                    style = style,
                    viewOptions = viewOptions
            )
            call.resolve()
        } catch (e: Exception) {
            call.reject("Failed to present card component: ${e.message}")
        }
    }

    @PluginMethod
    fun hideComponent(call: PluginCall) {
        try {
            implementation.hideComponent()
            call.resolve()
        } catch (e: Exception) {
            call.reject("Failed to hide component: ${e.message}")
        }
    }

    @PluginMethod
    fun destroyComponent(call: PluginCall) {
        try {
            implementation.destroyComponent()
            call.resolve()
        } catch (e: Exception) {
            call.reject("Failed to destroy component: ${e.message}")
        }
    }

    fun onEvent(eventName: String, data: JSObject) {
        notifyListeners(eventName, data)
    }
}
