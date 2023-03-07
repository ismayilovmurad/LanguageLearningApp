//
//  Comments.swift
//  LanguageLearningApp
//
//  Created by Murad Ismayilov on 05.03.23.
//

// MARK: A modifier is a view instance method that creates a copy of the view, does something to the view copy (such as changing the font size or the color), and returns the modified view.

// MARK: New to SwiftUI 3.0, Text now supports a subset of markdown, which is a markup language for creating formatted text. Usage of markdown is possible because of the additions made to the new AttributedString type introduced in iOS 15 and macOS 12, which is the Swift “native” counterpart of the NSAttributedString type that you’ve probably used in the past. To make it clear, AttributedString is to NSAttributedString as String is to NSString. Bold: **Text**, Italic: *Text* or _Text_, Strikethrough: ~~Text~~. Although in this simple example no method has a distinctive advantage over the other, the real power of markdown becomes perceivable when you need to apply formatting to substrings of a text.

// MARK: The reason for preferring the custom modifier over the custom text field style is that you can apply the same modifier to any view, including buttons.

// MARK: The SwiftUI button is far more flexible than its UIKit/AppKit counterpart. You aren’t limited to using a text label alone or in combination with an image for its content. Instead, you can use anything for your button that’s a View.

// MARK: Adding a button is as easy as declaring it: you simply specify a label and attach a handler. Its signature is:
// MARK: init(action: @escaping () -> Void, @ViewBuilder label: () -> Label)
// MARK: The @ViewBuilder attribute applied to the label parameter is used to let the closure return multiple child views.
// MARK: The tap handler parameter is referred to as action instead of tap or tapAction — and if you read the documentation, it’s called a trigger handler, not tap handler. That’s because in iOS it’s a tap, but in macOS it can be a mouse click, in watchOS a digital crown press, and so forth.
// MARK: The button initializer takes the trigger handler as the first parameter, instead of the last, breaking the common practice in Swift of giving action closures the last position. This means that you can’t use the single trailing closure syntax. The reason is very likely because that pattern changes in SwiftUI, where the last parameter is always the view declaration — which, by the way, can use the same trailing closure syntax. However you can always use the multiple trailing closure syntax, new to Swift 5.3.

// MARK: You also have the option of changing the layout priority using the .layoutPriority modifier. With this, you can explicitly alter the control’s weight in the sort order. It takes a Double value, which can be either positive or negative. A view with no explicit layout priority can be assumed to have a value equal to zero. Interestingly, .layoutPriority applied to children views doesn’t affect their Z-order, so it’s not possible to alter the order in which they are defined in the ZStack’s body.

// MARK: So it’s better to load views on demand, as needed, starting with the bare minimum to keep the screen crowded, and keep loading other views as the user demands for more. This is what lazy stacks do. And unlike their energetic counterparts, the lazy ones come in two flavors only, horizontal and vertical, respectively LazyHStack and LazyVStack.

// MARK: Although you can add views to stack up manually, lazy stacks really shine when you iterate over a data source, making the lazy stack an efficient data driven stack component.

// MARK: SwiftUI has many positive aspects — among them is that it’s primarily: Declarative: You don’t implement the user interface — you declare it. Functional: Given the same state, the rendered UI is always the same. In other words, the UI is a function of the state. Reactive: When the state changes, SwiftUI automatically updates the UI.


// MARK: SwiftUI makes this process simpler. It uses a declarative approach and leverages the reactive nature of state properties to automatically update the user interface when the state property changes. In SwiftUI, components don’t own the data — instead, they hold a reference to data that’s stored elsewhere. This enables SwiftUI to automatically update the user interface when the model changes. Since it knows which components reference the model, it can figure out which portion of the user interface to update when the model changes. To achieve this, it uses binding, which is a sophisticated way to handle references.

// MARK: The single source of truth is a way to say that data should be owned only by a single entity, and every other entity should access that same data — not a copy of it. In SwiftUI, you can think of the single source of truth as a reference type with attached behavior.

// MARK: Using environmentObject(_:), you inject an object into the environment. Using @EnvironmentObject, you pull an object (actually a reference to an object) out of the environment and store it in a property.
// MARK: Once you inject an object into the environment, it’s accessible to the view and its subviews, but it’s not accessible from the view’s parent and above.

// MARK: If you have ever used UserDefaults, you know you can’t store any arbitrary type — you are restricted to:
// Basic data types: Int,  Double, String,  Bool
// Composite types: Data, URL
// Any type adopting RawRepresentable
// MARK: To store types that are not explicitly handled by AppStorage, you have two choices:
// Make the type RawRepresentable
// Use a shadow property

// MARK: Alongside AppStorage, SwiftUI also offers a @SceneStorage attribute that works the same as @AppStorage, except that the persisted storage is limited to a scene instead of being app-wide. This is very useful if you have a multi-scene app.
