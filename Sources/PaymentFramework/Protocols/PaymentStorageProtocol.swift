protocol PaymentStorageProtocol: Sendable {
    func save(payment: Payment) throws
    func getAll() throws -> [Payment]
}
