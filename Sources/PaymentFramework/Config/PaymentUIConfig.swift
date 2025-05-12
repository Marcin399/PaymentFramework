import SwiftUI

@available(iOS 15.0, *)
public struct PaymentUIConfig {
    public var primaryColor: Color = .blue
    public var inputBackground: Color = Color(UIColor.secondarySystemBackground)

    public init(primaryColor: Color = .blue, inputBackground: Color = Color(UIColor.secondarySystemBackground)) {
        self.primaryColor = primaryColor
        self.inputBackground = inputBackground
    }
}
