import Foundation

// MARK: - Product

extension ProductComponentView {
    struct Model: Codable, Hashable {
        let id: Int
        let title: String
        let description: String
        let price: Double
        let discountPercentage: Double
        let rating: Double
        let stock: Int
        let brand: String
        let thumbnail: String
        let images: [String]
        let quantityInCart: Int

        var roundedDiscountPercentage: Int { Int(discountPercentage) }
        var isInStock: Bool {self.stock > 0 }
        
        init(product: Product, quantity: Int) {
            self.id = product.id
            self.title = product.title
            self.description = product.description
            self.price = product.price
            self.discountPercentage = product.discountPercentage
            self.rating = product.rating
            self.stock = product.stock
            self.brand = product.brand
            self.thumbnail = product.thumbnail
            self.images = product.images
            self.quantityInCart = quantity
        }
        
        init(cartItem: CartItem) {
            self.id = cartItem.product.id
            self.title = cartItem.product.title
            self.description = cartItem.product.description
            self.price = cartItem.product.price
            self.discountPercentage = cartItem.product.discountPercentage
            self.rating = cartItem.product.rating
            self.stock = cartItem.product.stock
            self.brand = cartItem.product.brand
            self.thumbnail = cartItem.product.thumbnail
            self.images = cartItem.product.images
            self.quantityInCart = cartItem.quantity
        }
    }
}

