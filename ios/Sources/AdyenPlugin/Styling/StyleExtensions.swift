import Foundation
import UIKit

/**
 * Builder for creating FormComponentStyle instances from dictionary configurations.
 * Centralized style creation with validation and fallback mechanisms.
 */
internal struct StyleBuilder {
    
    // MARK: - Main Builder Method
    
    /**
     * Creates a complete FormComponentStyle from a dictionary configuration.
     * Handles all form component styling in one centralized location.
     */
    static func build(from styleDict: [String: Any]) -> FormComponentStyle {
        var style = FormComponentStyle()

        // Global form styling
        if let backgroundColorString = styleDict["backgroundColor"] as? String {
            style.backgroundColor = UIColor(hexString: backgroundColorString)
        }

        if let tintColorString = styleDict["tintColor"] as? String {
            style.tintColor = UIColor(hexString: tintColorString)
        }

        if let separatorColorString = styleDict["separatorColor"] as? String {
            style.separatorColor = UIColor(hexString: separatorColorString)
        }

        // Component-specific styling
        if let headerDict = styleDict["header"] as? [String: Any] {
            style.sectionHeader = createTextStyle(from: headerDict)
        }

        if let textFieldDict = styleDict["textField"] as? [String: Any] {
            style.textField = createTextFieldStyle(from: textFieldDict)
        }

        if let switchDict = (styleDict["switch"] as? [String: Any]) ?? (styleDict["toggle"] as? [String: Any]) {
            style.toggle = createToggleStyle(from: switchDict)
        }

        if let hintDict = styleDict["hint"] as? [String: Any] {
            style.hintLabel = createTextStyle(from: hintDict)
        }

        if let footnoteDict = styleDict["footnote"] as? [String: Any] {
            style.footnoteLabel = createTextStyle(from: footnoteDict)
        }

        if let linkTextDict = styleDict["linkText"] as? [String: Any] {
            style.linkTextLabel = createTextStyle(from: linkTextDict)
        }

        if let buttonDict = (styleDict["button"] as? [String: Any]) ?? (styleDict["mainButton"] as? [String: Any]) {
            style.mainButtonItem = createButtonItemStyle(from: buttonDict)
        }

        if let secondaryDict = styleDict["secondaryButton"] as? [String: Any] {
            style.secondaryButtonItem = createButtonItemStyle(from: secondaryDict)
        }

        return style
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
            let barTitle = StyleBuilder.createTextStyle(from: barTitleOptions)
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
            listStyle.sectionHeader = ListSectionHeaderStyle(title: StyleBuilder.createTextStyle(from: sectionHeaderDict))
        }
        
        return listStyle
    }
    
    /**
     * Creates individual list item style.
     */
    private static func createListItemStyle(from dict: [String: Any]) -> ListItemStyle {
        var itemStyle = ListItemStyle()
        
        if let titleDict = dict["title"] as? [String: Any] {
            itemStyle.title = StyleBuilder.createTextStyle(from: titleDict)
        }
        
        if let subtitleDict = dict["subtitle"] as? [String: Any] {
            itemStyle.subtitle = StyleBuilder.createTextStyle(from: subtitleDict)
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
    
    // MARK: - Text Field Style Creation
    
    /**
     * Creates FormTextItemStyle with comprehensive configuration support.
     * Handles nested styling configurations and legacy flat key support.
     */
    static func createTextFieldStyle(from dict: [String: Any]) -> FormTextItemStyle {
        var textFieldStyle = FormTextItemStyle()

        // Title styling - supports both nested dict and legacy direct keys
        if let titleDict = dict["title"] as? [String: Any] {
            textFieldStyle.title = createTextStyle(from: titleDict)
        }
        if let titleColorString = dict["titleColor"] as? String {
            textFieldStyle.title.color = UIColor(hexString: titleColorString)
        }
        if let titleFontDict = dict["titleFont"] as? [String: Any],
           let size = titleFontDict["size"] as? CGFloat,
           let weightString = titleFontDict["weight"] as? String {
            textFieldStyle.title.font = FontBuilder.createFont(size: size, weight: weightString)
        }

        // User input text styling
        if let textDict = dict["text"] as? [String: Any] {
            textFieldStyle.text = createTextStyle(from: textDict)
        }
        if let textColorString = dict["textColor"] as? String {
            textFieldStyle.text.color = UIColor(hexString: textColorString)
        }
        if let textFontDict = dict["textFont"] as? [String: Any],
           let size = textFontDict["size"] as? CGFloat,
           let weightString = textFontDict["weight"] as? String {
            textFieldStyle.text.font = FontBuilder.createFont(size: size, weight: weightString)
        }

        // Placeholder styling
        if let placeholderDict = dict["placeholder"] as? [String: Any] {
            textFieldStyle.placeholderText = createTextStyle(from: placeholderDict)
        }
        if let placeholderColorString = dict["placeholderColor"] as? String {
            textFieldStyle.placeholderText?.color = UIColor(hexString: placeholderColorString)
        }
        if let placeholderFontDict = dict["placeholderFont"] as? [String: Any],
           let size = placeholderFontDict["size"] as? CGFloat,
           let weightString = placeholderFontDict["weight"] as? String {
            textFieldStyle.placeholderText?.font = FontBuilder.createFont(size: size, weight: weightString)
        }

        // Icon styling
        if let iconDict = dict["icon"] as? [String: Any] {
            textFieldStyle.icon = ImageStyleBuilder.create(from: iconDict)
        }

        // Container styling
        if let tintColorString = dict["tintColor"] as? String {
            textFieldStyle.tintColor = UIColor(hexString: tintColorString)
        }
        if let separatorColorString = dict["separatorColor"] as? String {
            textFieldStyle.separatorColor = UIColor(hexString: separatorColorString)
        }
        if let backgroundColorString = dict["backgroundColor"] as? String {
            textFieldStyle.backgroundColor = UIColor(hexString: backgroundColorString)
        }
        if let errorColorString = dict["errorColor"] as? String {
            textFieldStyle.errorColor = UIColor(hexString: errorColorString)
        }

        return textFieldStyle
    }

    // MARK: - Toggle Style Creation
    
    /**
     * Creates FormToggleItemStyle for switches and checkboxes.
     */
    static func createToggleStyle(from dict: [String: Any]) -> FormToggleItemStyle {
        var toggleStyle = FormToggleItemStyle()

        // Title styling
        if let titleColorString = dict["titleColor"] as? String {
            toggleStyle.title.color = UIColor(hexString: titleColorString)
        }
        if let titleFontDict = dict["titleFont"] as? [String: Any],
           let size = titleFontDict["size"] as? CGFloat,
           let weightString = titleFontDict["weight"] as? String {
            toggleStyle.title.font = FontBuilder.createFont(size: size, weight: weightString)
        }

        // Toggle control styling
        if let tintColorString = dict["tintColor"] as? String {
            toggleStyle.tintColor = UIColor(hexString: tintColorString)
        }

        // Container styling
        if let separatorColorString = dict["separatorColor"] as? String {
            toggleStyle.separatorColor = UIColor(hexString: separatorColorString)
        }

        if let backgroundColorString = dict["backgroundColor"] as? String {
            toggleStyle.backgroundColor = UIColor(hexString: backgroundColorString)
        }

        return toggleStyle
    }

    // MARK: - Text Style Creation
    
    /**
     * Creates generic TextStyle from dictionary configuration.
     * Reusable text styling for labels, headers, and other text elements.
     */
    static func createTextStyle(from dict: [String: Any]) -> TextStyle {
        var textStyle = TextStyle(
            font: UIFont.preferredFont(forTextStyle: .body),
            color: UIColor.label
        )

        if let colorString = dict["color"] as? String {
            textStyle.color = UIColor(hexString: colorString)
        }

        if let fontDict = dict["font"] as? [String: Any],
           let size = fontDict["size"] as? CGFloat,
           let weightString = fontDict["weight"] as? String {
            textStyle.font = FontBuilder.createFont(size: size, weight: weightString)
        }

        if let bgColorString = dict["backgroundColor"] as? String {
            textStyle.backgroundColor = UIColor(hexString: bgColorString)
        }

        if let alignmentString = dict["textAlignment"] as? String {
            textStyle.textAlignment = TextAlignmentBuilder.create(from: alignmentString)
        }

        return textStyle
    }

    // MARK: - Button Style Creation
    
    /**
     * Creates FormButtonItemStyle with font, color, and corner radius support.
     */
    static func createButtonItemStyle(from dict: [String: Any]) -> FormButtonItemStyle {
        var font = UIFont.preferredFont(forTextStyle: .headline)
        if let fontDict = dict["font"] as? [String: Any],
           let size = fontDict["size"] as? CGFloat,
           let weightString = fontDict["weight"] as? String {
            font = FontBuilder.createFont(size: size, weight: weightString)
        }

        var textColor: UIColor = .white
        if let textColorString = dict["textColor"] as? String {
            textColor = UIColor(hexString: textColorString)
        }

        var mainColor: UIColor = .systemBlue
        if let bgColorString = dict["backgroundColor"] as? String {
            mainColor = UIColor(hexString: bgColorString)
        }

        if let cornerRadius = dict["cornerRadius"] as? CGFloat {
            return FormButtonItemStyle.main(
                font: font,
                textColor: textColor,
                mainColor: mainColor,
                cornerRadius: cornerRadius
            )
        } else {
            return FormButtonItemStyle.main(
                font: font,
                textColor: textColor,
                mainColor: mainColor
            )
        }
    }
}

// MARK: - Helper Builders

/**
 * Specialized font builder for consistent font creation.
 */
internal struct FontBuilder {
    
    static func createFont(size: CGFloat, weight: String) -> UIFont {
        let fontWeight: UIFont.Weight
        
        switch weight.lowercased() {
        case "thin": fontWeight = .thin
        case "light": fontWeight = .light
        case "regular": fontWeight = .regular
        case "medium": fontWeight = .medium
        case "semibold": fontWeight = .semibold
        case "bold": fontWeight = .bold
        case "heavy": fontWeight = .heavy
        case "black": fontWeight = .black
        default: fontWeight = .regular
        }
        
        return UIFont.systemFont(ofSize: size, weight: fontWeight)
    }
    
    /**
     * Creates font from nested dictionary configuration.
     */
    static func createFont(from dict: [String: Any]) -> UIFont? {
        guard let size = dict["size"] as? CGFloat,
              let weightString = dict["weight"] as? String else {
            return nil
        }
        
        return createFont(size: size, weight: weightString)
    }
}

/**
 * Text alignment builder for consistent alignment handling.
 */
internal struct TextAlignmentBuilder {
    
    static func create(from alignment: String) -> NSTextAlignment {
        switch alignment.lowercased() {
        case "left": return .left
        case "center": return .center
        case "right": return .right
        case "justified": return .justified
        case "natural": return .natural
        default: return .left
        }
    }
}

/**
 * Image style builder for icons and graphics.
 */
internal struct ImageStyleBuilder {
    
    static func create(from dict: [String: Any]) -> ImageStyle {
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
        
        if let contentModeString = dict["contentMode"] as? String {
            imageStyle.contentMode = ContentModeBuilder.create(from: contentModeString)
        }
        
        return imageStyle
    }
}

/**
 * Content mode builder for image rendering options.
 */
internal struct ContentModeBuilder {
    
    static func create(from mode: String) -> UIView.ContentMode {
        switch mode.lowercased() {
        case "scaletofill": return .scaleToFill
        case "scaleaspectfit": return .scaleAspectFit
        case "scaleaspectfill": return .scaleAspectFill
        case "redraw": return .redraw
        case "center": return .center
        case "top": return .top
        case "bottom": return .bottom
        case "left": return .left
        case "right": return .right
        case "topleft": return .topLeft
        case "topright": return .topRight
        case "bottomleft": return .bottomLeft
        case "bottomright": return .bottomRight
        default: return .scaleAspectFit
        }
    }
}

/**
 * Corner rounding builder for consistent rounding handling.
 */
internal struct CornerRoundingBuilder {
    
    static func create(from rounding: String) -> CornerRounding {
        switch rounding.lowercased() {
        case "none":
            return .none
        case "percentage":
            return .percent(0.5) // 50% rounding for circular corners
        default:
            // Parse as fixed value if it's a number string
            if let value = Double(rounding) {
                return .fixed(CGFloat(value))
            }
            return .fixed(8) // Default fallback
        }
    }
    
    static func create(from value: CGFloat) -> CornerRounding {
        return .fixed(value)
    }
}
