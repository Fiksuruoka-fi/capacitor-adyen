import Foundation
import UIKit
import Capacitor

@objc public class AdyenBridge: NSObject {
    public weak var plugin: AdyenPlugin?
    private var context: APIContext?
    private var analyticsConfiguration: AnalyticsConfiguration?
    private var paymentMethods: PaymentMethods?
    
    private var activePaymentComponent: PaymentComponent?
    private lazy var componentFactory = ComponentFactory(bridge: self)
    
    // MARK: - Initialization
    public override init() {
        super.init()
    }

    public func start(componentsEnvironment: Environment, clientKey: String, enableAnalytics: Bool) throws {
        guard context == nil else {
            CAPLog.print(PluginConstants.identifier, "Adyen SDK already initialized")
            return
        }

        self.context = try APIContext(environment: componentsEnvironment, clientKey: clientKey)
        self.analyticsConfiguration = AnalyticsConfiguration()
        self.analyticsConfiguration?.isEnabled = enableAnalytics
        
        CAPLog.print(PluginConstants.identifier, "Adyen SDK initialized successfully")
    }
    
    private func serializePaymentData(_ data: PaymentComponentData) throws -> [String: Any] {
        return try PaymentDataSerializer.serialize(data)
    }

    public func setPaymentMethods(_ paymentMethodsJson: Data) throws {
        CAPLog.print(PluginConstants.identifier, "Store current payment methods")
        let paymentMethods = try PaymentDataSerializer.decodePaymentMethods(from: paymentMethodsJson)
        self.paymentMethods = paymentMethods
    }
    
    // MARK: - Component Creation
    
    public func createCardComponent(
        amount: Int?,
        countryCode: String?,
        currencyCode: String?,
        configuration: [String: Any]? = nil,
        style: [String: Any]? = nil
    ) throws -> UIViewController {
        return try componentFactory.createCardComponent(
            amount: amount,
            countryCode: countryCode,
            currencyCode: currencyCode,
            configuration: configuration,
            style: style
        )
    }
    
    internal func setActivePaymentComponent(_ component: PaymentComponent) {
        clearActiveComponents()
        activePaymentComponent = component
        component.delegate = self
    }
    
    private func clearActiveComponents() {
        activePaymentComponent?.stopLoadingIfNeeded()
        activePaymentComponent = nil
    }
    
    // MARK: - Internal accessors for factories
        
    internal var currentContext: APIContext? { context }
    internal var currentAnalyticsConfig: AnalyticsConfiguration? { analyticsConfiguration }
    internal var currentPaymentMethods: PaymentMethods? { paymentMethods }
    internal var currentActivePaymentComponent: PaymentComponent? { activePaymentComponent }
        
    // MARK: - Helper Methods
    
    internal func createAdyenContext(with payment: Payment?) throws -> AdyenContext {
        guard let context = self.context,
              let analyticsConfiguration = self.analyticsConfiguration else {
            throw AdyenError.contextNotInitialized
        }
        
        return AdyenContext(
            apiContext: context,
            payment: payment,
            analyticsConfiguration: analyticsConfiguration
        )
    }
}
