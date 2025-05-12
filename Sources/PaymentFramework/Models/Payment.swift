import Foundation

public struct Payment: Identifiable, Codable {
    public var id = UUID()
    public let amount: Double
    public let date: Date
    public let status: PaymentStatus
}

public enum PaymentStatus: String, Codable {
    case success, failure
}
