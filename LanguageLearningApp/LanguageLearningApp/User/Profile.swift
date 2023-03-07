//
//  Profile.swift
//  LanguageLearningApp
//
//  Created by Murad Ismayilov on 05.03.23.
//

struct Profile : Codable {
    var name: String
    
    /// Initializes a new `Profile` with an empty `name`.
    init() {
        self.name = ""
    }
    
    /// Initializes a new `Profile` with a specified name.
    ///  - Parameters:
    ///     - name Name of the user profile.
    init(named name: String) {
        self.name = name
    }
}
