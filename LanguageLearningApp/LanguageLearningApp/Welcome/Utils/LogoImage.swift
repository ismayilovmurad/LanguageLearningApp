//
//  LogoImage.swift
//  LanguageLearningApp
//
//  Created by Murad Ismayilov on 05.03.23.
//

import SwiftUI

struct LogoImage: View {
    var body: some View {
        Image(systemName: "rhombus")
            .resizable()
            .frame(width: 30, height: 30)
            .overlay(Circle().stroke(Color.accentColor, lineWidth: 1))
            .background(Color(white: 0.9))
            .clipShape(Circle())
            .foregroundColor(.orange)
    }
}

struct LogoImage_Previews: PreviewProvider {
    static var previews: some View {
        LogoImage()
    }
}
