import SwiftUI

@main
struct ShoppingCartApp: App {
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ProductListingView() {
                }
            }
            .environmentObject(ProductListingViewModel())
            .environmentObject(CartViewModel())
            .onAppear {
                // Load of persisted Data might be here
            }
            
        }
    }
    
}
