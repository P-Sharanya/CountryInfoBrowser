import Foundation

protocol CountryInteractorProtocol {
    func fetchCountries() async throws -> [Country]
    func fetchCountryDetails(name: String) async throws -> Country?
}

class CountryInteractor: CountryInteractorProtocol {
    private let networkHandler: NetworkHandlerProtocol
    
    init(networkHandler: NetworkHandlerProtocol) {
        self.networkHandler = networkHandler
    }
    
    func fetchCountries() async throws -> [Country] {
        let url = "https://restcountries.com/v3.1/all?fields=name,region,flags,population,capital"
        let all = try await networkHandler.fetchData(from: url, type: [Country].self)
        return Array(all.prefix(10)) // ✅ Limit to first 10 countries
    }
    
    func fetchCountryDetails(name: String) async throws -> Country? {
        let url = "https://restcountries.com/v3.1/name/\(name)?fields=name,region,flags,population,capital"
        let countries = try await networkHandler.fetchData(from: url, type: [Country].self)
        return countries.first
    }
}
