//
//  StarterView.swift
//  LanguageLearningApp
//
//  Created by Murad Ismayilov on 05.03.23.
//

import SwiftUI

struct StarterView: View {
    @EnvironmentObject var userViewModel: UserManager
    
    // MARK: The @ViewBuilder attribute enables a closure that returns a child view to provide multiple children views instead. The @ViewBuilder attribute applied to body indicates that the returned view can actually consist of more than one view. Although here one view only is returned, you need it because two views are declared, one in the if branch and the other in the else’s.
    @ViewBuilder
    var body: some View {
        if userViewModel.isRegistered {
            WelcomeView()
        } else {
            RegisterView()
        }
    }
}

struct StarterView_Previews: PreviewProvider {
    static var previews: some View {
        StarterView()
            .environmentObject(UserManager())
    }
}
