import Foundation

public final class PaymentStorage: PaymentStorageProtocol {
    private let key = "stored_payments"
    public init(){}
    
    func save(payment: Payment) throws {
        var current = try getAll()
        current.append(payment)
        guard let data = try? JSONEncoder().encode(current) else {
            throw PaymentStorageError.encodingFailed(error: "Failed to encode data")
        }
        UserDefaults.standard.set(data, forKey: key)
    }
    
    public func getAll() throws -> [Payment] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        
        do {
            return try JSONDecoder().decode([Payment].self, from: data)
        } catch {
            throw PaymentStorageError.decodingFailed(error: "Failed to decode data")
        }
    }
}

