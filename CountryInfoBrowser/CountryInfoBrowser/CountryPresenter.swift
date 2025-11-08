import Foundation

class CountryPresenter: ObservableObject {
    @Published var countries: [Country] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let interactor: CountryInteractorProtocol
    
    init(interactor: CountryInteractorProtocol) {
        self.interactor = interactor
    }
    
    func loadCountries() {
        Task {
            isLoading = true
            errorMessage = nil
            do {
                let fetched = try await interactor.fetchCountries()
                countries = fetched.sorted(by: { $0.name.common < $1.name.common })
            } catch {
                errorMessage = "Failed to load countries."
            }
            isLoading = false
        }
    }
}

