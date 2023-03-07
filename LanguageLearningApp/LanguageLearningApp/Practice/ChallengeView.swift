//
//  ChallengeView.swift
//  LanguageLearningApp
//
//  Created by Murad Ismayilov on 05.03.23.
//

import SwiftUI

struct ChallengeView: View {
    let challengeTest: ChallengeTest
    
    // MARK: A property marked as @State has, in reality, a State<Value> type, which is a value type. When you pass it to a method, it actually passes a copy.
    // MARK: In SwiftUI terms, by copying a @State property, you end up having multiple sources of truth — or, if it helps you better understand the concept, multiple sources of untruth. Every state property has its relative truth, which, at some point, won’t match the other sources’ truth.
    // MARK: State is a property wrapper type that can read and write a value managed by SwiftUI.
    // MARK: SwiftUI manages the storage of any property you declare as a state. When the state value changes, the view invalidates its appearance and recomputes the body. Use the state as the single source of truth for a given view.
    // MARK: When the wrapped value changes, SwiftUI re-renders the portion of the view that uses that value.
    // var _numberOfAnswered = State<Int>(initialValue: 0)
    // MARK: What’s the relationship between State<Value>, the @State attribute and the $ operator?
    // MARK: The property declared with the @State attribute is a property wrapper, and the compiler generates an actual implementation of State<Int> type, prefixing the name by an underscore, _numberOfAnswered. So they're basically the same thing. You can prove this by noting that you can still use _numberOfAnswered.wrappedValue property in body.
    // MARK: You use @State to create a property with data owned by the view where you declare it. When the property value changes, the UI that uses this property automatically re-renders.
    @State var showAnswers = false
    @Binding var numberOfAnswered: Int
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @AppStorage("numberOfQuestions") var numberOfQuestions = 6
    
    @ViewBuilder
    var body: some View {
        if verticalSizeClass == .compact {
            VStack {
                HStack {
                    Button(action: {
                        showAnswers = !showAnswers
                    }) {
                        QuestionView(
                            question: challengeTest.challenge.question)
                    }
                    if showAnswers {
                        Divider()
                        ChoicesView(challengeTest: challengeTest)
                    }
                }
                ScoreView(
                    numberOfQuestions: $numberOfQuestions,
                    numberOfAnswered: $numberOfAnswered
                )
            }
        } else {
            VStack {
                Button(action: {
                    showAnswers = !showAnswers
                }) {
                    QuestionView(
                        question: challengeTest.challenge.question)
                    .frame(height: 300)
                }
                ScoreView(
                    numberOfQuestions: $numberOfQuestions,
                    numberOfAnswered: $numberOfAnswered
                )
                if showAnswers {
                    Divider()
                    ChoicesView(challengeTest: challengeTest)
                        .frame(height: 300)
                        .padding()
                }
            }
        }
    }
}


struct ChallengeView_Previews: PreviewProvider {
    @State static var numberOfAnswered: Int = 0
    static let challengeTest = ChallengeTest(
        challenge: Challenge(
            question: "Por favor",
            pronunciation: "Por favor",
            answer: "Please"
        ),
        answers: ["Thank you", "Hello", "Goodbye"]
    )
    
    static var previews: some View {
        return ChallengeView(
            challengeTest: challengeTest,
            numberOfAnswered: $numberOfAnswered
        )
    }
}
