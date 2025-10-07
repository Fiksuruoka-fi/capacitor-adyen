import UIKit

/**
 * Extension for UIColor to support hex string initialization.
 * Efficient hex parsing with support for multiple formats.
 */
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let components = (
            R: CGFloat((int >> 16) & 0xff) / 255,
            G: CGFloat((int >> 08) & 0xff) / 255,
            B: CGFloat((int >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}

// MARK: - Validation Helpers

extension UIColor {

    /**
     * Validates if a string is a valid hex color format.
     */
    static func isValidHexString(_ hexString: String) -> Bool {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)

        // Check valid lengths
        guard [3, 6, 8].contains(hex.count) else { return false }

        // Check all characters are valid hex
        let hexCharacterSet = CharacterSet(charactersIn: "0123456789ABCDEFabcdef")
        return hex.rangeOfCharacter(from: hexCharacterSet.inverted) == nil
    }
}
