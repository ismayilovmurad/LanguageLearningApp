//
//  WelcomeMessageView.swift
//  LanguageLearningApp
//
//  Created by Murad Ismayilov on 05.03.23.
//

import SwiftUI

struct WelcomeMessageView: View {
    var body: some View {
        // MARK: Note how the new Swift 5.3’s multiple closures syntax is used here.
        
        // MARK: DefaultLabelStyle: This is the default value, which corresponds to specifying no style at all. It displays both the title and the icon. IconOnlyLabelStyle: This displays the icon only, ignoring the title. TitleOnlyLabelStyle: This displays the title only, hiding the icon. HorizontallyAlignedLabelStyle: Your own style
        
        // MARK: You use Label when you want to combine a text and an image into a single component.
        Label {
            // MARK: When you have a container view, and you want one or more modifiers to be applied to all subviews, simply apply those modifiers to the container.
            
            // MARK: While the VStack alignment can have three possible values — .center, .leading and .trailing — the HStack counterpart is a bit richer. Apart from center, bottom and top, it also has two very useful cases: firstTextBaseline: Aligns views based on the topmost text baseline view. lastTextBaseline: Aligns views based on the bottom-most text baseline view.
            VStack(alignment: .leading) {
                // MARK: Text is very adaptive, as it tries to format and wrap the text in order to best fit with the proposed size. But it becomes less adaptive when it’s forced to use a maximum number of lines, via the lineLimit modifier.
                Text("Welcome to")
                // MARK: Although you have the power to decide which font to use, as well as its size, Apple recommends favoring size classes over absolute sizes where you can.
                
                // MARK: All sizes are defined in Font as pseudo-enum cases: They’re actually static properties. UIKit and AppKit have corresponding class sizes.
                
                // MARK: Using size classes gives the user the freedom to increase or decrease all fonts used in your app relative to a reference size: if the reference size is increased, all fonts become larger in proportion, and if decreased, then the fonts become smaller. This is a huge help to people with eyesight issues or visual impairments.
                    .font(.headline)
                    .bold()
                
                Text("Ananas")
                    .font(.largeTitle)
                    .bold()
            }
            .foregroundColor(.accentColor)
            .lineLimit(2)
            .padding(.horizontal)
        } icon: {
            LogoImage()
        }
        /// custom LabelStyle
        .labelStyle(HorizontallyAlignedLabelStyle())
    }
}

struct WelcomeMessageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeMessageView()
    }
}
