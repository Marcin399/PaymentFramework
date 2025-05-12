import Foundation

@available(iOS 15.0, *)
final class PaymentService: PaymentServiceProtocol, Sendable {
    private let storage: PaymentStorageProtocol

    init(storage: PaymentStorageProtocol = PaymentStorage()) {
        self.storage = storage
    }

    func processPayment(
        amount: Double,
        encryptedCardNumber: String,
        completion: @escaping @Sendable (Result<Bool, PaymentProcessError>) -> Void
    ) {
        if amount == 0 {
            completion(
                .failure(.invalidAmount(error: "Amount cannot be zero."))
            )
            return
        } else if amount < 0 {
            completion(
                .failure(.invalidAmount(error: "Amount cannot be negative."))
            )
            return
        }

        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 2) {
            let paymentResult: PaymentStatus = Bool.random() ? .success : .failure
            let payment = Payment(amount: amount, date: Date(), status: paymentResult)

            do {
                try self.storage.save(payment: payment)
            } catch {
                print("Error saving payment: \(error)")
            }

            switch paymentResult {
            case .success:
                completion(.success(true))
            case .failure:
                completion(.failure(.paymentDeclined(error: "Payment failed.")))
            }
        }
    }
}
