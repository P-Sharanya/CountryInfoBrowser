import UIKit
import SwiftUI

class CompositionRoot {
    
    private lazy var navigationVC: UINavigationController = {
        let nav = UINavigationController()
        return nav
    }()
    
    func getRootViewController() -> UIViewController {
        return navigationVC
    }
    
    func showInitialScreen() {
        let vc = CountryListBuilder().createView()
        navigationVC.pushViewController(vc, animated: false)
    }
}

// SwiftUI bridge to load UIKit navigation system
struct RootUIKitContainerView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let root = CompositionRoot()
        root.showInitialScreen()
        return root.getRootViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
