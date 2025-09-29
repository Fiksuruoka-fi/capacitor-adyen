import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(AdyenPlugin)
public class AdyenPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = PluginConstants.identifier
    public let jsName = PluginConstants.name
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "setCurrentPaymentMethods", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "presentCardComponent", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "hideComponent", returnType: CAPPluginReturnPromise)
    ]
    private var implementation: AdyenBridge?
    private var componentViewController: UIViewController?
    
    override public func load() {
        super.load()

        guard let environmentString = getConfig().getString("environment") else {
            CAPLog.print(identifier, "❌ Missing environment configuration")
            return
        }
        
        guard let environment = AdyenEnvironment.from(string: environmentString) else {
            CAPLog.print(identifier, "❌ Invalid environment: \(environmentString)")
            return
        }
        
        guard let clientKey = getConfig().getString("clientKey") else {
            CAPLog.print(identifier, "❌ Missing clientKey configuration")
            return
        }
        
        let enableAnalytics = getConfig().getBoolean("enableAnalytics", true)
        
        
        do {
            let implementation = AdyenBridge()
            implementation.plugin = self
            
            try implementation.start(
                componentsEnvironment: environment.adyenEnvironment,
                clientKey: clientKey,
                enableAnalytics: enableAnalytics
            )
            
            self.implementation = implementation
        } catch {
            CAPLog.print(identifier, "❌ Failed to initialize Adyen: \(error.localizedDescription)")
            self.implementation = nil
        }
    }
    
    /**
     * Set current payment methods for Adyen SDK
     */
    @objc public func setCurrentPaymentMethods(_ call: CAPPluginCall) {
        // Ensure the bridge has been initialized.
        guard let implementation = self.implementation else {
            call.reject("Adyen not initialized")
            return
        }
        
        // Ensure valid data has been passed
        guard let paymentMethodsObject = call.getObject("paymentMethodsJson") else {
            call.reject("Invalid or missing payment methods json")
            return
        }
        
        CAPLog.print(self.identifier, "Payment methods: \(paymentMethodsObject.description)")
        
        do {
            let paymentMethodsData = try JSONSerialization.data(
                withJSONObject: paymentMethodsObject,
                options: []
            )
            try implementation.setPaymentMethods(paymentMethodsData)
            call.resolve()
        } catch {
            call.reject(error.localizedDescription)
        }
    }
    
    @objc public func presentCardComponent(_ call: CAPPluginCall) {
        let configuration = call.getObject("configuration")
        let style = call.getObject("style")
        
        let extras: [String: Any] = [
            "configuration": configuration as Any,
            "style": style as Any
        ]

        presentComponent(call: call, componentType: "card", extras: extras)
    }
    
    @objc public func hideComponent(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            self.componentViewController?.dismiss(animated: true)
        }
    }
    
    /**
     * Presents the specified Adyen component.
     *
     * - Parameters:
     *   - call: The CAPPluginCall containing parameters for the component.
     *   - componentType: The type of component to present (e.g., "card", "dropIn", "ideal").
     *   - extras: Additional configuration options for the component.
     */
    private func presentComponent(
        call: CAPPluginCall,
        componentType: String,
        extras: [String: Any]? = nil
    ) {
        guard let implementation = self.implementation else {
            call.reject("Adyen not initialized")
            return
        }
        
        let amount = call.getInt("amount")
        let countryCode = call.getString("countryCode")
        let currencyCode = call.getString("currencyCode")
        let viewOptions = call.getObject("viewOptions")
        
        CAPLog.print(self.identifier, "Amount: \(String(describing: amount)), Country code: \(String(describing: countryCode)), Currency code: \(String(describing: currencyCode))")
        
        DispatchQueue.main.async { [weak self] in
            do {
                self?.componentViewController = try {
                    switch componentType {
                    case "card":
                        return try implementation.createCardComponent(
                            amount: amount,
                            countryCode: countryCode,
                            currencyCode: currencyCode,
                            configuration: extras?["configuration"] as? [String: Any],
                            style: extras?["style"] as? [String: Any]
                        )
                    default:
                        call.reject("Unsupported component type: \(componentType)")
                        return nil
                    }
                }()
            
                guard let strongSelf = self,
                    let componentVC = strongSelf.componentViewController,
                    let presentingVC = strongSelf.bridge?.viewController else {
                    call.reject("Failed to present \(componentType) component: view controller unavailable")
                    return
                }
                
                let nav = UINavigationController(rootViewController: componentVC)
                nav.navigationBar.prefersLargeTitles = false
                
                nav.applyNavigationPresentationConfiguration(from: viewOptions)
                
                presentingVC.present(nav, animated: true) {
                    call.resolve()
                }
            } catch {
                call.reject("Failed to present \(componentType) component: \(error.localizedDescription)")
            }
        }
    }
}
