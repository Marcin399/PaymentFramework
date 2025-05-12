protocol PaymentFormValidatingProtocol {
    func isValidCardNumber(_ cardNumber: String) -> Bool
    func isValidExpiryDate(_ expiryDate: String) -> Bool
    func isValidCVV(_ cvv: String) -> Bool
    func isValidForm(cardNumber: String, expiryDate: String, cvv: String) -> Bool
}
