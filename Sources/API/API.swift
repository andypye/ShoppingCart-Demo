import Foundation

class API {
    
    static let shared = API()
    
    // MARK: Private Init
    private init() {
    }
    
    func getProducts() async throws -> APIProductInventory? {
        let (data, _) = try await URLSession.shared.data(
            from: URL(string: "https://dummyjson.com/products")!
        )
        return try? JSONDecoder().decode(APIProductInventory.self, from: data)
    }
    
}
