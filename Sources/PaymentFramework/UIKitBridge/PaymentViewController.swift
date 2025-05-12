import SwiftUI
import UIKit

@available(iOS 15.0, *)
public class PaymentViewController: UIViewController {
    private let amount: Double
    private let config: PaymentUIConfig
    public var onDismiss: (() -> Void)?

    public init(amount: Double, config: PaymentUIConfig = PaymentUIConfig()) {
        self.amount = amount
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        let controller = UIHostingController(rootView: PaymentFormView(amount: amount, config: config, onDismiss: onDismiss))
        addChild(controller)
        view.addSubview(controller.view)
        controller.view.frame = view.bounds
        controller.didMove(toParent: self)
    }
}
