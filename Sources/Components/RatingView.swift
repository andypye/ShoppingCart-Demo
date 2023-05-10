import SwiftUI

struct RatingView: View {
    
    var rating: Int
    var label = ""
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    
    // MARK: - Body
    public var body: some View {
        HStack(spacing: 1) {
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .imageScale(.small)
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    
}

struct  RatingView_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
        RatingView(rating: 5)
        RatingView(rating: 4)
        RatingView(rating: 3)
        RatingView(rating: 2)
        RatingView(rating: 1)
            
        }
    }
    
}
