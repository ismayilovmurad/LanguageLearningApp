//
//  SettingsView.swift
//  LanguageLearningApp
//
//  Created by Murad Ismayilov on 07.03.23.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("numberOfQuestions") var numberOfQuestions = 6
    
    @AppStorage("learningEnabled")
    var learningEnabled: Bool = true
    
    @AppStorage("dailyReminderEnabled")
    var dailyReminderEnabled = false
    
    @State var dailyReminderTime = Date(timeIntervalSince1970: 0)

    
    @AppStorage("dailyReminderTime")
    var dailyReminderTimeShadow: Double = 0
    
    @AppStorage("cardBackgroundColor")
    var cardBackgroundColorInt: Int = 0xFF0000FF
    
    @State var cardBackgroundColor: Color = .red
    
    @AppStorage("appearance") var appearance: Appearance = .automatic
    
    var body: some View {
        List{
            Text("Settings")
                .font(.largeTitle)
                .padding(.bottom, 8)
            
            Section(header: Text("Appearance")) {
                VStack(alignment: .leading) {
                    Picker("", selection: $appearance) {
                        ForEach(Appearance.allCases) { appearance in
                          Text(appearance.name).tag(appearance)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    ColorPicker(
                      "Card Background Color",
                      selection: $cardBackgroundColor
                    )
                }
            }
            
            Section(header: Text("Game")) {
                VStack(alignment: .leading) {
                    Stepper(
                        "Number of Questions: \(numberOfQuestions)",
                        value: $numberOfQuestions,
                        in: 3 ... 20
                    )
                    Text("Any change will affect the next game")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                Toggle("Learning Enabled", isOn: $learningEnabled)
            }
            
            Section(header: Text("Notifications")) {
                HStack {
                    Toggle("Daily Reminder", isOn: $dailyReminderEnabled).onChange(of: dailyReminderEnabled, perform: {_ in configureNotification()})
                    DatePicker(
                        "",
                        selection: $dailyReminderTime,
                        displayedComponents: .hourAndMinute
                    )
                    .disabled(dailyReminderEnabled == false)
                    // MARK: Note that .onChange(of:perform:) is part of the View protocol, so you can use it on any view.
                    .onChange(of: dailyReminderTime, perform: { newValue in
                        // This copies the number of seconds since the midnight of Jan 1, 1970, as a double value, into the shadow property for the App Storage.
                        dailyReminderTimeShadow = newValue.timeIntervalSince1970
                        configureNotification()})
                    .onAppear {
                        // With it, every time the Section is displayed, the value stored in the shadow property is converted to a date and stored into dailyReminderTime.
                      dailyReminderTime = Date(timeIntervalSince1970: dailyReminderTimeShadow)
                        
                        cardBackgroundColor = Color(rgba: cardBackgroundColorInt)
                    }
                }
            }
        }
        .onChange(of: cardBackgroundColor, perform: { newValue in
          cardBackgroundColorInt = newValue.asRgba
        })
    }
    
    func configureNotification() {
        if dailyReminderEnabled {
            LocalNotifications.shared.createReminder(
                time: dailyReminderTime)
        } else {
            LocalNotifications.shared.deleteReminder()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
