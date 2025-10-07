package com.foodello.adyen.components

import android.app.Activity
import android.content.Context
import android.graphics.Typeface
import android.os.SystemClock
import android.util.TypedValue
import android.view.ContextThemeWrapper
import android.view.Gravity
import android.view.ViewGroup
import android.widget.ImageButton
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import androidx.activity.ComponentActivity
import com.adyen.checkout.card.AddressConfiguration
import com.adyen.checkout.card.CardBrand
import com.adyen.checkout.card.CardComponent
import com.adyen.checkout.card.CardComponentState
import com.adyen.checkout.card.KCPAuthVisibility
import com.adyen.checkout.card.SocialSecurityNumberVisibility
import com.adyen.checkout.card.card
import com.adyen.checkout.components.core.ActionComponentData
import com.adyen.checkout.components.core.Amount
import com.adyen.checkout.components.core.CheckoutConfiguration
import com.adyen.checkout.components.core.ComponentCallback
import com.adyen.checkout.components.core.ComponentError
import com.adyen.checkout.components.core.PaymentComponentData
import com.adyen.checkout.components.core.PaymentMethod
import com.adyen.checkout.ui.core.AdyenComponentView
import com.foodello.adyen.AdyenPlugin
import com.foodello.adyen.FormStyleApplier
import com.foodello.adyen.R
import com.foodello.adyen.SheetChromeApplier
import com.foodello.adyen.style.dp
import com.getcapacitor.JSObject
import com.getcapacitor.Logger
import com.google.android.material.bottomsheet.BottomSheetDialog
import java.util.Locale
import kotlin.text.buildString

/**
 * Card component specific functionality encapsulated in a dedicated class. This class handles all
 * card-related operations including creation, configuration, validation, and event handling for
 * Android.
 */
class AdyenCardComponent(
    private val activity: Activity,
    private val checkoutConfiguration: CheckoutConfiguration,
    private val adyenPlugin: AdyenPlugin
) {
    var component: CardComponent? = null
    private var dialog: BottomSheetDialog? = null
    private var paymentMethodName: String? = null

    companion object {
        private const val TAG = "AdyenCardComponent"
    }

    /** Creates a configured Card component ready for presentation. */
    fun create(
        amount: Int?,
        currencyCode: String?,
        paymentMethod: PaymentMethod,
        countryCode: String?,
        configuration: JSObject?,
    ): CardComponent {
        try {
            val cardCallback = createCardCallback()

            val cardConfiguration =
                createCardConfiguration(
                    amount = amount,
                    currencyCode = currencyCode,
                    configuration = configuration,
                    countryCode = countryCode
                )

            val uniqueKey = "card_${SystemClock.uptimeMillis()}"

            val cmp =
                CardComponent.PROVIDER.get(
                    activity = activity as ComponentActivity,
                    paymentMethod = paymentMethod,
                    checkoutConfiguration = cardConfiguration,
                    callback = cardCallback,
                    order = null,
                    key = uniqueKey
                )

            paymentMethodName = paymentMethod.name
            component = cmp

            Logger.debug(TAG, "Card component created: ${cardConfiguration.toDebugString()}")
            return cmp
        } catch (e: Exception) {
            Logger.error(TAG, "Failed to create card component", e)
            throw e
        }
    }

    private fun CheckoutConfiguration.toDebugString(): String = buildString {
        appendLine("Checkout Configuration:")
        appendLine("  Environment: $environment")
        appendLine("  Amount: $amount")
        appendLine("  Shopper locale: $shopperLocale")
        appendLine("  Client key: ${clientKey.take(8)}...")
    }

    /** Creates a callback instance for the card component */
    private fun createCardCallback(): ComponentCallback<CardComponentState> {
        return object : ComponentCallback<CardComponentState> {
            override fun onAdditionalDetails(actionComponentData: ActionComponentData) {
                val actionComponentJson = JSObject.fromJSONObject(ActionComponentData.SERIALIZER.serialize(actionComponentData))
                Logger.debug(TAG, "onAdditionalDetails: $actionComponentData")
                adyenPlugin.onEvent("onAdditionalDetails", actionComponentJson)
            }

            override fun onError(componentError: ComponentError) {
                Logger.error(
                    "$TAG Component error: ${componentError.errorMessage}",
                    componentError.exception
                )

                val ret = JSObject()
                ret.put("message", componentError.errorMessage)
                adyenPlugin.onEvent("onError", ret)
            }

            override fun onSubmit(state: CardComponentState) {
                try {
                    val paymentComponentJson = PaymentComponentData.SERIALIZER.serialize(state.data)
                    Logger.debug(TAG, "onCardSubmit: $paymentComponentJson")

                    val onSubmitData = JSObject.fromJSONObject(paymentComponentJson)

                    val onCardSubmitData = JSObject()
                    onCardSubmitData.put("lastFour", state.lastFourDigits)
                    onCardSubmitData.put("finalBIN", state.binValue)

                    adyenPlugin.onEvent("onCardSubmit", onCardSubmitData)
                    adyenPlugin.onEvent("onSubmit", onSubmitData)
                } catch (e: Exception) {
                    Logger.error("$TAG Failed to serialize payment data: ${e.message}", e)

                    val ret = JSObject()
                    ret.put("message", "Payment serialization failed ${e.message}")
                    adyenPlugin.onEvent("onError", ret)
                }
            }

            override fun onStateChanged(state: CardComponentState) {
                super.onStateChanged(state)

                val ret = JSObject()

                val cardBrands =
                    JSObject().apply {
                        put("cardBrands", state.cardBrand)
                        put("primaryBrand", state.cardBrand)
                    }

                ret.put("cardBrands", cardBrands)
                ret.put("cardBIN", state.binValue)

                Logger.debug(TAG, "onCardChange: $state")
                adyenPlugin.onEvent("onCardChange", ret)
            }
        }
    }

    @Throws(Exception::class)
    fun present(cmp: CardComponent, style: JSObject?, viewOptions: JSObject? = null) {
        try {
            val act = activity as ComponentActivity

            // Create fresh themed context each time to avoid cached button text
            val themed = ContextThemeWrapper(act, R.style.AdyenNeutralTheme)

            val adyenView = AdyenComponentView(themed).apply { attach(cmp, act) }

            // Style the *inner form* after it's attached
            adyenView.post { FormStyleApplier.apply(adyenView, style) }

            dialog = buildBottomSheet(themed, adyenView, style, viewOptions)

            if (dialog == null) throw Exception("Dialog is null")

            dialog!!.show()

            component = cmp
            adyenPlugin.onEvent("onShow", JSObject())
            Logger.debug(TAG, "Card component presented with fresh context")
        } catch (e: Exception) {
            Logger.error(TAG, "Failed to present card component", e)
            adyenPlugin.onEvent(
                "onError",
                JSObject().put("message", "Failed to present card component: ${e.message}")
            )
            throw e
        }
    }

    /** Build the bottom sheet dialog with the provided components */
    private fun buildBottomSheet(
        themedContext: Context,
        adyenView: AdyenComponentView,
        style: JSObject?,
        viewOptions: JSObject?
    ): BottomSheetDialog {
        val header =
            LinearLayout(themedContext).apply {
                orientation = LinearLayout.HORIZONTAL
                gravity = Gravity.CENTER_VERTICAL
                setPaddingRelative(0,0,0,0)
                // DON'T set background here - let SheetChromeApplier handle it
                layoutParams = ViewGroup.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.WRAP_CONTENT
                )
                // Allow corners to show through
                clipToPadding = false
                clipChildren = false
            }

        val titleView =
            TextView(themedContext).apply {
                text = paymentMethodName ?: context.getString(R.string.cardComponentTitle)
                setTextSize(TypedValue.COMPLEX_UNIT_SP, 18f)
                setTypeface(typeface, Typeface.BOLD)
                setPadding(dp(themedContext, 16), dp(themedContext, 12), 0, dp(themedContext, 12))
                layoutParams =
                    LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f)
            }

        val closeBtn =
            ImageButton(themedContext).apply {
                setImageResource(R.drawable.close_24px)
                background = null
                contentDescription = "Close"

                layoutParams = LinearLayout.LayoutParams(
                    dp(themedContext, 44),
                    dp(themedContext, 44)
                )

                // Add padding for better touch target
                setPadding(
                    dp(themedContext, 10),
                    dp(themedContext, 10),
                    dp(themedContext, 10),
                    dp(themedContext, 10)
                )

                scaleType = ImageView.ScaleType.CENTER_INSIDE
            }

        header.addView(titleView)
        header.addView(closeBtn)

        // Content container
        val container =
            LinearLayout(themedContext).apply {
                orientation = LinearLayout.VERTICAL
                setPadding(0,0,0,0)
                addView(header)
                addView(
                    adyenView,
                    LinearLayout.LayoutParams(
                        ViewGroup.LayoutParams.MATCH_PARENT,
                        ViewGroup.LayoutParams.WRAP_CONTENT
                    )
                )
            }

        val bottomSheetDialog =
            BottomSheetDialog(themedContext, R.style.AdyenBottomSheetTheme).apply {
                setContentView(container)
                setOnDismissListener {
                    cleanup()
                    adyenPlugin.onEvent("onHide", JSObject().put("hidden", true))
                }
            }

        closeBtn.setOnClickListener { hide() }

        SheetChromeApplier.apply(
            style = style,
            viewOptions = viewOptions,
            targets =
                SheetChromeApplier.Targets(
                    sheet = container,
                    header = header,
                    headerTitle = titleView,
                    headerClose = closeBtn
                )
        )

        bottomSheetDialog.window?.setDimAmount(0.5f)

        return bottomSheetDialog
    }

    /** Enhanced hide method with proper overlay cleanup */
    fun hide() {
        try {
            dialog?.dismiss()

            cleanup()
        } catch (e: Exception) {
            Logger.error(TAG, "Error hiding component", e)
        }
    }

    /**
     * Destroy whole component, including all resources.
     */
    fun destroy() {
        cleanup(destroy = true)
    }

    /** Creates card configuration from provided options */
    private fun createCardConfiguration(
        amount: Int?,
        currencyCode: String?,
        configuration: JSObject?,
        countryCode: String?
    ): CheckoutConfiguration {
        val adyenEnvironment = checkoutConfiguration.environment
        val clientKey = checkoutConfiguration.clientKey
        val analyticsConfig = checkoutConfiguration.analyticsConfiguration

        val shopperLocale: Locale? =
            configuration
                ?.getJSObject("localizationParameters")
                ?.getString("languageOverride")
                ?.let { lang ->
                    if (!countryCode.isNullOrBlank()) Locale(lang, countryCode)
                    else Locale(lang)
                }

        val amt =
            when {
                currencyCode.isNullOrBlank() || amount == null -> null
                else -> Amount(currencyCode, amount.toLong())
            }

        val isSubmitButtonVisible = configuration?.optBoolean("showsSubmitButton", true)

        val cfg =
            CheckoutConfiguration(
                environment = adyenEnvironment,
                clientKey = clientKey,
                shopperLocale = shopperLocale,
                amount = amt,
                analyticsConfiguration = analyticsConfig,
                isSubmitButtonVisible = isSubmitButtonVisible,
            )

        cfg.card {
            isHolderNameRequired = configuration?.optBoolean("showsHolderNameField") ?: false
            isStorePaymentFieldVisible =
                configuration?.optBoolean("showsStorePaymentMethodField") ?: false
            isHideCvc = configuration?.optBoolean("showsSecurityCodeField", true)?.let { !it } ?: false
            isHideCvcStoredCard = configuration?.optBoolean("showsCvcInStoredCardField", true)?.let { !it } ?: false
            supportedCardBrands =
                configuration?.optJSONArray("allowedCardTypes")?.let { brands ->
                    List(brands.length()) { CardBrand(brands.getString(it)) }
                }
            shopperReference = configuration?.optString("shopperReference")
            kcpAuthVisibility =
                when (configuration?.optString("koreanAuthenticationMode", "auto")) {
                    "show" -> KCPAuthVisibility.SHOW
                    "hide" -> KCPAuthVisibility.HIDE
                    else -> null
                }
            socialSecurityNumberVisibility =
                when (configuration?.optString("socialSecurityNumberMode", "auto")) {
                    "show" -> SocialSecurityNumberVisibility.SHOW
                    "hide" -> SocialSecurityNumberVisibility.HIDE
                    else -> null
                }

            configuration?.optJSONObject("billingAddress")?.let { options ->
                val mode = options.optString("mode", "none").lowercase(Locale.ROOT)
                val requirementPolicy =
                    when (options.optBoolean("requirementPolicy", false)) {
                        true -> AddressConfiguration.CardAddressFieldPolicy.Required()
                        else -> AddressConfiguration.CardAddressFieldPolicy.Optional()
                    }

                val countryCodes: List<String> =
                    options.optJSONArray("countryCodes")?.let { arr ->
                        buildList {
                            for (i in 0 until arr.length()) {
                                arr.optString(i)?.takeIf { it.isNotBlank() }?.let(::add)
                            }
                        }
                            .takeIf { it.isNotEmpty() }
                    }
                        ?: emptyList()

                val defaultCountryCode: String? =
                    options.optString("defaultCountryCode").takeIf { it.isNotBlank() }
                        ?: countryCodes.firstOrNull()

                addressConfiguration =
                    when (mode) {
                        "full" ->
                            countryCodes.let {
                                AddressConfiguration.FullAddress(
                                    defaultCountryCode = defaultCountryCode,
                                    supportedCountryCodes = it,
                                    addressFieldPolicy = requirementPolicy
                                )
                            }
                        "postalcode" ->
                            AddressConfiguration.PostalCode(
                                addressFieldPolicy = requirementPolicy
                            )
                        else -> AddressConfiguration.None
                    }
            }

            shopperLocale?.let { locale -> setShopperLocale(locale) }

            Logger.debug(
                TAG,
                "Fresh card config - Submit button visible: $isSubmitButtonVisible, Amount: $amt"
            )
        }

        return cfg
    }

    /** Clean up component resources */
    fun cleanup(destroy: Boolean = false) {
        if (destroy) {
            component = null
        }

        dialog = null
        paymentMethodName = null

        Logger.debug(TAG, "Card component cleaned up")
    }
}
