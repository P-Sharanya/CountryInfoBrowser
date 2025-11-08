
import UIKit
import SwiftUI

class CountryListBuilder {
    func createView() -> UIViewController {
        let network = NetworkHandler()
        let interactor = CountryInteractor(networkHandler: network)
        let presenter = CountryPresenter(interactor: interactor)
        let view = CountryListView(presenter: presenter)
        return UIHostingController(rootView: view)
    }
}
