//
//  Mindful_Breathing_Congrats.swift
//  MC2-Mindful-App
//
//  Created by Billi Umar Daeli on 04/07/22.
//

import SwiftUI

struct Mindful_Breathing_Congrats: View {
    var body: some View {
        
        VStack( alignment : .center, spacing :30) {
            
            
            Image ("Meditating")
                .resizable()
                .frame(maxWidth: .infinity, alignment: .center)
                .aspectRatio(contentMode: .fit)
            
            
            Text("Anda telah berhasil \nmengendalikan nafas yang \nmenjadi bagian dari kehidupan \nanda hari ini.")
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            NavigationLink(destination: MainView()){
                Text("Kembali")
                    .frame(width: 200, height: 50, alignment: .center)
                    .foregroundColor(Color.accentColor)
                    .background(Color.white)
                    .cornerRadius(10)
            }
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .frame(maxHeight: .infinity)
        .background(LinearGradient(
            colors: [Color(red: 180/255, green: 194/255, blue: 253/255), Color(red: 122/255, green: 181/255, blue: 252/255)],
            startPoint: .top,
            endPoint: .bottom
            
        ))
        
        
    }
}

struct Mindful_Breathing_Congrats_Previews: PreviewProvider {
    static var previews: some View {
        Mindful_Breathing_Congrats()
    }
}
