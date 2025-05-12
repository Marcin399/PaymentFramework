import Foundation

class PaymentFormValidator: PaymentFormValidatingProtocol {
    func isValidCardNumber(_ cardNumber: String) -> Bool {
        let cleanedNumber = cardNumber.replacingOccurrences(of: " ", with: "")
        return cleanedNumber.count == 16
    }
    
    func isValidExpiryDate(_ expiryDate: String) -> Bool {
        return expiryDate.count == 5
    }
    
    func isValidCVV(_ cvv: String) -> Bool {
        return cvv.count == 3
    }
    
    func isValidForm(cardNumber: String, expiryDate: String, cvv: String) -> Bool {
        return isValidCardNumber(cardNumber) &&
               isValidExpiryDate(expiryDate) &&
               isValidCVV(cvv)
    }
    
} 
