//
//  PracticeView.swift
//  LanguageLearningApp
//
//  Created by Murad Ismayilov on 05.03.23.
//

import SwiftUI

/// Displays the practice view with question and potential answers (choices).
struct PracticeView: View {
    @Binding var challengeTest: ChallengeTest?
    @Binding var userName: String
    @Binding var numberOfAnswered: Int
    
    @ViewBuilder
    var body: some View {
        if challengeTest != nil {
            ChallengeView(challengeTest: challengeTest!, numberOfAnswered: $numberOfAnswered)
        } else {
            CongratulationsView(userName: userName)
        }
    }
}

struct PracticeView_Previews: PreviewProvider {
    @State static var numberOfAnswered: Int = 0
    static let challengeTest = ChallengeTest(
        challenge: Challenge(question: "Lo siento", pronunciation: "Lo siento", answer: "Please"),
        answers: ["Thank you", "Hello", "Goodbye"]
    )
    
    static var previews: some View {
        return PracticeView(
            challengeTest: .constant(challengeTest),
            userName: .constant("MuradIsmayilov"),
            numberOfAnswered: $numberOfAnswered
        )
    }
}
