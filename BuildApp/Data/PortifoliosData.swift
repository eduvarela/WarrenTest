
import Foundation

struct PortifoliosData: Codable{
    let portifolios: String
}

struct PortifolioData: Codable{
    let id: String
    let name: String
    let background: PortifolioBackground
    let totalBalance: Double
    let goalAmount: Double?
    let goalDate: String
}

struct PortifolioBackground: Codable{
    let thumb: String
    let small: String
    let full: String
    let regular: String
    let raw: String
}
