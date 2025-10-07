import Foundation

internal struct CardBrandSerializer {

    static func serialize(brands: [CardBrand]?) -> [String: Any] {
        guard let cardBrands = brands, !cardBrands.isEmpty else {
            return [
                "cardBrands": [],
                "primaryBrand": [:]
            ]
        }

        let serializedBrands = cardBrands.compactMap { brand -> [String: Any]? in
            return [
                "type": brand.type.rawValue,
                "isSupported": brand.isSupported,
                "displayName": getDisplayName(for: brand.type)
            ]
        }

        return [
            "cardBrands": serializedBrands,
            "primaryBrand": serializedBrands.first ?? [:],
            "brandCount": serializedBrands.count
        ]
    }

    private static func getDisplayName(for cardType: Adyen.CardType) -> String {
        switch cardType {
        case .visa: return "Visa"
        case .masterCard: return "Mastercard"
        case .americanExpress: return "American Express"
        case .maestro: return "Maestro"
        case .diners: return "Diners Club"
        case .discover: return "Discover"
        case .jcb: return "JCB"
        case .chinaUnionPay: return "UnionPay"
        case .carteBancaire: return "Carte Bancaire"
        case .bijenkorfCard: return "Bijenkorf Card"
        default: return cardType.rawValue.capitalized
        }
    }
}
