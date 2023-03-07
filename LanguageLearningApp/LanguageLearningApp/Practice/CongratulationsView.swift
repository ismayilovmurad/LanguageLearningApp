//
//  CongratulationsView.swift
//  LanguageLearningApp
//
//  Created by Murad Ismayilov on 05.03.23.
//

import SwiftUI

struct CongratulationsView: View {
    let avatarSize: CGFloat = 120
    let userName: String
    
    @EnvironmentObject var challengesViewModel: ChallengesViewModel
    
    init(userName: String) {
        self.userName = userName
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Congratulations!")
                .font(.title)
                .foregroundColor(.gray)
            
            ZStack {
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(height: 90)
                        .foregroundColor(.orange.opacity(0.2))
                    Rectangle()
                        .frame(height: 90)
                        .foregroundColor(.orange.opacity(0.4))
                }
                
                Image(systemName: "hand.thumbsup.circle.fill")
                    .resizable()
                    .padding()
                    .frame(width: avatarSize, height: avatarSize)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(avatarSize / 2, antialiased: true)
                    .shadow(radius: 4)
                    .foregroundColor(.accentColor)
                
                VStack() {
                    // MARK: The Spacer is used to make sure that the Text is pushed to the bottom.
                    Spacer()
                    Text(userName)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .shadow(radius: 7)
                }
                .padding()
            }
            .frame(height: 180)
            
            Text("You’re awesome!")
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
            Spacer()
            
            Button(action: {
                self.challengesViewModel.restart()
            }, label: {
                Text("Play Again")
            })
            .padding(.top)
        }
    }
}

struct CongratulationsView_Previews: PreviewProvider {
    static var previews: some View {
        CongratulationsView(userName: "MuradIsmayilov")
            .environmentObject(ChallengesViewModel())
    }
}
