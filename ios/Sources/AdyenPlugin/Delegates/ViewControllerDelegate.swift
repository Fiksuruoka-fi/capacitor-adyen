import Foundation
import UIKit
import Capacitor

extension AdyenPlugin: UIAdaptivePresentationControllerDelegate {
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        CAPLog.print(PluginConstants.identifier, "onHide")
        notifyListeners("onHide", data: ["reason": "user_gesture"])

        // Clean up component reference
        componentViewController = nil
    }

    public func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        return true
    }
}

// MARK: - Presentation Helper
extension AdyenPlugin {

    /// Present component with automatic dismissal tracking
    internal func presentWithTracking(
        _ viewController: UIViewController,
        viewOptions: [String: Any]? = nil,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            // Create navigation controller with styling
            let nav = UINavigationController(rootViewController: viewController)
            nav.navigationBar.prefersLargeTitles = false

            // Apply view options styling
            nav.applyNavigationPresentationConfiguration(from: viewOptions)

            // Set up dismissal delegate
            nav.presentationController?.delegate = self

            // Store reference for cleanup
            self.componentViewController = nav

            // Present with show event
            self.bridge?.viewController?.present(nav, animated: animated) {
                CAPLog.print(PluginConstants.identifier, "onShow")
                self.notifyListeners("onShow", data: [:])
                completion?()
            }
        }
    }

    /// Hide component programmatically with event
    internal func hideWithTracking(animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.componentViewController?.dismiss(animated: animated) {
                self.notifyListeners("onHide", data: [
                    "reason": "programmatic"
                ])
                self.componentViewController = nil
            }
        }
    }
}
