import SwiftUI

@available(iOS 15.0, *)
@MainActor
class PaymentFormViewModel: ObservableObject {
    @Published var cardNumber = ""
    @Published var expiryDate = ""
    @Published var cvv = ""
    @Published var isProcessing = false
    @Published var showResult = false
    @Published var success = false
    @Published var config: PaymentUIConfig
    
    let amount: Double
    private let paymentService: PaymentServiceProtocol
    private let validator: PaymentFormValidatingProtocol
    private let cardEncryptor: CardEncryptionProtocol
    var onDismiss: (() -> Void)?
    
    init(amount: Double,
         config: PaymentUIConfig,
         paymentService: PaymentServiceProtocol,
         validator: PaymentFormValidatingProtocol,
         cardEncryptor: CardEncryptionProtocol,
         onDismiss: (() -> Void)? = nil) {
        self.amount = amount
        self.config = config
        self.paymentService = paymentService
        self.validator = validator
        self.cardEncryptor = cardEncryptor
        self.onDismiss = onDismiss
    }
    
    var isFormValid: Bool {
        validator.isValidCardNumber(cardNumber) &&
        validator.isValidExpiryDate(expiryDate) &&
        validator.isValidCVV(cvv)
    }
    
    func formatCardNumber() {
        cardNumber = formatCardNumber(cardNumber)
    }
    
    func updateCardNumber(_ newValue: String) {
        let filtered = newValue.filter { $0.isNumber }
        cardNumber = String(filtered.prefix(16))
        formatCardNumber()
    }
    
    func updateExpiryDate(_ newValue: String) {
        let filtered = newValue.filter { $0.isNumber }
        if filtered.count > 2 {
            expiryDate = filtered.prefix(2) + "/" + filtered.dropFirst(2).prefix(2)
        } else {
            expiryDate = filtered
        }
    }
    
    func updateCVV(_ newValue: String) {
        let filtered = newValue.filter { $0.isNumber }
        cvv = String(filtered.prefix(3))
    }
    
    func formatCardNumber(_ cardNumber: String) -> String {
        return cardNumber
            .replacingOccurrences(of: " ", with: "")
            .enumerated()
            .map { $0.offset % 4 == 0 && $0.offset > 0 ? " \($0.element)" : String($0.element) }
            .joined()
    }
    
    @MainActor
    func pay() {
        isProcessing = true
        let encryptedCardNumber = cardEncryptor.encrypt(cardNumber.replacingOccurrences(of: " ", with: ""))
        paymentService.processPayment(amount: amount, encryptedCardNumber: encryptedCardNumber) { [weak self] result in
            Task { @MainActor in
                guard let self = self else { return }
                switch result {
                case .success(let success):
                    self.success = success
                    self.showResult = true
                case .failure(let error):
                    print(error)
                    self.success = false
                    self.showResult = true
                }
                self.isProcessing = false
            }
        }
    }
} 
