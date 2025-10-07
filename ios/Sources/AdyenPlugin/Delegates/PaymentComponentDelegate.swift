import Foundation
import Capacitor

/**
 * PaymentComponentDelegate implementation for AdyenBridge.
 * Handles payment submission and error events from all payment components.
 */
extension AdyenBridge: PaymentComponentDelegate {

    /**
     * Called when a payment component submits payment data.
     * Serializes the payment data and forwards it to the JavaScript bridge.
     *
     * - Parameters:
     *   - data: The payment component data containing payment method, browser info, etc.
     *   - component: The payment component that submitted the data
     */
    public func didSubmit(_ data: PaymentComponentData, from component: PaymentComponent) {
        guard let plugin = plugin else {
            CAPLog.print(PluginConstants.identifier, "Plugin reference is nil")
            return
        }

        do {
            let jsonData = try PaymentDataSerializer.serialize(data)
            let eventData = jsonData

            CAPLog.print(PluginConstants.identifier, "Payment data submitted")

            plugin.notifyListeners("onSubmit", data: eventData)

        } catch {
            let adyenError = AdyenError.from(error, context: "Payment data serialization")
            adyenError.logError(context: "Failed to serialize payment data)")

            plugin.notifyListeners("onError", data: adyenError.toCapacitorErrorData().merging([
                "source": "paymentComponentDelegate"
            ]) { _, new in new })
        }
    }

    /**
     * Called when a payment component fails with an error.
     * Forwards the error information to the JavaScript bridge.
     *
     * - Parameters:
     *   - error: The error that occurred during payment processing
     *   - component: The payment component where the error occurred
     */
    public func didFail(with error: Error, from component: PaymentComponent) {
        guard let plugin = plugin else {
            CAPLog.print(PluginConstants.identifier, "Plugin reference is nil")
            return
        }

        let adyenError = AdyenError.from(error, context: "Payment component failure")

        adyenError.logError(context: "Payment failed")

        let errorData = adyenError.toCapacitorErrorData().merging([
            "source": "paymentComponentDelegate",
            "nativeErrorCode": (error as NSError).code,
            "nativeErrorDomain": (error as NSError).domain
        ]) { _, new in new }

        plugin.notifyListeners("onError", data: errorData)
    }
}
