//
//  Breathing-Intro.swift
//  MC2-Mindful-App
//
//  Created by Billi Umar Daeli on 04/07/22.
//

import SwiftUI

struct Breathing_Intro_Screen: View {
    var body: some View {
        
        NavigationView {
            ZStack{
                Image ("breathingImage1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    Spacer ()
                    
                    Text("Tahukah anda \nPernafasan yang di sadari \ndapat membuat diri anda lebih tenang?")
                        .fontWeight(.bold)
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        
                        
                    
                    HStack {
                        NavigationLink(destination: TimerBreathing()) {
                            Text("Mulai Sesi").frame(height: 50).padding([.leading, .trailing], 80)
                        }
                        
//                        NavigationLink(destination: TimerBreathing(), label: Text("Mulai Sesi")
//                            .frame(height: 50).padding([.leading, .trailing], 80)
//                        )
                    }.background(Color.white)
                        .cornerRadius(30)
                    
                    
                }.padding(.bottom, 200)
                
            }
        }
        
        
    }
}

struct Breathing_Intro_Screen_Previews: PreviewProvider {
    static var previews: some View {
        Breathing_Intro_Screen()
    }
}
