//
//  Mindful_Breathing_Congrats.swift
//  MC2-Mindful-App
//
//  Created by Billi Umar Daeli on 04/07/22.
//

import SwiftUI

struct CongratsView: View {

    @ObservedObject var activityModel: ActivityViewModel
//    let image: String = "Meditating"
//    let congratsBody: String = "Anda telah berhasil \nmenyelesaikan aktivitas mindful \nini, mari kita lebih sadar akan minfulness !."
    let image: String
    let congratsBody: String
    
    
    var body: some View {
        
        VStack( alignment : .center, spacing :30) {
            
            
            Image(image)
                .resizable()
                .frame(maxWidth: .infinity, alignment: .center)
                .aspectRatio(contentMode: .fit)
            
            
            Text(congratsBody)
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            NavigationLink(destination: MainView(selection: 1)){
                Text("Menuju Beranda")
                    .frame(width: 200, height: 50, alignment: .center)
                    .foregroundColor(Color("BlueAccent"))
                    .background(Color.white)
                    .cornerRadius(10)
//                    .navigationBarTitle("")
//                    .navigationBarHidden(true)
//                    .navigationBarBackButtonHidden(true)
            }    .isDetailLink(false)       .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            
        }
        .onAppear(perform: {
            
            if activityModel.selectedActivity.viewDestination == "ScavengerHunt" {
                activityModel.scavengerHunt(activity: activityModel.selectedActivity)
                
            }
            
            else if activityModel.selectedActivity.viewDestination == "HearthBeatView"
            {
                activityModel.heartbeat()
            }

        })
        .frame(maxHeight: .infinity)
        .background(LinearGradient(
            colors: [Color(red: 179/255, green: 213/255, blue: 255/255), Color(red: 122/255, green: 181/255, blue: 252/255)],
            startPoint: .top,
            endPoint: .bottom
            
        ))
//        .navigationBarTitle("")
//        .navigationBarHidden(true)
//        .navigationBarBackButtonHidden(true)
//        
        
        
    }
}

struct CongratsView_Previews: PreviewProvider {
    static var previews: some View {
        CongratsView(activityModel: ActivityViewModel(),image: "Meditating", congratsBody: "Anda telah berhasil \nmenyelesaikan aktivitas mindful \nini, mari kita lebih sadar akan minfulness !.")
    }
}
