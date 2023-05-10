import Foundation
import Combine

class CartItem: ObservableObject, Hashable, Equatable {

    @Published var product: Product
    @Published var quantity: Int = 1
    
    // MARK: Lifecycle
    init(product: Product, quantity: Int) {
        self.product = product
        self.quantity = quantity
    }
    
    // MARK: - Cart management
    func incrementQuantity(product: Product) {
        quantity = quantity + 1
    }
    
    func decrementQuantity(product: Product) {
        guard quantity > 0 else {
            return
        }
        quantity = quantity - 1
    }
    
    // MARK: - Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(product.id)
    }
    
    // MARK: - Equatable
    static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        lhs.product == rhs.product
    }
    
}

extension CartItem {
    
    var cartTotalForProduct: Double { product.price * Double(quantity) }
    
}
