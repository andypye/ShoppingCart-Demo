import Combine

struct APIProductInventory: Codable {
    var products: [APIProduct] = []
    let total: Int
    let skip: Int
    let limit: Int
    
    init(products: [APIProduct], total: Int, skip: Int, limit: Int) {
        self.products = products
        self.total = total
        self.skip = skip
        self.limit = limit
    }
    
    init() {
        self.products = []
        self.total = 0
        self.skip = 0
        self.limit = 0
    }
}

extension APIProductInventory {
    enum Error: Swift.Error {
        case productFetchError
        // TODO: add more cases
    }
    
}
