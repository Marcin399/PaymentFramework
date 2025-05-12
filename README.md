# PaymentFramework

## Features
- Card data form
- Input validation
- Error handling
- Historical transation storage
- SwiftUI and UIKit support
- Configurable UI
- Data encryption
- Simulation success or declain transaction

## Installation

Add the following dependency to your Project via Swift Package Manager 

```
https://github.com/Marcin399/PaymentFramework
```

## Project Structure

```
PaymentFramework/
├── Sources/
│   └── PaymentFramework/
│       ├── Config/         # Configuration settings
│       ├── Encryption/     # Security and encryption
│       ├── Errors/         # Error handling
│       ├── Models/         # Data models
│       ├── Protocols/      # Protocol definitions
│       ├── Services/       # Business logic
│       ├── Storage/        # Data persistence
│       ├── UIKitBridge/    # UIKit integration
│       ├── Validation/     # Input validation
│       ├── ViewModels/     # View models
│       └── Views/          # UI components
└── Tests/
    └── PaymentFrameworkTests/
```

## Usage

### Initial UI configuration 

```swift
let config = PaymentUIConfig(
    primaryColor: Color,           // Primary color for buttons and highlights
    inputBackground: Color,        // Background color for input fields
)
```

### SwiftUI Implementation

```swift
PaymentFormView(
    amount: Double,
    config: PaymentUIConfig,
    onDismiss: (() -> Void)?
)
```

### UIKit Implementation

```swift
let paymentVC = PaymentViewController(
    amount: Double,
    config: PaymentUIConfig
)

navigationController?.pushViewController(paymentVC, animated: true)
```

### Get payment history 

```swift
private var transactions: [Payment] = []
    
let paymentStorage = PaymentStorage()
   
do { 
    try transactions = paymentStorage.getAll()
} catch { 
    print("Error loading transactions: \error)")
}
```


