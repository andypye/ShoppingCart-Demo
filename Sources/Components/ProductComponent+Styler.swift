import SwiftUI

extension ProductComponentView {
    struct Styler {
        let titleFont: Font
        let titleColor: Color
        let padding: CGFloat
        let cornerRadius: CGFloat
        let verticalSpacing : CGFloat
        let imageHeight: CGFloat
        let imageWidth: CGFloat
    }
}

extension ProductComponentView.Styler {
    static let defaultStyler: Self =
        .init(titleFont: .body,
              titleColor: .black,
              padding: 20,
              cornerRadius: 10,
              verticalSpacing: 10,
              imageHeight: 128,
              imageWidth: 128)
}
