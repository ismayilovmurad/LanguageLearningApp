//
//  BorderedViewModifier.swift
//  LanguageLearningApp
//
//  Created by Murad Ismayilov on 05.03.23.
//

import SwiftUI

/// Custom modifier
struct BorderedViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .background(Color.white)
            .overlay(RoundedRectangle(cornerRadius: 8)
                     // MARK: Adds a stroke effect to keep the border only, leaving the content behind visible.
                .stroke(lineWidth: 2)
                .foregroundColor(.accentColor))
            .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 1, y: 2)
    }
}

extension View {
    func bordered() -> some View {
        ModifiedContent(
            content: self,
            modifier: BorderedViewModifier()
        )
    }
}
