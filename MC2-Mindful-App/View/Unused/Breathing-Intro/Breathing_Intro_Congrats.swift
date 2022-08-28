//
//  Breathing_Intro_Congrats.swift
//  MC2-Mindful-App
//
//  Created by Billi Umar Daeli on 04/07/22.
//

import SwiftUI

struct Breathing_Intro_Congrats: View {
    var body: some View {
        
        VStack( alignment : .center, spacing :30) {
            
            
            Image("Meditating")
                .resizable()
                .frame(maxWidth: .infinity, alignment: .center)
                .aspectRatio(contentMode: .fit)
            
            
            Text("Anda telah berhasil \nmengendalikan nafas yang \nmenjadi bagian dari kehidupan \nanda hari ini.")
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            NavigationLink(destination: MainView()){
                Text("Menuju Beranda")
                    .frame(width: 200, height: 50, alignment: .center)
                    .foregroundColor(Color("BlueAccent"))
                    .background(Color.white)
                    .cornerRadius(10)
            }.simultaneousGesture(TapGesture().onEnded{
                withAnimation{
                UserDefaults.standard.set(true, forKey: "isBreathingIntroStarted")
                }
            })
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .frame(maxHeight: .infinity)
        .background(LinearGradient(
            colors: [Color(red: 179/255, green: 213/255, blue: 255/255), Color(red: 122/255, green: 181/255, blue: 252/255)],
            startPoint: .top,
            endPoint: .bottom
            
        ))
        
//            ZStack{
//                Image ("breathingImage2")
//                    .resizable()
//                    .scaledToFill()
//                    .edgesIgnoringSafeArea(.all)
//                VStack {
//                    Spacer()
//
//                    Text("Anda telah berhasil \nmengendalikan nafas yang \nmenjadi bagian dari kehidupan \nanda hari ini.")
//                        .fontWeight(.bold)
//                        .font(.system(size: 20))
//                        .foregroundColor(.white)
//                        .multilineTextAlignment(.center)
//
//
//                    NavigationLink(destination: MainView()){
//                        Text("Menuju Beranda")
//                            .frame(width: 200, height: 50, alignment: .center)
//                            .foregroundColor(Color("BlueAccent"))
//                            .background(Color.white)
//                            .cornerRadius(10)
//                    }
//                }.padding(.bottom,250)
//
//
//            }.navigationBarHidden(true)

        }

}

struct Breathing_Intro_Congrats_Previews: PreviewProvider {
    static var previews: some View {
        Breathing_Intro_Congrats()
    }
}
