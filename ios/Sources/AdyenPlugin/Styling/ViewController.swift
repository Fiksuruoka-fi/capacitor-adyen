import Foundation
import UIKit
import Capacitor

// MARK: - UIViewController Extension

extension UIViewController {
    
    /**
     * Applies presentation configuration from view options dictionary.
     * Centralized presentation configuration for all components.
     *
     * - Parameter viewOptions: Configuration dictionary containing presentation options
     */
    func applyPresentationConfiguration(from viewOptions: [String: Any]?) {
        // Apply additional iOS-specific configurations
        if let options = viewOptions {
            applyAdditionalViewOptions(options)
        }
    }
    
    /**
     * Applies additional view configuration options.
     */
    private func applyAdditionalViewOptions(_ viewOptions: [String: Any]) {
        // Apply title if specified
        if let title = viewOptions["title"] as? String, !title.isEmpty {
            self.title = title
            self.navigationItem.title = title
            CAPLog.print(PluginConstants.identifier, "Set new title for view: \(title)")
        }
        
        // Configure close button visibility
        if let showsCloseButton = viewOptions["showsCloseButton"] as? Bool {
            configureCloseButton(showsCloseButton, viewOptions: viewOptions)
            CAPLog.print(PluginConstants.identifier, "Configure close button")
        }
        
        // Apply navigation bar title color if specified
        configureNavigationBarAppearance(from: viewOptions)
    }
    
    /**
     * Extracts title color from view options.
     */
    private func extractTitleColor(from viewOptions: [String: Any]) -> UIColor? {
        // Check for iOS-specific title color
        if let iosOptions = viewOptions["ios"] as? [String: Any],
           let titleColorHex = iosOptions["titleColor"] as? String {
            return UIColor(hexString: titleColorHex)
        }
        
        // Check for direct titleColor
        if let titleColorHex = viewOptions["titleColor"] as? String {
            return UIColor(hexString: titleColorHex)
        }
        
        return nil
    }

    /**
     * Extracts title bar background color from view options.
     */
    private func extractTitleBackgroundColor(from viewOptions: [String: Any]) -> UIColor? {
        // Check for iOS-specific title bar background color
        if let iosOptions = viewOptions["ios"] as? [String: Any],
           let colorHex = iosOptions["titleBackgroundColor"] as? String {
            return UIColor(hexString: colorHex)
        }

        // Check for direct titleBarBackgroundColor
        if let colorHex = viewOptions["titleBackgroundColor"] as? String {
            return UIColor(hexString: colorHex)
        }

        return nil
    }

    /**
     * Extracts navigation bar tint color (for buttons/icons).
     */
    private func extractTintColor(from viewOptions: [String: Any]) -> UIColor? {
        // Check for iOS-specific navigation bar tint color
        if let iosOptions = viewOptions["ios"] as? [String: Any],
        let tintColorHex = iosOptions["tintColor"] as? String {
            return UIColor(hexString: tintColorHex)
        }
        
        // Check for direct navigationBarTintColor
        if let tintColorHex = viewOptions["tintColor"] as? String {
            return UIColor(hexString: tintColorHex)
        }
        
        // Fallback to titleColor for consistency (close button matches title)
        return extractTitleColor(from: viewOptions)
    }

    /**
     * Loads Adyen localization bundle.
     * Used for localizing texts from Adyen strings.
     *
     * @see https://adyen.github.io/adyen-ios/5.20.1/documentation/adyen/localization
     */
    private func adyenLocalizationBundle() -> Bundle {
        // Framework bundle where the code lives
        let framework = Bundle(for: CardComponent.self)

        // If Adyen ships a separate resource bundle, load it. Works for SPM/CocoaPods.
        if let bundleURL = framework.url(forResource: "Adyen", withExtension: "bundle"),
           let resources = Bundle(url: bundleURL) {
            return resources
        }

        // Otherwise strings are directly inside the framework bundle
        return framework
    }
    
    /**
     * Extracts navigation bar tint color (for buttons/icons).
     */
    private func extractCloseButtonText(from viewOptions: [String: Any]) -> String? {
        if let closeButtonText = viewOptions["closeButtonText"] as? String {
            return closeButtonText
        }
        
        let localizedText = NSLocalizedString(
            "adyen.cancelButton",
            tableName: "Adyen",
            bundle: .main,
            value: "Close", // Fallback value if key not found
            comment: "Close button's text"
        )

        return localizedText
    }
    
    /**
     * Configures navigation bar title color.
     */
    private func configureNavigationBarAppearance(from viewOptions: [String: Any]) {
        guard let navigationController = self.navigationController else {
            CAPLog.print(PluginConstants.identifier, "Could not configure navigation bar appearance: No navigation controller")
            return
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        
        // Apply title color
        if let titleColor = extractTitleColor(from: viewOptions) {
            appearance.titleTextAttributes = [.foregroundColor: titleColor]
            appearance.largeTitleTextAttributes = [.foregroundColor: titleColor]
            CAPLog.print(PluginConstants.identifier, "Applied title color: \(titleColor)")
        }
        
        // Apply background color
        if let backgroundColor = extractTitleBackgroundColor(from: viewOptions) {
            appearance.backgroundColor = backgroundColor
            CAPLog.print(PluginConstants.identifier, "Applied background color: \(backgroundColor)")
        }

        // Apply tint color to navigation bar (affects ALL navigation items including close button)
        if let tintColor = extractTintColor(from: viewOptions) {
            navigationController.navigationBar.tintColor = tintColor
            CAPLog.print(PluginConstants.identifier, "Applied navigation bar tint color: \(tintColor)")
        }
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        
        // Force update appearance
        navigationController.navigationBar.setNeedsLayout()
    }
    
    /**
     * Configures close button based on configuration.
     */
    private func configureCloseButton(_ shouldShow: Bool, viewOptions: [String: Any]) {
        if shouldShow {
            let closeButtonText = extractCloseButtonText(from: viewOptions)

            let closeButton = UIBarButtonItem(
                title: closeButtonText,
                style: .plain,
                target: self,
                action: #selector(dismissViewController)
            )
            
            navigationItem.leftBarButtonItem = closeButton
        } else {
            navigationItem.leftBarButtonItem = nil
        }
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
}

// MARK: - UINavigationController Extension

extension UINavigationController {
    
    /**
     * Applies presentation configuration specifically for navigation controllers.
     * Delegates styling to the root view controller while handling modal presentation.
     */
    func applyNavigationPresentationConfiguration(from viewOptions: [String: Any]?) {
        // Apply navigation bar and title styling to the root view controller
        if let rootViewController = viewControllers.first {
            rootViewController.applyPresentationConfiguration(from: viewOptions)
        }
    }
}
