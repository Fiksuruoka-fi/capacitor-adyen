import Foundation
import UIKit
import Capacitor
import Adyen

/**
 * Centralized factory for creating Adyen component styles and configurations.
 * **Performance**: Provides reusable style creation methods with validation.
 */
internal struct StyleFactory {
    
    // MARK: - Configuration Creation
    
    /**
     * Creates a CardComponent.Configuration from dictionary parameters.
     * Handles both configuration and styling in one method.
     */
    static func createCardConfiguration(
        from configDict: [String: Any]? = nil,
        style styleDict: [String: Any]? = nil
    ) -> CardComponent.Configuration {
        
        var config = CardComponent.Configuration()
        
        // Apply configuration properties
        if let configDict = configDict, !configDict.isEmpty {
            applyCardConfiguration(&config, from: configDict)
        }
        
        // Apply custom styling if provided
        if let styleDict = styleDict, !styleDict.isEmpty {
            let formStyle = FormComponentStyleBuilder.build(from: styleDict)

            config.style = formStyle
        }
        
        return config
    }
    
    /**
     * Applies Adyen NavigationStyle instead of manual UIKit styling.
     */
    static func configureNavigationBarAppearance(from viewOptions: [String: Any]) -> NavigationStyle? {
        guard !viewOptions.isEmpty else { return nil }
        
        let navigationStyle = createNavigationStyle(from: viewOptions)
        
        CAPLog.print(PluginConstants.identifier, "Created Adyen NavigationStyle with custom appearance")
        return navigationStyle
    }
    
    // MARK: - Configuration Application Helpers
    
    /**
     * Applies card-specific configuration properties.
     * Modular configuration application with validation.
     */
    private static func applyCardConfiguration(_ config: inout CardComponent.Configuration, from dict: [String: Any]) {
        config.showsHolderNameField = dict["showsHolderNameField"] as? Bool ?? false
        config.showsSecurityCodeField = dict["showsSecurityCodeField"] as? Bool ?? true
        config.showsStorePaymentMethodField = dict["showsStorePaymentMethodField"] as? Bool ?? true
        
        // Card type restrictions
        if let allowedCardTypes = dict["allowedCardTypes"] as? [String] {
            config.allowedCardTypes = allowedCardTypes.compactMap { CardType(rawValue: $0) }
        }
        
        // Localization configuration
        if let localizationParameters = dict["localizationParameters"] as? [String: String] {
            config.localizationParameters = LocalizationParameters(
                bundle: Bundle.main,
                tableName: localizationParameters["tableName"],
                keySeparator: localizationParameters["keySeparator"]
            )
        }
        
        // Validation configuration
        if let koreanAuthenticationMode = dict["koreanAuthenticationMode"] as? String {
            // Handle Korean authentication if needed
            CAPLog.print(PluginConstants.identifier, "Korean authentication mode: \(koreanAuthenticationMode)")
        }
        
        // Social security number configuration (for certain markets)
        if let socialSecurityNumberMode = dict["socialSecurityNumberMode"] as? String {
            // Handle SSN mode if needed
            CAPLog.print(PluginConstants.identifier, "SSN mode: \(socialSecurityNumberMode)")
        }
    }
    
    // MARK: - Style Creation Methods
    
    /**
     * Creates a complete FormComponentStyle from dictionary.
     * Centralized form styling with comprehensive options.
     */
    static func createFormComponentStyle(from styleDict: [String: Any]) -> FormComponentStyle {
        return FormComponentStyleBuilder.build(from: styleDict)
    }
    
    /**
     * Creates navigation style from view options using Adyen's official NavigationStyle.
     */
    static func createNavigationStyle(from dict: [String: Any]) -> NavigationStyle {
        var navigationStyle = NavigationStyle()
        
        if let backgroundColorString = dict["backgroundColor"] as? String {
            navigationStyle.backgroundColor = UIColor(hexString: backgroundColorString)
        }

        if let barTitleOptions = dict["barTitle"] as? [String: Any] {
            let barTitle = FormComponentStyleBuilder.createTextStyle(from: barTitleOptions)
            navigationStyle.barTitle = barTitle
        }
        
        if let tintColorString = dict["tintColor"] as? String {
            navigationStyle.tintColor = UIColor(hexString: tintColorString)
        }
        
        if let toolbarMode = dict["toolbarMode"] as? String {
            switch toolbarMode {
            case "leftCancel":
                navigationStyle.toolbarMode = .leftCancel
            case "natural":
                navigationStyle.toolbarMode = .natural
            case "rightCancel":
                navigationStyle.toolbarMode = .rightCancel
            default:
                navigationStyle.toolbarMode = .natural
            }
        }
        
        return navigationStyle
    }
    
    /**
     * Creates list component style for payment method selection.
     */
    private static func createListComponentStyle(from dict: [String: Any]) -> ListComponentStyle {
        var listStyle = ListComponentStyle()
        
        if let backgroundColorString = dict["backgroundColor"] as? String {
            listStyle.backgroundColor = UIColor(hexString: backgroundColorString)
        }
        
        // List item styling
        if let listItemDict = dict["listItem"] as? [String: Any] {
            listStyle.listItem = createListItemStyle(from: listItemDict)
        }
        
        // Section header styling
        if let sectionHeaderDict = dict["sectionHeader"] as? [String: Any] {
            listStyle.sectionHeader = ListSectionHeaderStyle(title: FormComponentStyleBuilder.createTextStyle(from: sectionHeaderDict))
        }
        
        return listStyle
    }
    
    /**
     * Creates individual list item style.
     */
    private static func createListItemStyle(from dict: [String: Any]) -> ListItemStyle {
        var itemStyle = ListItemStyle()
        
        if let titleDict = dict["title"] as? [String: Any] {
            itemStyle.title = FormComponentStyleBuilder.createTextStyle(from: titleDict)
        }
        
        if let subtitleDict = dict["subtitle"] as? [String: Any] {
            itemStyle.subtitle = FormComponentStyleBuilder.createTextStyle(from: subtitleDict)
        }
        
        if let backgroundColorString = dict["backgroundColor"] as? String {
            itemStyle.backgroundColor = UIColor(hexString: backgroundColorString)
        }
        
        if let imageDict = dict["image"] as? [String: Any] {
            itemStyle.image = createImageStyle(from: imageDict)
        }
        
        return itemStyle
    }
    
    /**
     * Creates image style for payment method icons.
     */
    private static func createImageStyle(from dict: [String: Any]) -> ImageStyle {
        var imageStyle = ImageStyle(
            borderColor: nil,
            borderWidth: 0,
            cornerRounding: .fixed(8),
            clipsToBounds: true,
            contentMode: .scaleAspectFit
        )
        
        if let tintColorString = dict["tintColor"] as? String {
            imageStyle.tintColor = UIColor(hexString: tintColorString)
        }
        
        if let backgroundColorString = dict["backgroundColor"] as? String {
            imageStyle.backgroundColor = UIColor(hexString: backgroundColorString)
        }
        
        if let borderColorString = dict["borderColor"] as? String {
            imageStyle.borderColor = UIColor(hexString: borderColorString)
        }
        
        if let borderWidth = dict["borderWidth"] as? CGFloat {
            imageStyle.borderWidth = borderWidth
        }
        
        if let cornerRounding = dict["cornerRounding"] as? CGFloat {
            imageStyle.cornerRounding = .fixed(cornerRounding)
        } else if let cornerRoundingString = dict["cornerRounding"] as? String {
            imageStyle.cornerRounding = CornerRoundingBuilder.create(from: cornerRoundingString)
        }
        
        return imageStyle
    }
    
    // MARK: - Validation Helpers
    
    /**
     * Validates configuration dictionary before applying.
     * Early validation prevents runtime configuration errors.
     */
    static func validateConfiguration(_ config: [String: Any], for componentType: String) throws {
        // Validate localization parameters
        if let localizationParams = config["localizationParameters"] as? [String: String] {
            if let tableName = localizationParams["tableName"], tableName.isEmpty {
                throw AdyenError.invalidConfiguration("Localization table name cannot be empty for \(componentType)")
            }
        }
        
        // Validate style dictionary structure
        if let style = config["style"] as? [String: Any] {
            try validateStyleConfiguration(style, for: componentType)
        }
    }
    
    /**
     * Validates style configuration structure.
     */
    private static func validateStyleConfiguration(_ style: [String: Any], for componentType: String) throws {
        // Validate color strings are valid hex values
        let colorKeys = ["backgroundColor", "tintColor", "separatorColor"]
        
        for key in colorKeys {
            if let colorString = style[key] as? String {
                guard UIColor(hexString: colorString) != nil else {
                    throw AdyenError.invalidConfiguration("Invalid color value '\(colorString)' for key '\(key)' in \(componentType)")
                }
            }
        }
        
        // Validate font configurations
        if let textField = style["textField"] as? [String: Any] {
            try validateFontConfiguration(textField, context: "\(componentType).textField")
        }
        
        if let button = style["button"] as? [String: Any] {
            try validateFontConfiguration(button, context: "\(componentType).button")
        }
    }
    
    /**
     * Validates font configuration structure.
     */
    private static func validateFontConfiguration(_ config: [String: Any], context: String) throws {
        if let fontDict = config["font"] as? [String: Any] {
            guard let size = fontDict["size"] as? CGFloat, size > 0 else {
                throw AdyenError.invalidConfiguration("Font size must be positive number in \(context)")
            }
            
            if let weight = fontDict["weight"] as? String {
                let validWeights = ["thin", "light", "regular", "medium", "semibold", "bold", "heavy", "black"]
                guard validWeights.contains(weight.lowercased()) else {
                    throw AdyenError.invalidConfiguration("Invalid font weight '\(weight)' in \(context). Valid weights: \(validWeights.joined(separator: ", "))")
                }
            }
        }
    }
}

// MARK: - Factory Extensions

extension StyleFactory {
    
    /**
     * Creates configuration with validation.
     * Combines validation and creation for safer usage.
     */
    static func createValidatedCardConfiguration(
        from configDict: [String: Any]? = nil,
        style styleDict: [String: Any]? = nil
    ) throws -> CardComponent.Configuration {
        
        if let config = configDict {
            try validateConfiguration(config, for: "CardComponent")
        }
        
        if let style = styleDict {
            try validateStyleConfiguration(style, for: "CardComponent")
        }
        
        return createCardConfiguration(from: configDict, style: styleDict)
    }
    
    /**
     * Creates theme-aware configurations using predefined themes.
     */
    static func createThemedConfiguration(
        theme: String,
        overrides: [String: Any]? = nil
    ) -> CardComponent.Configuration {
        
        var baseStyle: [String: Any] = [:]
        
        // Apply theme-based defaults
        switch theme.lowercased() {
        case "dark":
            baseStyle = createDarkThemeStyle()
        case "light":
            baseStyle = createLightThemeStyle()
        case "brand":
            baseStyle = createBrandThemeStyle()
        default:
            baseStyle = createLightThemeStyle()
        }
        
        // Apply any overrides
        if let overrides = overrides {
            baseStyle = baseStyle.merging(overrides) { _, new in new }
        }
        
        return createCardConfiguration(style: baseStyle)
    }
    
    // MARK: - Theme Presets
    
    private static func createDarkThemeStyle() -> [String: Any] {
        return [
            "backgroundColor": "#1C1C1E",
            "tintColor": "#007AFF",
            "separatorColor": "#3A3A3C",
            "textField": [
                "textColor": "#FFFFFF",
                "backgroundColor": "#2C2C2E",
                "titleColor": "#8E8E93"
            ],
            "button": [
                "backgroundColor": "#007AFF",
                "textColor": "#FFFFFF"
            ]
        ]
    }
    
    private static func createLightThemeStyle() -> [String: Any] {
        return [
            "backgroundColor": "#FFFFFF",
            "tintColor": "#007AFF",
            "separatorColor": "#C6C6C8",
            "textField": [
                "textColor": "#000000",
                "backgroundColor": "#FFFFFF",
                "titleColor": "#6D6D70"
            ],
            "button": [
                "backgroundColor": "#007AFF",
                "textColor": "#FFFFFF"
            ]
        ]
    }
    
    private static func createBrandThemeStyle() -> [String: Any] {
        // Customize with your brand colors
        return [
            "backgroundColor": "#FFFFFF",
            "tintColor": "#FF6B35", // Brand primary color
            "separatorColor": "#E5E5E7",
            "textField": [
                "textColor": "#1D1D1F",
                "backgroundColor": "#FFFFFF",
                "titleColor": "#86868B"
            ],
            "button": [
                "backgroundColor": "#FF6B35",
                "textColor": "#FFFFFF",
                "cornerRadius": 12
            ]
        ]
    }
}
