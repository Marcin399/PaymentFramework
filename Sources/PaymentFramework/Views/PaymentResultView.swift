import SwiftUI

@available(iOS 15.0, *)
struct PaymentResultView: View {
    let success: Bool

    var body: some View {
        VStack {
            Text(success ? "✅" : "❌")
                .font(.largeTitle)
                .padding()
            Text(success ? "Płatność zakończona sukcesem" : "Płatność nie powiodła się")
                .font(.headline)
                .padding()
        }
    }
}
