//
//  BerandaView.swift
//  dashboard
//
//  Created by Jovinca Claudia on 26/06/22.
//

import SwiftUI

struct BerandaView: View {
    @State private var showSheetView = false
    @State var streak = 80
    
    var body: some View {
            ScrollView(){
                
                VStack{
                    HStack(){
                        Image("myndful")
                            .padding(.trailing, UIScreen.main.bounds.width/2-30)
                        Button {
                            showSheetView = true
                        }
                    label: {
                        Image("Notification")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22)
                            .foregroundColor(Color(UIColor(named:"darkBrown")!))
                        
                    }.sheet(isPresented: $showSheetView){
                        SheetView()
                    }
                    }
                    
                    Text("____")
                        .foregroundColor(.accentColor)
                        .frame(maxWidth:.infinity, alignment: .leading)
                        .padding(.leading,30)
                    
                    HStack{
                    Text("Daily Streak Counter : \(streak) ")
                        .font(.headline)
                        .foregroundColor(Color(UIColor(named:"darkBrown")!))
                    Image("flame.circle.fill@128x")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:20)

                    }.frame(width: 339, height: 50, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)
                    
                    Text("Rekomendasi")
                        .font(.headline)
                        .frame(maxWidth:.infinity, alignment: .leading)
                        .padding([.top, .leading],30)
                        .foregroundColor(Color(UIColor(named:"darkBrown")!))
                    
                    //Destinationnya figanti ke reccomendation view nya
                    NavigationLink(destination: Text("Destination_1")) {
                        Image("LihatRekomendasiMFmu")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth:339, alignment: .leading)
                            .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)
                    }
                    
                    Text("Aktivitas Terakhir")
                        .foregroundColor(Color(UIColor(named:"darkBrown")!))
                        .font(.headline)
                        .frame(maxWidth:.infinity, alignment: .leading)
                        .padding([.top, .leading],30)
                    
                    //Aktivitas terakhir pake core data kan(?)
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
                    }
                }
                    
                }.padding(.top, 30)
                
                
            }.background(Image("BGDashboard"))
                .navigationBarTitle("Back")
                .navigationBarHidden(true)
        }
    
}

struct BerandaView_Previews: PreviewProvider {
    static var previews: some View {
        BerandaView()
            .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
    }
}
