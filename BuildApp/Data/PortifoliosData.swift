
import Foundation

struct PortfoliosData: Codable{
    let portfolios: [PortfolioData]
}

struct PortfolioData: Codable{
    let id: String
    let name: String
    let background: PortfolioBackground
    let totalBalance: Double
    let goalAmount: Double?
    let goalDate: String
    
    enum CodingKeys: String, CodingKey {
         case id = "_id"
        case name
        case background
        case totalBalance
        case goalAmount
        case goalDate
     }
}

struct PortfolioBackground: Codable{
    let thumb: String
    let small: String
    let full: String
    let regular: String
    let raw: String
}
