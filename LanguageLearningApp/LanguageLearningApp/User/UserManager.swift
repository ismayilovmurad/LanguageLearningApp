//
//  UserManager.swift
//  LanguageLearningApp
//
//  Created by Murad Ismayilov on 05.03.23.
//

import Combine
import SwiftUI
import Foundation

// MARK: ObservableObject is a protocol that enables the class to be used in views. It triggers a view update when the instance state changes.
// MARK: To make a class observable, make it conform to ObservableObject. The class becomes a publisher. The protocol defines one objectWillChange property only, which synthesizes automatically. That means you aren’t required to implement it — the compiler will do it for you.
final class UserManager: ObservableObject {
    // MARK: The @Published attribute identifies the state that triggers view reloads.
    // MARK: These properties work in a similar way as a state property does in a view.
    @Published
    var profile: Profile = Profile()
    
    @Published
    var settings: Settings = Settings()
    
    @Published
    var isRegistered: Bool
    
    init() {
        isRegistered = false
    }
    
    init(name: String) {
        isRegistered = name.isEmpty == false
        self.profile.name = name
    }
    
    func setRegistered() {
        isRegistered = profile.name.isEmpty == false
    }
    
    func persistProfile() {
        if settings.rememberUser {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(profile), forKey: "user-profile")
        }
    }
    
    func persistSettings() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(settings), forKey: "user-settings")
    }
    
    func load() {
        if let data = UserDefaults.standard.value(forKey: "user-profile") as? Data {
            if let profile = try? PropertyListDecoder().decode(Profile.self, from: data) {
                self.profile = profile
            }
        }
        setRegistered()
        
        if let data = UserDefaults.standard.value(forKey: "user-settings") as? Data {
            if let settings = try? PropertyListDecoder().decode(Settings.self, from: data) {
                self.settings = settings
            }
        }
    }
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: "user-profile")
    }
    
    func isUserNameValid() -> Bool {
        return profile.name.count >= 3
    }
}
