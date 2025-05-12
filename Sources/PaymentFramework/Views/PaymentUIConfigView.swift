import SwiftUI

@available(iOS 15.0, *)
public struct PaymentUIConfigView: View {
    @Binding public var config: PaymentUIConfig
    @Environment(\.dismiss) private var dismiss
    
    public init(config: Binding<PaymentUIConfig>) {
        self._config = config
    }
    
    public var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Kolory")) {
                    ColorPicker("Kolor główny", selection: $config.primaryColor)
                    ColorPicker("Tło pól wprowadzania", selection: $config.inputBackground)
                }
                
                Section {
                    Button("Gotowe") {
                        dismiss()
                    }
                }
            }
            .navigationTitle("Konfiguracja UI")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
} 
