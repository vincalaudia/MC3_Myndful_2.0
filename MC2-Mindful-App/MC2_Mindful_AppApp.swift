//
//  MC2_Mindful_AppApp.swift
//  MC2-Mindful-App
//
//  Created by Angel Ria Purnamasari on 17/06/22.
//

import SwiftUI

@main
struct MC2_Mindful_AppApp: App {
    let persistenceController = PersistenceController.shared
//misalnya
    static let sample = OnboardingDataModel.data
    var body: some Scene {
        WindowGroup {
//            OnboardingViewPure(data: MC2_Mindful_AppApp.sample, doneFunction: { print("done") })
//            OnboardingViewPure(data: MC2_Mindful_AppApp.sample)
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
