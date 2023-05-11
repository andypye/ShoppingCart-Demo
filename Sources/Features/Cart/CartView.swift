import SwiftUI

struct CartView: View {
    // MARK: - Environment
    @EnvironmentObject var productListingViewModel: ProductListingViewModel
    @EnvironmentObject var cartViewModel: CartViewModel
    
    let saveAction: ()->Void

    var body: some View {
        VStack {
            Text(cartViewModel.titleText)
                .font(.title)
            List($cartViewModel.cartItems, id: \.self) {
                cartItem in
                ProductComponentView(model: ProductComponentView.Model(cartItem: cartItem.wrappedValue) , viewMode: .cart, styler: ProductComponentView.Styler.defaultStyler, onClickAdd: {
                    productListingViewModel.reduceStock(for: cartItem.wrappedValue.product.id)
                    cartViewModel.addCartItem(product:  cartItem.product.wrappedValue)
                },
                onClickRemove: {
                    productListingViewModel.increaseStock(for: cartItem.wrappedValue.product.id)
                    cartViewModel.removeCartItem(product:  cartItem.product.wrappedValue)
                })
            }
            .cornerRadius(10)
        }
        .padding()
    }
    
}

struct CartView_Previews: PreviewProvider {
    static let productListingViewModel = ProductListingViewModel.previewFilledViewModel
    static let cartViewModel =  CartViewModel.previewFilledViewModel

    static var previews: some View {
        CartView(saveAction: {
            guard productListingViewModel.products.count > 0 else {
                logger.info("There is no product")
                return
            }
            let currentProduct = productListingViewModel.products[0]
            cartViewModel.addCartItem(product: currentProduct)
        })
        .environmentObject(ProductListingViewModel.previewFilledViewModel)
        .environmentObject(CartViewModel.previewFilledViewModel)
        .previewDisplayName("Cart View")
    }
}
