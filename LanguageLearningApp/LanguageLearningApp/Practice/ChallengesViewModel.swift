//
//  ChallengesViewModel.swift
//  LanguageLearningApp
//
//  Created by Murad Ismayilov on 05.03.23.
//

import SwiftUI
import Combine

struct QuestionsPerSessionKey: EnvironmentKey {
    static var defaultValue: Int = 5
}

extension EnvironmentValues {
    var questionsPerSession: Int {
        get { self[QuestionsPerSessionKey.self] }
        set { self[QuestionsPerSessionKey.self] = newValue }
    }
}

struct Challenge {
    let question: String
    let pronunciation: String
    let answer: String
    var completed: Bool = false
    var succeeded: Bool = false
}

extension Challenge: Hashable {
    func hash(into hasher: inout Hasher) {
        question.hash(into: &hasher)
    }
}

struct ChallengeTest {
    let challenge: Challenge
    let answers: [String]
    func isAnswerCorrect(_ answer: String) -> Bool {
        return challenge.answer == answer
    }
}

class ChallengesViewModel: ObservableObject {
    static let challenges: [Challenge] = [
        Challenge(question: "Si", pronunciation: "Si", answer: "Yes"),
        Challenge(question: "No", pronunciation: "No", answer: "No"),
        Challenge(question: "Por favor", pronunciation: "Por favor", answer: "Please"),
        Challenge(question: "Hola", pronunciation: "Hola", answer: "Hello"),
        Challenge(question: "Disculpe", pronunciation: "Disculpe", answer: "Excuse me"),
        Challenge(question: "Gracias", pronunciation: "Gracias", answer: "Thank you"),
        Challenge(question: "Lo siento", pronunciation: "Lo siento", answer: "Sorry")
    ]
    
    var allAnswers: [String] { return Self.challenges.map { $0.answer }}
    var correctAnswers: [Challenge] = []
    var wrongAnswers: [Challenge] = []
    @AppStorage("numberOfQuestions")
    private(set) var numberOfQuestions = 6
    
    var numberOfAnswered: Int { return correctAnswers.count }
    @Published var currentChallenge: ChallengeTest?
    
    
    init() {
        generateRandomChallenge()
    }
    
    func getRandomAnswers(count: Int, including includedAnswer: String) -> [String] {
        let answers = allAnswers
        
        // If there are not enough answers, return them all
        guard count < answers.count else {
            return answers.shuffled()
        }
        
        var randomAnswers = Set<String>()
        randomAnswers.insert(includedAnswer)
        while randomAnswers.count < count {
            guard let randomAnswer = answers.randomElement() else { continue }
            randomAnswers.insert(randomAnswer)
        }
        
        return Array(randomAnswers).shuffled()
    }
    
    func generateRandomChallenge() {
        if correctAnswers.count < numberOfQuestions {
            currentChallenge = getRandomChallenge()
        } else {
            currentChallenge = nil
        }
    }
    
    func restart() {
        self.correctAnswers = []
        self.wrongAnswers = []
        generateRandomChallenge()
    }
    
    private func getRandomChallenge() -> ChallengeTest? {
        return getRandomChallenges(count: 1).first
    }
    
    private func getRandomChallenges(count: Int) -> [ChallengeTest] {
        let challenges = Self.challenges.filter { $0.completed == false }
        var randomChallenges: Set<Challenge>
        
        // If there are not enough challenges, return them all
        
        if challenges.count < count {
            randomChallenges = Set(challenges)
        } else {
            randomChallenges = Set()
            while randomChallenges.count < count {
                guard let randomChallenge = challenges.randomElement() else { continue }
                randomChallenges.insert(randomChallenge)
            }
        }
        
        let tests = randomChallenges.map({
            ChallengeTest(
                challenge: $0,
                answers: getRandomAnswers(count: 3, including: $0.answer)
            )
        })
        
        return tests.shuffled()
    }
    
    func saveCorrectAnswer(for challenge: Challenge) {
        correctAnswers.append(challenge)
    }
    
    func saveWrongAnswer(for challenge: Challenge) {
        wrongAnswers.append(challenge)
    }
}
