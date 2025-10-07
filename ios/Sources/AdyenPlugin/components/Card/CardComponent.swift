import Foundation
import UIKit
import Capacitor

/**
 * Card component specific functionality encapsulated in a dedicated class.
 * This class handles all card-related operations including creation, configuration,
 * validation, and event handling.
 */
internal class AdyenCardComponent {
    private weak var bridge: AdyenBridge?

    init(bridge: AdyenBridge) {
        self.bridge = bridge
    }

    /**
     * Creates a configured Card component ready for presentation.
     *
     * - Parameters:
     *   - amount: Payment amount in minor units
     *   - countryCode: ISO country code
     *   - currencyCode: ISO currency code
     *   - configuration: Card component configuration options
     *   - style: Styling configuration for the component
     * - Returns: A configured UIViewController ready for presentation
     * - Throws: AdyenError if creation fails
     */
    func create(
        amount: Int?,
        countryCode: String?,
        currencyCode: String?,
        configuration: [String: Any]? = nil,
        style: [String: Any]? = nil
    ) throws -> UIViewController {

        guard let bridge = bridge,
              let paymentMethods = bridge.currentPaymentMethods,
              let paymentMethod = paymentMethods.paymentMethod(ofType: CardPaymentMethod.self) else {
            throw AdyenError.paymentMethodNotFound
        }

        // Create payment if needed
        let payment = createPaymentIfNeeded(amount: amount, currencyCode: currencyCode, countryCode: countryCode)

        // Create Adyen context
        let adyenContext = try AdyenContextFactory.createContext(
            apiContext: bridge.currentContext,
            analyticsConfig: bridge.currentAnalyticsConfig,
            payment: payment
        )

        // Create component configuration
        var componentConfig = CardComponent.Configuration()

        // Apply configuration properties
        componentConfig = createCardConfigurations(componentConfig, from: configuration)

        // Apply custom styling if provided
        if let styleDict = style, !styleDict.isEmpty {
            componentConfig.style = StyleBuilder.build(from: styleDict)
        }

        let component = CardComponent(
            paymentMethod: paymentMethod,
            context: adyenContext,
            configuration: componentConfig
        )

        // Setup component with bridge delegates
        component.cardComponentDelegate = bridge
        bridge.setActivePaymentComponent(component)

        return component.viewController
    }

    /**
     * Creates payment object if all required parameters are provided.
     */
    private func createPaymentIfNeeded(amount: Int?, currencyCode: String?, countryCode: String?) -> Payment? {
        guard let value = amount, let currency = currencyCode, let country = countryCode else { return nil }
        let adyenAmount = Amount(value: value, currencyCode: currency)
        return Payment(amount: adyenAmount, countryCode: country)
    }

    /**
     * Applies Adyen NavigationStyle instead of manual UIKit styling.
     */
    static func configureNavigationBarAppearance(from viewOptions: [String: Any]) -> NavigationStyle? {
        guard !viewOptions.isEmpty else { return nil }

        let navigationStyle = StyleBuilder.createNavigationStyle(from: viewOptions)

        CAPLog.print(PluginConstants.identifier, "Created Adyen NavigationStyle with custom appearance")
        return navigationStyle
    }

    // MARK: - Configuration Application Helpers

    /**
     * Applies card-specific configuration properties.
     * Modular configuration application with validation.
     */
    private func createCardConfigurations(_ baseConfig: CardComponent.Configuration, from dict: [String: Any]?) -> CardComponent.Configuration {
        var cfg = baseConfig
        cfg.showsHolderNameField = dict?["showsHolderNameField"] as? Bool ?? false
        cfg.showsSecurityCodeField = dict?["showsSecurityCodeField"] as? Bool ?? true
        cfg.showsStorePaymentMethodField = dict?["showsStorePaymentMethodField"] as? Bool ?? false

        // Card type restrictions
        if let allowedCardTypes = dict?["allowedCardTypes"] as? [String] {
            cfg.allowedCardTypes = allowedCardTypes.compactMap { CardType(rawValue: $0) }
        }

        // Localization configuration
        if let localizationParameters = dict?["localizationParameters"] as? [String: String] {
            if let languageOverride = localizationParameters["languageOverride"] {
                let countryCode = dict?["countryCode"] as? String
                let localeString = countryCode.map { "\(languageOverride)_\($0)" } ?? languageOverride

                cfg.localizationParameters = LocalizationParameters(
                    enforcedLocale: localeString,
                    bundle: Bundle.main,
                    tableName: localizationParameters["tableName"],
                    keySeparator: localizationParameters["keySeparator"]
                )
            } else {
                cfg.localizationParameters = LocalizationParameters(
                    bundle: Bundle.main,
                    tableName: localizationParameters["tableName"],
                    keySeparator: localizationParameters["keySeparator"]
                )
            }
        }

        cfg.koreanAuthenticationMode = switch dict?["koreanAuthenticationMode"] as? String {
        case "show": .show
        case "hide": .hide
        default: .auto
        }

        cfg.socialSecurityNumberMode = switch dict?["socialSecurityNumberMode"] as? String {
        case "show": .show
        case "hide": .hide
        default: .auto
        }

        if let billingAddress = dict?["billingAddress"] as? [String: Any] {
            let mode = billingAddress["mode"] as? String ?? "none"

            cfg.billingAddress.mode = switch mode {
            case "full": .full
            case "postalCode": .postalCode
            default: .none
            }

            if let countryCodes = billingAddress["supportedCountryCodes"] as? [String] {
                cfg.billingAddress.countryCodes = countryCodes
            }

            if billingAddress["requirementPolicy"] is Bool {
                cfg.billingAddress.requirementPolicy = .required
            }
        }

        return cfg
    }

    /**
     * Retrieves the current active card component if available.
     */
    var activeComponent: CardComponent? {
        return bridge?.currentActivePaymentComponent as? CardComponent
    }

    /**
     * Checks if a card component is currently active.
     */
    var isActive: Bool {
        return activeComponent != nil
    }

    /**
     * Safely stops the current card component if active.
     */
    func stopIfActive() {
        if let cardComponent = activeComponent {
            cardComponent.stopLoadingIfNeeded()
            CAPLog.print(PluginConstants.identifier, "Stopped active card component")
        }
    }

    /**
     * Creates a summary of current card component state for debugging.
     */
    func createStateSummary() -> [String: Any] {
        var summary: [String: Any] = [
            "hasActiveComponent": isActive,
            "timestamp": Date().timeIntervalSince1970
        ]

        if let cardComponent = activeComponent {
            summary["componentState"] = [
                "paymentMethodType": cardComponent.paymentMethod.type.rawValue,
                "componentName": String(describing: type(of: cardComponent))
            ]
        }

        return summary
    }

    /**
     * Handles card component cleanup when dismissing or switching components.
     */
    func cleanup() {
        if let cardComponent = activeComponent {
            cardComponent.stopLoadingIfNeeded()
            CAPLog.print(PluginConstants.identifier, "Cleaned up card component: \(type(of: cardComponent))")
        }
    }
}
