protocol PaymentServiceProtocol {
    func processPayment(
        amount: Double,
        encryptedCardNumber: String,
        completion: @escaping @Sendable (Result<Bool, PaymentProcessError>) -> Void
    )
}
