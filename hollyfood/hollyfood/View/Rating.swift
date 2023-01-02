//
//  Rating.swift
//  hollyfood
//
//  Created by AlaBenRejab on 1/1/2023.
//
import SwiftUI

struct Rating: View {
    var numberOfStars: Int
    
    @State private var maximumNumberOfStars = 5

    var body: some View {
        HStack(spacing: 2) {
            ForEach(1 ..< maximumNumberOfStars + 1) { numberOfStars in
                Image(systemName: "star")
                   // .font(Font.caption.bold())
                    .foregroundColor(numberOfStars <= self.numberOfStars ? .yellow : Color(Image(systemName: "Tertiary") as! CGColor))
            }
        }
    }
}
struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
       Rating(numberOfStars: 5)
    }
}
import SwiftUI

struct RatingProgress: View {
    let numberOfStars: Int
    let numberOfReviews: String
    let progressValue: CGFloat
    
    var body: some View {
        HStack(spacing: 10) {
            rating
            //-progress
            
            Text(numberOfReviews)
                .font(Font.caption2.weight(.regular))
                .foregroundColor(.secondary)
        }
    }
    
    var rating: some View {
        HStack(spacing: 2) {
            ForEach(numberOfStars ..< 6) { numberOfStars in
                Image(systemName: "star")
                    .font(Font.system(size: 9).weight(.semibold))
                    .foregroundColor(.yellow)
            }
        }
        .frame(width: 68, alignment: .trailing)
    }
    
   /* var progress: some View {
        LinearProgressBar(progress: progressValue)
    }*/
}
