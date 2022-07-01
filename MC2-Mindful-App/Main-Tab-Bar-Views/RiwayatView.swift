//
//  RiwayatView.swift
//  dashboard
//
//  Created by Jovinca Claudia on 26/06/22.
//

import SwiftUI

struct RiwayatView: View {
    
    var body: some View {
        ScrollView{
            
            Text("Riwayat Aktivitas")
                .font(.title2)
                .bold()
                .foregroundColor(Color(UIColor(named:"darkBrown")!))
                .frame(maxWidth:.infinity, alignment : .leading)
                .padding([.top,.leading] ,30)
            
            
            Text("____")
                .foregroundColor(.accentColor)
                .frame(maxWidth:.infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 15, trailing: 0))
            
            //Apakah perlu dikasih navigation link???
            //Harusnya nanti di sini pakai coredata, cm sementara pake dummy dulu
            ForEach (activities) {item in
                NavigationLink(destination: item.viewDestination) {
                    HStack(){
                        item.image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 25, maxHeight: 25)
                            .padding(.leading, 30)
                        
                        
                        VStack(alignment : .leading){
                            Text(item.title)
                                .font(.headline)
                            
                            Text(item.type)
                                .font(.caption)
                            
                            Text(item.time)
                                .font(.caption)
                        }.padding([.leading, .trailing], 20)
                        
                    }.frame(width : 339, height: 86, alignment: .leading)
                        .foregroundColor(Color.white)
                        .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.2), radius: 5, x: 0, y: 4)
                        .background(Image("BGRecents")
                            .resizable()
                        )
                }.navigationBarTitle("")
                    .navigationBarHidden(true)
                
            }
            
            
        }.background(Image("BGDashboard"))
    }
    
}

struct RiwayatView_Previews: PreviewProvider {
    static var previews: some View {
        RiwayatView()
    }
}
