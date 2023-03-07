//
//  ScoreView.swift
//  LanguageLearningApp
//
//  Created by Murad Ismayilov on 06.03.23.
//

import SwiftUI

struct ScoreView: View {
    @Binding var numberOfQuestions: Int
    @Binding var numberOfAnswered: Int
    
    var body: some View {
        HStack {
            Text("\(numberOfAnswered)/\(numberOfQuestions)")
                .font(.caption)
                .padding(4)
            Spacer()
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    @State static var numberOfAnswered: Int = 0
    
    @State static var numberOfQuestions: Int = 6
    
    static var previews: some View {
        ScoreView(
            numberOfQuestions: $numberOfQuestions,
            numberOfAnswered: $numberOfAnswered
        )
    }
}

// MARK: If you have a property in your view, and you use that property in the view’s body, when the property value changes, the view is unaffected. If you make the property a state property by applying the @State attribute, thanks to some magic that SwiftUI and the compiler do under the hood, the view reacts to property changes, refreshing the relevant portion of the view hierarchy that references that property.

// MARK: With @Binding, you create a property similar to a state property, but with the data stored and owned elsewhere: in a state property or an observable object of an ancestor view.
