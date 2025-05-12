import XCTest
@testable import PaymentFramework

final class PaymentFormValidatorTests: XCTestCase {
    var sut: PaymentFormValidator!
    
    override func setUp() {
        super.setUp()
        sut = PaymentFormValidator()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Card Number Tests
    
    func testIsValidCardNumber_WithValidNumber_ReturnsTrue() {
        let validCardNumber = "4111111111111111"
        
        let result = sut.isValidCardNumber(validCardNumber)
        
        XCTAssertTrue(result)
    }
    
    func testIsValidCardNumber_WithInvalidLength_ReturnsFalse() {
        let invalidCardNumber = "411111111111111"
        
        let result = sut.isValidCardNumber(invalidCardNumber)
        
        XCTAssertFalse(result)
    }
    
    func testIsValidCardNumber_WithSpaces_ReturnsTrue() {
        let cardNumberWithSpaces = "4111 1111 1111 1111"
        
        let result = sut.isValidCardNumber(cardNumberWithSpaces)
        
        XCTAssertTrue(result)
    }
    
    // MARK: - Expiry Date Tests
    
    func testIsValidExpiryDate_WithValidFormat_ReturnsTrue() {
        let validExpiryDate = "12/25"
        
        let result = sut.isValidExpiryDate(validExpiryDate)
        
        XCTAssertTrue(result)
    }
    
    func testIsValidExpiryDate_WithInvalidLength_ReturnsFalse() {
        let invalidExpiryDate = "12/2"
        
        let result = sut.isValidExpiryDate(invalidExpiryDate)
        
        XCTAssertFalse(result)
    }
    
    // MARK: - CVV Tests
    
    func testIsValidCVV_WithValidLength_ReturnsTrue() {
        let validCVV = "123"
        
        let result = sut.isValidCVV(validCVV)
        
        XCTAssertTrue(result)
    }
    
    func testIsValidCVV_WithInvalidLength_ReturnsFalse() {
        let invalidCVV = "12"
        
        let result = sut.isValidCVV(invalidCVV)
        
        XCTAssertFalse(result)
    }
    
    // MARK: - Form Validation Tests
    
    func testIsValidForm_WithAllValidInputs_ReturnsTrue() {
        let validCardNumber = "4111111111111111"
        let validExpiryDate = "12/25"
        let validCVV = "123"
        
        let result = sut.isValidForm(
            cardNumber: validCardNumber,
            expiryDate: validExpiryDate,
            cvv: validCVV
        )
        
        XCTAssertTrue(result)
    }
    
    func testIsValidForm_WithInvalidCardNumber_ReturnsFalse() {
        let invalidCardNumber = "411111111111111"
        let validExpiryDate = "12/25"
        let validCVV = "123"
        
        let result = sut.isValidForm(
            cardNumber: invalidCardNumber,
            expiryDate: validExpiryDate,
            cvv: validCVV
        )
        
        XCTAssertFalse(result)
    }
    
    func testIsValidForm_WithInvalidExpiryDate_ReturnsFalse() {
        let validCardNumber = "4111111111111111"
        let invalidExpiryDate = "12/2"
        let validCVV = "123"
        
        let result = sut.isValidForm(
            cardNumber: validCardNumber,
            expiryDate: invalidExpiryDate,
            cvv: validCVV
        )
        
        XCTAssertFalse(result)
    }
    
    func testIsValidForm_WithInvalidCVV_ReturnsFalse() {
        let validCardNumber = "4111111111111111"
        let validExpiryDate = "12/25"
        let invalidCVV = "12"
        
        let result = sut.isValidForm(
            cardNumber: validCardNumber,
            expiryDate: validExpiryDate,
            cvv: invalidCVV
        )
        
        XCTAssertFalse(result)
    }
} 
