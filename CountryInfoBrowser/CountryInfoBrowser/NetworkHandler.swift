import Foundation

protocol NetworkHandlerProtocol {
    func fetchData<T: Codable>(from urlString: String, type: T.Type) async throws -> T
}

class NetworkHandler: NetworkHandlerProtocol {
    func fetchData<T: Codable>(from urlString: String, type: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            print("❌ Decoding error:", error)
            throw error
        }
    }
}
