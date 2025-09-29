import Foundation
import UIKit
import Capacitor

internal class ComponentFactory {
    private weak var bridge: AdyenBridge?
    
    init(bridge: AdyenBridge) {
        self.bridge = bridge
    }
    
    func createCardComponent(
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

        // Use context factory for reusable context creation
        let payment = createPaymentIfNeeded(amount: amount, currencyCode: currencyCode, countryCode: countryCode)
        let adyenContext = try AdyenContextFactory.createContext(
            apiContext: bridge.currentContext,
            analyticsConfig: bridge.currentAnalyticsConfig,
            payment: payment
        )
        
        // Use style factory for configuration
        let config = StyleFactory.createCardConfiguration(from: configuration, style: style)

        CAPLog.print(PluginConstants.identifier, "Create card component")
        
        let component = CardComponent(
            paymentMethod: paymentMethod,
            context: adyenContext,
            configuration: config
        )

        // Setup component with bridge delegates
        component.cardComponentDelegate = bridge
        bridge.setActivePaymentComponent(component)
        
        return component.viewController
    }
    
    private func createPaymentIfNeeded(amount: Int?, currencyCode: String?, countryCode: String?) -> Payment? {
        guard let value = amount, let currency = currencyCode, let country = countryCode else { return nil }
        let adyenAmount = Amount(value: value, currencyCode: currency)
        return Payment(amount: adyenAmount, countryCode: country)
    }
}
