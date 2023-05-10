import Foundation

// MARK: - Product
class Product: ObservableObject, Equatable, Hashable {

    @Published var id: Int
    @Published var title: String
    @Published var description: String
    @Published var price: Double
    @Published var discountPercentage: Double
    @Published var rating: Double
    @Published var stock: Int
    @Published var brand: String
    @Published var category: String
    @Published var thumbnail: String
    @Published var images: [String]
    
    init(product: APIProduct) {
        self.id = product.id
        self.title = product.title
        self.description = product.description
        self.price = product.price
        self.discountPercentage = product.discountPercentage
        self.rating = product.rating
        self.stock = product.stock
        self.brand = product.brand
        self.category = product.category
        self.thumbnail = product.thumbnail
        self.images = product.images
    }
    
    func decrementStockLevel(product: Product) {
        guard stock > 0 else {
            print("Stock is at 0. Purchase no longer available")
            return
        }
        stock = stock - 1
        print("Stock reduced to \(stock)")
    }
    
    func incrementStockLevel(product: Product) {
        stock = stock + 1
    }
    
    // Equitable
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
    
    // Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
