import Foundation

// MARK: - Product
struct APIProduct: Codable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
    
}

// MARK: - helpers
extension APIProduct {
    var roundedDiscountPercentage: Int { Int(discountPercentage) }
    var isInStock: Bool { self.stock > 0 }
}
