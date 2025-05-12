import SwiftUI

@available(iOS 15.0, *)
struct PaymentFormView: View {
    @StateObject private var viewModel: PaymentFormViewModel
    @State private var showConfig = false
    
    init(amount: Double,
         config: PaymentUIConfig,
         paymentService: PaymentServiceProtocol = PaymentService(),
         validator: PaymentFormValidatingProtocol = PaymentFormValidator(),
         cardEncryptor: CardEncryptionProtocol = CardEncryptor(),
         onDismiss: (() -> Void)? = nil) {
        _viewModel = StateObject(wrappedValue: PaymentFormViewModel(
            amount: amount,
            config: config,
            paymentService: paymentService,
            validator: validator,
            cardEncryptor: cardEncryptor,
            onDismiss: onDismiss
        ))
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Kwota do zapłaty: \(String(format: "%.2f", viewModel.amount)) zł")
                    .font(.headline)
                    .foregroundColor(viewModel.config.primaryColor)
                
                Spacer()
                
                Button(action: {
                    showConfig = true
                }) {
                    Image(systemName: "gear")
                        .foregroundColor(viewModel.config.primaryColor)
                }
            }
            
            TextField("Numer karty", text: $viewModel.cardNumber)
                .keyboardType(.numberPad)
                .onChange(of: viewModel.cardNumber) { newValue in
                    viewModel.updateCardNumber(newValue)
                }
                .padding()
                .background(viewModel.config.inputBackground)
                .cornerRadius(8)
                .disabled(viewModel.isProcessing)
            
            TextField("MM/YY", text: $viewModel.expiryDate)
                .keyboardType(.numbersAndPunctuation)
                .onChange(of: viewModel.expiryDate) { newValue in
                    viewModel.updateExpiryDate(newValue)
                }
                .padding()
                .background(viewModel.config.inputBackground)
                .cornerRadius(8)
                .disabled(viewModel.isProcessing)
            
            
            TextField("CVV", text: $viewModel.cvv)
                .keyboardType(.numberPad)
                .onChange(of: viewModel.cvv) { newValue in
                    viewModel.updateCVV(newValue)
                }
                .padding()
                .background(viewModel.config.inputBackground)
                .cornerRadius(8)
                .disabled(viewModel.isProcessing)
            
            if !viewModel.isProcessing {
                Button("Zapłać") {
                    viewModel.pay()
                }
                .disabled(!viewModel.isFormValid || viewModel.isProcessing)
                .padding()
                .background(viewModel.isFormValid || viewModel.isProcessing ? viewModel.config.primaryColor : .gray)
                .foregroundColor(.white)
                .cornerRadius(10)
            } else {
                ProgressView().padding()
            }
            
            
        }
        .padding()
        .sheet(isPresented: $viewModel.showResult) {
            PaymentResultView(success: viewModel.success)
        }
        .sheet(isPresented: $showConfig) {
            PaymentUIConfigView(config: $viewModel.config)
        }
        .onDisappear() {
            viewModel.onDismiss?()
        }
    }
}
