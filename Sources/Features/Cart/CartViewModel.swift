import Foundation

class CartViewModel: ObservableObject {
    
    // MARK: - @Published Properties
    @Published var cartItems: [CartItem] = []
    
    func quantityOfProductInCart(product: Product) -> Int {
        let cartItemForProduct = cartItems.filter { cartItem in cartItem.product.id == product.id }.first
        return cartItemForProduct?.quantity ?? 0
    }
    
    // MARK: - Properties
    var titleText: String = "Shopping Cart"

    // MARK: - Lifecycle
    init(moveToCartAction: @escaping NextStepClosureType = {}) {
    }
    
    // MARK: - Computed Properties
    var cartImageName: String { cartItems.isEmpty ? "cart" : "cart.fill"  }

    // MARK: - Persistence
    func fetchCartItems() -> [CartItem] {
       // TODO: fetch from file
        return cartItems
    }
    
    // MARK: - Helpers

    
    func cartItem(for productID: Int) -> CartItem? {
        // This might get slow if the cart was huge, but carts wouldn't be that big for one user
        return cartItems.filter { $0.product.id == productID }.first
    }
    
    func countInCart(for productID: Int) -> Int {
        guard let cartItem = cartItem(for: productID) else {
            return 0
        }
        return cartItem.quantity
    }
    
    
    // MARK: - Button states
    func addButtonEnabled(for productID: Int) -> Bool {
        guard let cartItem = cartItem(for: productID) else {
            return false
        }
        return cartItem.product.stock > 0
    }
    
    func removeButtonEnabled(for productID: Int) -> Bool {
        return countInCart(for: productID) > 0
    }
    
    // MARK: - Actions
    func addCartItem(product: Product) {
        guard let cartItem = cartItem(for: product.id) else {
            // Append the new item to the cart
            cartItems.append(CartItem(product: product, quantity: 1))
            return
        }
        // Just increment quantity of existing item
        cartItem.incrementQuantity(product: product)
        print("Number of Cart Items \(cartItems.count)")
        print("Cart:")
        for item in cartItems{
            print("\(item.product.title) - \(item.quantity)")
        }
    }
    
    func removeCartItem(product: Product) {
        guard let cartitem = cartItem(for: product.id) else {
            return
        }
        if cartitem.quantity <= 1 {
            cartItems.removeAll(where: { $0.product.id == product.id } )
        } else {
            cartitem.quantity = cartitem.quantity - 1
        }
    }
}

extension CartViewModel {
    
    static var previewEmptyViewModel: CartViewModel {
        return CartViewModel()
    }
    
    static var previewFilledViewModel: CartViewModel {
        let cartViewModel = CartViewModel()
        if let product1 = previewCartProducts[safe: 0] {
            cartViewModel.addCartItem(product: product1)
        }
        if let product2 = previewCartProducts[safe: 1] {
            cartViewModel.addCartItem(product: product2)
        }
        return cartViewModel
    }
    
    static var previewCartProducts: [Product] {
        let product1 = Product(product: APIProduct(id: 1, title: "iPhone 9", description: "An apple mobile which is nothing like apple", price: 549, discountPercentage: 12.96, rating: 4.69, stock: 94, brand: "Apple", category: "smartphones", thumbnail: "https://i.dummyjson.com/data/products/1/thumbnail.jpg",
                               images: [
                               "https://i.dummyjson.com/data/products/1/1.jpg",
                               "https://i.dummyjson.com/data/products/1/2.jpg",
                               "https://i.dummyjson.com/data/products/1/3.jpg",
                               "https://i.dummyjson.com/data/products/1/4.jpg",
                               "https://i.dummyjson.com/data/products/1/thumbnail.jpg"
                           ]))
        let product2 = Product(product: APIProduct(id: 2, title: "iPhone XR", description: "This a pretty good iPhone", price: 549, discountPercentage: 12.96, rating: 4.69, stock: 3, brand: "Apple", category: "smartphones", thumbnail: "https://i.dummyjson.com/data/products/1/thumbnail.jpg",
                               images: [
                               "https://i.dummyjson.com/data/products/1/1.jpg",
                               "https://i.dummyjson.com/data/products/1/2.jpg",
                               "https://i.dummyjson.com/data/products/1/3.jpg",
                               "https://i.dummyjson.com/data/products/1/4.jpg",
                               "https://i.dummyjson.com/data/products/1/thumbnail.jpg"
                           ]))
        return [product1,product2]
    }
    
}

