import Foundation
import Capacitor

extension AdyenBridge: CardComponentDelegate {
    public func didChangeBIN(_ value: String, component: CardComponent) {
        guard let plugin = plugin else {
            CAPLog.print(PluginConstants.identifier, "Plugin reference is nil")
            return
        }
        
        CAPLog.print(PluginConstants.identifier, "Card BIN changed \(value)")
        plugin.notifyListeners("onCardChange", data: ["cardBIN": value])
    }
    
    public func didChangeCardBrand(_ value: [CardBrand]?, component: CardComponent) {
        guard let plugin = plugin else {
            CAPLog.print(PluginConstants.identifier, "Plugin reference is nil")
            return
        }
        
        let eventData = CardBrandSerializer.serialize(brands: value)
        plugin.notifyListeners("onCardChange", data: eventData)
    }
    
    public func didSubmit(lastFour: String, finalBIN: String, component: CardComponent) {
        guard let plugin = plugin else {
            CAPLog.print(PluginConstants.identifier, "Plugin reference is nil")
            return
        }
        
        CAPLog.print(PluginConstants.identifier, "Card form submitted")
        let eventData = [
            "lastFour": lastFour,
            "finalBIN": finalBIN
        ]
        
        plugin.notifyListeners("onCardSubmit", data: eventData)
    }
}
