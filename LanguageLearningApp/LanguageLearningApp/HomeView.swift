//
//  HomeView.swift
//  LanguageLearningApp
//
//  Created by Murad Ismayilov on 07.03.23.
//

import SwiftUI

struct HomeView: View {
    @State var selectedTab = 0
    
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var challengesViewModel: ChallengesViewModel
    
    @AppStorage("learningEnabled")
    var learningEnabled: Bool = true
    
    var body: some View {
        TabView(selection: $selectedTab) {
            if learningEnabled {
                LearnView()
                    .tabItem({
                        VStack {
                            Image(systemName: "bookmark")
                            Text("Learn")
                        }
                    })
                    .tag(0)
            }
            
            PracticeView(
                challengeTest: $challengesViewModel.currentChallenge,
                userName: $userManager.profile.name,
                numberOfAnswered:
                        .constant(challengesViewModel.numberOfAnswered)
            )
            .tabItem({
                VStack {
                    Image(systemName: "rectangle.dock")
                    Text("Challenge")
                }
            })
            .tag(1)
            SettingsView()
                .tabItem({
                    VStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                })
                .tag(2)
        }.accentColor(.orange)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(UserManager())
            .environmentObject(ChallengesViewModel())
    }
}
