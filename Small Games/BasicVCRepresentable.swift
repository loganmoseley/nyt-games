import SwiftUI
import UIKit

struct BasicVCRepresentable<VC: UIViewController>: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> VC {
        VC()
    }

    func updateUIViewController(_ uiViewController: VC, context: Context) {

    }
}

struct BasicVCView<VC: UIViewController>: View {
    var body: some View {
        BasicVCRepresentable<VC>()
    }
}
