//
//  RegisterView.swift
//  LanguageLearningApp
//
//  Created by Murad Ismayilov on 05.03.23.
//

import SwiftUI

struct RegisterView: View {
    // MARK: It’s marked with the @EnvironmentObject attribute because you’re going to inject an instance of it once for the whole app, and retrieve it from the environment anywhere it is needed.
    @EnvironmentObject var userManager: UserManager
    
    @FocusState var nameFieldFocused: Bool
    
    var body: some View {
        
        VStack {
            // MARK: It expands in a way to use all space at its disposal.
            Spacer()
            
            WelcomeMessageView()
            
            // MARK: For the border, you can take advantage of the .textFieldStyle modifier, which applies a style to the text field.
            
            // MARK: SwiftUI provides four different styles: No style, DefaultTextFieldStyle, PlainTextFieldStyle, RoundedBorderTextFieldStyle
            
            // MARK: To handle user input, you use a TextField component or a SecureField if the input is sensitive.
            TextField("Type ur name here pls", text: $userManager.profile.name)
                .focused($nameFieldFocused)
            // MARK: You can’t specify a custom label though: you are limited to the enum cases of the SubmitLabel type: done, go, send, join, route, search, return, next and continue.
                .submitLabel(.done)
            // MARK: Note that it also works if you press the Enter key on a physical keyboard (this is useful when running on macOS)
            
            // MARK: And, not least important, .onSubmit() is part of the View protocol — that means it is available to any view, although it has not much sense in some of them (think of a label, for example).
                .onSubmit(registerUser)
            /// Custom modifier
                .bordered()
            
            HStack {
                // MARK: You use a spacer to push the Text to the right, in a pseudo-right-alignment way.
                Spacer()
                Text("\(userManager.profile.name.count)")
                    .font(.caption)
                    .foregroundColor(userManager.isUserNameValid() ? .green : .red)
                    .padding(.trailing)
            }
            .padding(.bottom)
            
            HStack {
                // MARK: You need the spacer to add flexible spacing to the left, to push the toggle toward the right,  and make it right-aligned.
                Spacer()
                
                Toggle(isOn: $userManager.settings.rememberUser) {
                    Text("Remember me")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                // MARK: You ask the toggle to choose its ideal size. Without it, the toggle will try to expand horizontally, taking all the available space.
                .fixedSize()
            }
            
            // MARK: New to SwiftUI 3.0, you can also use a style thanks to the new .buttonStyle(_:) modifier, which accepts an instance of a type conforming to the PrimitiveButtonStyle protocol.
            
            // MARK: There’s a list of predefined styles with which you can immediately use, such as bordered, borderedProminent, borderless, card, link and plain (note that each platform uses a subset of them, so for example link and card are not available in iOS).
            
            // MARK: And, in case you’re wondering, you can also create your own style — in fact that modifier just needs an object that conforms to PrimitiveButtonStyle, so it works in a similar way to how custom styles are created for text fields, as you briefly saw in the previous chapter.
            
            // MARK: Buttons are more flexible than their UIKit/AppKit counterparts and enable you to make any collection of views into a button.
            Button(action: self.registerUser) {
                // MARK: As previously stated, the label parameter can return multiple child views, but here you’re using a horizontal stack to group views horizontally. If you omit this, the two components will be laid out vertically instead.
                HStack {
                    Image(systemName: "checkmark")
                    // MARK: You make the icon resizable, centered, and with fixed 16×16 size. You need to use .resizable() because otherwise the image would keep its original size, and ignore the size of the view it is contained in.
                        .resizable()
                        .frame(width: 16, height: 16, alignment: .center)
                    Text("OK")
                        .font(.body)
                        .bold()
                }
            }
            .bordered()
            // MARK: When the user types in the TextField, the userManager.profile.name property changes, and that triggers a view update. So, when the button is rerendered, the expression in .disabled() is re-evaluated, and therefore the button state is automatically updated when the input changes.
            .disabled(!userManager.isUserNameValid())
            
            Spacer()
        }
        .padding()
        // MARK: In UIKit, views have a backgroundColor property, which you can use to specify a uniform background color. The SwiftUI counterpart is more polymorphic; the .background modifier accepts any type that conforms to View, which includes Color, Image, Shape, among others.
        .background(WelcomeBackgroundImage())
    }
}

extension RegisterView {
    func registerUser() {
        nameFieldFocused = false
        
        if userManager.settings.rememberUser {
            userManager.persistProfile()
        } else {
            userManager.clear()
        }
        
        userManager.persistSettings()
        userManager.setRegistered()
    }
}

// MARK: Now, if you try to preview this view, it will fail. That’s because, as mentioned above, an instance of UserManager should be injected. You do this in the RegisterView_Previews struct, by passing a user manager to the view via a .environmentObject modifier.
struct RegisterView_Previews: PreviewProvider {
    static let user = UserManager(name: "Murad")
    
    static var previews: some View {
        RegisterView().environmentObject(user)
    }
}
