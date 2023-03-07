//
//  LanguageLearningAppApp.swift
//  LanguageLearningApp
//
//  Created by Murad Ismayilov on 04.03.23.
//

import SwiftUI

// MARK: Likewise, if you run the app in the Simulator, it will crash. The change you’ve just made is only for the preview, and it doesn’t affect the app. You need to makes changes in LanguageLearningAppApp as well. Open it and add this property and initializer to LanguageLearningAppApp:
@main
struct LanguageLearningAppApp: App {
    // MARK: This creates an instance of UserManager, and makes sure the stored user, if available, is loaded.
    let userManager = UserManager()
    
    @AppStorage("appearance")
    var appearance: Appearance = .automatic
    
    init() {
        userManager.load()
    }
    
    var body: some Scene {
        WindowGroup {
//            /// Inject the UserManager instance
//            StarterView()
//                .environmentObject(userManager)
//            // MARK: Here, you’re creating an instance of ChallengesViewModel and injecting it into the environment. All the views in the StarterView’s hierarchy now have access to that instance.
//
//            // MARK: You’re injecting an unnamed instance into the environment. When you pull it using the @EnvironmentObject, you just specify the instance type. This is important to remember because it means that you can only inject one instance per type into the environment. If you inject another instance, it will replace the first.
//                .environmentObject(ChallengesViewModel())
            StarterView()
              .environmentObject(userManager)
              .environmentObject(ChallengesViewModel())
              .preferredColorScheme(appearance.getColorScheme())
        }
    }
}
