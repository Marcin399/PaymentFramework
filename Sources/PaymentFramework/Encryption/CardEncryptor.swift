import Foundation

class CardEncryptor: CardEncryptionProtocol {
    func encrypt(_ card: String) -> String {
        return String(card.reversed())
    }
}
