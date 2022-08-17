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
            
            NavigationLink(destination: MainView()){
                Text("Menuju Beranda")
                    .frame(width: 200, height: 50, alignment: .center)
                    .foregroundColor(Color.accentColor)
                    .background(Color.white)
                    .cornerRadius(10)
            }
            
        }
        .onAppear(perform: {
            
            if activityModel.selectedActivity.id == 14 {
                activityModel.scavengerHunt(activity: activityModel.selectedActivity)
                
            }
            

        })
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .frame(maxHeight: .infinity)
        .background(LinearGradient(
            colors: [Color(red: 179/255, green: 213/255, blue: 255/255), Color(red: 122/255, green: 181/255, blue: 252/255)],
            startPoint: .top,
            endPoint: .bottom
            
        ))
        
        
        
    }
}

struct CongratsView_Previews: PreviewProvider {
    static var previews: some View {
        CongratsView(activityModel: ActivityViewModel(),image: "Meditating", congratsBody: "Anda telah berhasil \nmenyelesaikan aktivitas mindful \nini, mari kita lebih sadar akan minfulness !.")
    }
}
