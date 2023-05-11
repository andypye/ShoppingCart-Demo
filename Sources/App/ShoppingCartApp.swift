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
                logger.info("On Appear at startup")
                // Load of persisted Data might be here
            }
            
        }
    }
    
}
