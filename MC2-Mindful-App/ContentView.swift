//
//  ContentView.swift
//  MC2-Mindful-App
//
//  Created by Angel Ria Purnamasari on 17/06/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var activityModel = ActivityViewModel()
    

    // MArk : Environment Values
    @Environment(\.self) var env
    
    @AppStorage("isStart") private var isStart: Bool = false
    @AppStorage("preload") private var preload: Bool = false
    

    static let sample = OnboardingDataModel.data
    var body: some View {
   
        if isStart {
            
            MainView()
            
        } else {

            OnboardingViewPure(data: ContentView.sample, doneFunction: {
                
                withAnimation{
                UserDefaults.standard.set(true, forKey: "isStart")
                }
                
            }).onAppear(perform: {
                UserDefaults.standard.set(true, forKey: "preload")
                activityModel.loadFromLocalFile()
                
            })
        }

        
    }



}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
