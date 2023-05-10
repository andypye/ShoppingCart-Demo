import Combine
import Foundation

typealias NextStepClosureType = () -> Void

class ProductListingViewModel: ObservableObject {
    
    // MARK: - @Published Properties
    @Published var titleText: String = "Products"
    @Published var priceText: String = String("£0")
    @Published var productInventory: APIProductInventory = APIProductInventory()
    @Published var products: [Product] = []
    @Published var productCount: Int = 0
        
    // MARK: Closures
    var moveToCart: NextStepClosureType = {}
    
    // MARK: - Properties
    private let api = API.shared

    // MARK: - Lifecycle
    init(productInfo: APIProductInventory? = nil,
         moveToCartAction: @escaping NextStepClosureType = {}) {
        if let productInfo = productInfo {
            self.productInventory = productInfo
            products = productInfo.products.map { Product(product: $0) }
        }
    }
    
    private func fetchProductsAsync() async -> APIProductInventory? {
        do {
            guard let productInventory = try await api.getProducts() else {
                print("API returned no data.")
                return productInventory
            }
            return productInventory
        } catch {
            print("Unexpected error getting products: \(error).")
            return nil
        }
    }
    
    func fetchProducts() {
        Task {
            guard let fetchedProductInventory = await fetchProductsAsync() else {
                // TODO: Show an error
                return
            }
            DispatchQueue.main.async {
                self.productInventory = fetchedProductInventory
                self.products = fetchedProductInventory.products.map { Product(product: $0) }
                self.productCount = fetchedProductInventory.products.count 
                print("ProductInventory updated. Count of products: \(self.productInventory.products.count)")
            }
        }
    }
    
    // MARK: - Helpers
    func productInventoryItem(for productID: Int) -> Product? {
        // This might get slow if the cart was huge, but carts wouldn't be that big for one user
        return products.filter { $0.id == productID }.first
    }
    
    func countInStock(for productID: Int) -> Int {
        guard let productInventoryItem = productInventoryItem(for: productID) else {
            return 0
        }
        return productInventoryItem.stock
    }
    
    func addToCartButtonEnabled(for productID: Int) -> Bool {
        guard let productInventoryItem = productInventoryItem(for: productID) else {
            return false
        }
        return productInventoryItem.stock > 0
    }
    
    func removeFromCartButtonEnabled(for productID: Int) -> Bool {
        return false // TODO: To implement
        // return countInCart(for: productID) > 0
    }
    
    func reduceStock(for productID: Int) {
        guard let productInventoryItem = productInventoryItem(for: productID) else {
            return
        }
        productInventoryItem.decrementStockLevel(product: productInventoryItem)
    }
    
    func increaseStock(for productID: Int) {
        guard let productInventoryItem = productInventoryItem(for: productID) else {
            return
        }
        productInventoryItem.incrementStockLevel(product: productInventoryItem)
    }
}

extension ProductListingViewModel {
    
    static var previewEmptyViewModel: ProductListingViewModel {
        ProductListingViewModel(productInfo: nil)
    }
    
    static var previewFilledViewModel: ProductListingViewModel {
        ProductListingViewModel(productInfo: previewProductInfo)
    }
    
    static var previewProductInfo: APIProductInventory {
        let product1 = APIProduct(id: 1, title: "iPhone 9", description: "An apple mobile which is nothing like apple", price: 549, discountPercentage: 12.96, rating: 4.69, stock: 94, brand: "Apple", category: "smartphones", thumbnail: "https://i.dummyjson.com/data/products/1/thumbnail.jpg",
                               images: [
                                "https://i.dummyjson.com/data/products/1/1.jpg",
                                "https://i.dummyjson.com/data/products/1/2.jpg",
                                "https://i.dummyjson.com/data/products/1/3.jpg",
                                "https://i.dummyjson.com/data/products/1/4.jpg",
                                "https://i.dummyjson.com/data/products/1/thumbnail.jpg"
                               ])
        let product2 = APIProduct(id: 2, title: "iPhone XR", description: "This a pretty good iPhone", price: 549, discountPercentage: 12.96, rating: 4.69, stock: 3, brand: "Apple", category: "smartphones", thumbnail: "https://i.dummyjson.com/data/products/2/thumbnail.jpg",
                               images: [
                                "https://i.dummyjson.com/data/products/2/1.jpg",
                                "https://i.dummyjson.com/data/products/2/2.jpg",
                                "https://i.dummyjson.com/data/products/2/3.jpg",
                                "https://i.dummyjson.com/data/products/2/4.jpg",
                                "https://i.dummyjson.com/data/products/2/thumbnail.jpg"
                               ])
        return APIProductInventory(products: [product1,product2], total: 2, skip: 0, limit: 100)
    }
    
}
