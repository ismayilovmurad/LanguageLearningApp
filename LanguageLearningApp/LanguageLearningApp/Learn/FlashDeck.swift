//
//  FlashDeck.swift
//  LanguageLearningApp
//
//  Created by Murad Ismayilov on 07.03.23.
//

import Foundation

class FlashDeck: ObservableObject {
    @Published var cards: [FlashCard]
    
    init(from words: [Challenge]) {
        cards = words.map {
            FlashCard(card: $0)
        }
    }
}
