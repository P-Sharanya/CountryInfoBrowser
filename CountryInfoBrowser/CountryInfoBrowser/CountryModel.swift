import Foundation

struct Country: Codable, Identifiable, Hashable {
    var id: String { name.common }
    let name: Name
    let region: String?
    let flags: Flags?
    let population: Int?
    let capital: [String]?

    struct Name: Codable, Hashable {
        let common: String
    }

    struct Flags: Codable, Hashable {
        let png: String?
        let svg: String?
    }
}
