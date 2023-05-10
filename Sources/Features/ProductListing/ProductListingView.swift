import SwiftUI

struct ProductListingView: View {
    // MARK: - Environment
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject var productListingViewModel: ProductListingViewModel
    @EnvironmentObject var cartViewModel: CartViewModel
    
    // MARK: - Actions
    let saveAction: ()->Void
    
    var body: some View {
        VStack {
            productListing(products: productListingViewModel.products)
                .scrollContentBackground(.hidden)
                .cornerRadius(10)
                .padding()
                .backgroundStyle(.blue)
        }
        .navigationTitle(productListingViewModel.titleText)
        .navigationBarTitleDisplayMode(.inline)
        .font(.body)
        .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: CartView(saveAction: {} )) {
                            Image(systemName: cartViewModel.cartImageName)
                                .font(.footnote)
                        }
                    }
                }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
        .onAppear { if productListingViewModel.products.count == 0 {
            productListingViewModel.fetchProducts()
        }
        }
    }
    
    private func productListing(products: [Product]) -> List<Never, ForEach<[Product], Product, ProductComponentView>> {
        return List(products, id: \.self) {
            product in
            makeProductComponentViewModel(with: product)
        }
    }
    
    private func makeProductComponentViewModel(with product: Product) -> ProductComponentView {
        return ProductComponentView(model: ProductComponentView.Model(
            product: product,
            quantity: cartViewModel.quantityOfProductInCart(product: product)),
                                    viewMode: .productListing,
                                    styler: ProductComponentView.Styler.defaultStyler,
                                    onClickAdd: {
            cartViewModel.addCartItem(product: product)
            productListingViewModel.reduceStock(for: product.id)
        },
                                    onClickRemove:   {
            cartViewModel.removeCartItem(product: product)
            productListingViewModel.increaseStock(for: product.id)
        })
    }
    
}

// MARK: - Previews
struct ProductView_Previews: PreviewProvider {
    static let productListingViewModel = ProductListingViewModel.previewFilledViewModel
    static let cartViewModel =  CartViewModel.previewFilledViewModel

    static var previews: some View {
        ProductListingView(saveAction: {
            guard productListingViewModel.products.count > 0 else {
                print("There is no product")
                return
            }
            let currentProduct = productListingViewModel.products[0]
            cartViewModel.addCartItem(product: currentProduct)
        })
        .environmentObject(ProductListingViewModel.previewFilledViewModel)
        .environmentObject(CartViewModel.previewFilledViewModel)
        .previewDisplayName("Product Listing View")
    }
}
