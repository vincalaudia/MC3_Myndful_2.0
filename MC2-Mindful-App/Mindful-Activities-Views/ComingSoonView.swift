//
//  ComingSoonView.swift
//  MC2-Mindful-App
//
//  Created by Jovinca Claudia on 03/07/22.
//

import SwiftUI

struct ComingSoonView: View {
    
    let item : Int
    var body: some View {
        VStack(spacing : 20){
            ZStack{
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color(red: 180/255, green: 194/255, blue: 253/255), Color(red: 122/255, green: 181/255, blue: 252/255)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 160, height: 160)
                    

                activities[item].image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.white)
                    .frame(maxWidth:60, maxHeight: 60, alignment: .center)
                    .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 7, x: 0, y: 0)
            }.padding(.bottom, 25)
                .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 7, x: 0, y: 0)
            
            Text(activities[item].title)
                .font(.title3)
            
            Text("Akan Segera Hadir!")
                .bold()
                .font(.title)
            
            Text("Untuk sementara, bimbingan aktivitas ini belum tersedia. Kembali ke halaman sebelumnya untuk memilih aktivitas lain! ")
                .padding([.leading, .trailing], 50)
                .multilineTextAlignment(.center)
                .font(.caption)
            
            NavigationLink(destination: MainView()){
                Text("Kembali")
                    .frame(width: 200, height: 50, alignment: .center)
                    .background(Color.accentColor)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
            } .padding(.top, 40)
            
        }.frame(width: 330, height: 550, alignment: .center)
            .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 7, x: 0, y: 0)
            .cornerRadius(25)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct ComingSoonView_Previews: PreviewProvider {
    static var previews: some View {
        ComingSoonView(item: 2)
    }
}
