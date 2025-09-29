import UIKit
import Adyen

public enum AdyenEnvironment: Int, CaseIterable {
    case test
    case liveApse
    case liveUs
    case liveEu
    case liveAu
    
    public var adyenEnvironment: Environment {
        switch self {
        case .test:
            return .test
        case .liveApse:
            return .liveApse
        case .liveUs:
            return .liveUnitedStates
        case .liveEu:
            return .liveEurope
        case .liveAu:
            return .liveAustralia
        }
    }
    
    public var stringValue: String {
        switch self {
        case .test:
            return "test"
        case .liveApse:
            return "liveApse"
        case .liveUs:
            return "liveUs"
        case .liveEu:
            return "liveEu"
        case .liveAu:
            return "liveAu"
        }
    }
    
    public static func from(string: String) -> AdyenEnvironment? {
        switch string {
        case "test":
            return .test
        case "liveApse":
            return .liveApse
        case "liveUs":
            return .liveUs
        case "liveEu":
            return .liveEu
        case "liveAu":
            return .liveAu
        default:
            return nil
        }
    }
}
