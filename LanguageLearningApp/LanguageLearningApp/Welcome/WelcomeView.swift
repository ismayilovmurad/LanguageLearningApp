//
//  WelcomeView.swift
//  LanguageLearningApp
//
//  Created by Murad Ismayilov on 04.03.23.
//

import SwiftUI

struct WelcomeView: View {
    /// Because you introduced an uninitialized property (userManager) to the view, you need to update WelcomeView_Previews to include this.
    @EnvironmentObject var userManager: UserManager
    // MARK: You’re using the @EnvironmentObject attribute, specifying that this property must be initialized with an instance of ChallengesViewModel taken from the view’s environment. You no longer need to instantiate it because the property is initialized with an existing instance.
    @State var showPractice = false
    
    // MARK: With a few exceptions, the View’s body property expects one and only one subview.
    
    // MARK: If you want to embed more than one subview in a view, you have to rely on a container view. The simplest and most commonly used container views is the stack, the SwiftUI counterpart of UIKit’s UIStackView.
    // MARK: Stack views are limited to only containing 10 children. This is because stack views, among other View types, are initialed with a @ViewBuilder, which itself can be initialized with up to 10 views.
    
    // MARK: Because body contains an if-else pair you need to prepend @ViewBuilder to satisfy the compiler. Same as you did in StarterView previously.
    @ViewBuilder
    var body: some View {
        // MARK: In ZStack, children are sorted by the position in which they are declared, which means that the first subview is rendered at the bottom of the stack, and the last one is at the top.
        // MARK: As with the other container views, ZStack positions its children views at its center by default.
        if showPractice {
            HomeView()
        } else {
            ZStack {
                WelcomeBackgroundImage()
                
                VStack {
                    Text(verbatim: "Hi, \(userManager.profile.name)")
                    
                    WelcomeMessageView()
                    
                    Button(action: {
                        self.showPractice = true
                    }, label: {
                        HStack {
                            Image(systemName: "play")
                            Text(verbatim: "Start")
                        }
                    })
                }
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView().environmentObject(UserManager())
    }
}
