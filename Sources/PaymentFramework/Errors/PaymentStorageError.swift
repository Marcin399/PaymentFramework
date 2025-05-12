enum PaymentStorageError: Error {
    case encodingFailed(error: String)
    case decodingFailed(error: String)
}
