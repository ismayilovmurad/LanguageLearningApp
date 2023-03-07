//
//  WelcomeBackgroundImage.swift
//  LanguageLearningApp
//
//  Created by Murad Ismayilov on 05.03.23.
//

import SwiftUI

struct WelcomeBackgroundImage: View {
    var body: some View {
        // MARK: When you create an image without providing any modifiers, SwiftUI will render the image at its native resolution and maintain the image’s aspect ratio. The image you’re using here is taken from SF Symbols, a set of icons that Apple introduced in the 2019 iterations of iOS, watchOS and tvOS.
        
        // MARK: If you want to resize an image, you have to apply the resizable modifier, which takes two parameters: an inset and a resizing mode. The resizing mode can be either .tile or .stretch.
        
        // MARK: If you don’t provide any parameters, SwiftUI assumes no inset for all four directions (top, bottom, leading and trailing) and .stretch resizing mode.
        
        // MARK: If you don’t apply the resizable modifier, the image will keep its native size. When you apply a modifier that either directly or indirectly changes the image’s size, that change is applied to the actual view the modifier is applied to, but not to the image itself, which will retain its original size.
        
        // MARK: Image is one of the least adaptive components, because it ignores the size proposed by its parent. But its behavior drastically changes after applying the resizable modifier, which enables it to blindly accept any size proposed by the parent.
        Image("cool-pineapple", bundle: nil)
        // MARK: By default, SwiftUI tries to use all of the space at its disposal, without worrying about the aspect ratio.
            .resizable()
        // MARK: Maximize the image so that it’s fully visible within the parent, with respect to the original ratio.
            .scaledToFit()
        // MARK: Set the aspect ratio, which is 1:1 by default. Setting contentMode to .fill makes the image fill the entire parent view, so a portion of the image will extend beyond the view’s boundaries.
            .aspectRatio(1 / 1, contentMode: .fill)
        // MARK: Ignore the safe area insets, extending the view outside the safe area, so that it occupies the entire parent space.
        
        // MARK: Here, you’re ignoring all edges, but it can also be configured on a per-edge basis. To do that, you pass an array of the edges to ignore: .top, .bottom, .leading, .trailing, but also .vertical and .horizontal, which combine the two vertical and the two horizontal edges respectively.
            .edgesIgnoringSafeArea(.all)
            .saturation(0.5)
            .blur(radius: 5)
            .opacity(0.2)
    }
}

struct WelcomeBackgroundImage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeBackgroundImage()
    }
}
