enum PaymentProcessError: Error {
    case invalidAmount(error: String)
    case paymentDeclined(error: String)
}
