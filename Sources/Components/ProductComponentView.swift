import SwiftUI

public struct ProductComponentView: View {
    public typealias ActionHandler = () -> Void
    
    // MARK: Properties
    let model: Model
    let styler: Styler
    
    let onClickAdd: ActionHandler
    let onClickRemove: ActionHandler
    
    var formattedPrice: String { "£" + String(roundTo1DP(value: model.price)) }
    var formattedRating: String { String(roundTo1DP(value: model.rating)) }
    var formattedDiscountPercentageString: String { "\(model.roundedDiscountPercentage)% off" }
    var formattedStock: String { "\(model.stock) available" }
    var formattedQuantityInCart: String { "\(model.stock) available" }
    var ratingInt: Int { Int(model.rating) }
    
    var cartAddImageName: String { "cart.badge.plus"  }
    var cartRemoveImageName: String { "cart.badge.minus"  }
    
    func roundTo1DP(value: Double) -> Double {
        return ceil(value * 10) / 10.0
    }
    
    enum ViewMode {
        case productListing
        case cart
    }
    let viewMode: ViewMode
    
    // MARK: - Lifecycle
    init(model: Model,
         viewMode: ViewMode,
         styler: Styler,
         onClickAdd: @escaping (ProductComponentView.ActionHandler),
         onClickRemove: @escaping (ProductComponentView.ActionHandler)
    ) {
        self.model = model
        self.onClickAdd = onClickAdd
        self.onClickRemove = onClickRemove
        self.styler = styler
        self.viewMode = viewMode
    }
    
    // MARK: - Body
    public var body: some View {
        VStack(alignment: .leading, spacing: styler.verticalSpacing,
               content: {
            Text("\(model.brand) \(model.title)")
                .bold()
            RatingView(rating: ratingInt)
                .font(.footnote)
            HStack {
                Text(formattedPrice)
                Text(formattedDiscountPercentageString)
                    .font(.footnote)
                    .foregroundColor(.red)
            }
            AsyncImage(url: URL(string: model.thumbnail), scale: 2)
                .aspectRatio(contentMode: .fit)
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: styler.cornerRadius))
            switch viewMode {
            case .productListing:
                HStack {
                    Text(formattedStock)
                        .font(.footnote)
                        Button { onClickRemove() }
                    label: { Image(systemName: cartRemoveImageName) }
                            .buttonStyle(.bordered)
                            .foregroundColor(.red)
                            .disabled(false)
                        if model.stock > 0 {
                            Button { onClickAdd() }
                        label: { Image(systemName: cartAddImageName) }
                                .buttonStyle(.bordered)
                                .foregroundColor(.blue)
                        } else {
                            Text("Out of stock")
                                .font(.subheadline)
                        }
                }
            case .cart:
                HStack {
                    Button("-", action: onClickRemove)
                        .foregroundColor(.red)
                        .buttonStyle(.bordered)
                        .font(.footnote)
                    Text("\(model.quantityInCart)")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    if model.stock > 0 {
                        Button("+", action: onClickAdd)
                            .foregroundColor(.blue)
                            .buttonStyle(.bordered)
                            .font(.footnote)
                    }
                    else {
                        Text("Out of stock")
                            .font(.subheadline)
                    }
                }
            }
        })
        .frame(maxWidth: .infinity)
        .font(.body)
        .padding(styler.padding)
        .border(.clear)
    }
}

// MARK: - Previews
struct ProductComponentView_Previews: PreviewProvider {
    
    private static var previewProduct = ProductListingViewModel.previewFilledViewModel.products[0]
    private static var previewCart = CartViewModel.previewFilledViewModel
    static let styler = ProductComponentView.Styler(titleFont: .body, titleColor: .black, padding: 20, cornerRadius: 25, verticalSpacing: 10, imageHeight: 128, imageWidth: 128)
    
    static var previews: some View {
        Group {
            VStack {
                Text("Cart style")
                    .bold()
                    .underline()
                ProductComponentView(model: ProductComponentView.Model(product: previewProduct,quantity: previewCart.countInCart(for: previewProduct.id ?? 0)), viewMode: .cart, styler: ProductComponentView.Styler.defaultStyler, onClickAdd: { print("+ Button Pressed") }, onClickRemove: { print("- Button Pressed") })
            }
            .previewDisplayName("Cart Style")
            VStack {
                Text("Product listing style")
                    .bold()
                    .underline()
                ProductComponentView(model: ProductComponentView.Model(product: previewProduct, quantity: previewCart.countInCart(for: previewProduct.id ?? 0)), viewMode: .productListing, styler: ProductComponentView.Styler.defaultStyler, onClickAdd: { print("+ Button Pressed") }, onClickRemove: { print("- Button Pressed") })
            }
            .previewDisplayName("Product Style")
        }
    }
}
