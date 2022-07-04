//
//  JournalingView.swift
//  dashboard
//
//  Created by Jovinca Claudia on 01/07/22.
//

import SwiftUI
import Foundation


struct JournalingView: View {
    @State var pilihan : Image
    
    
    var body: some View {
        //INI CONTOH AJA BUAT JOURNALLING VIEW
        ScrollView(){
            VStack(spacing : 10){
                Text("Daily Affirmation")
                    .font(.title)
                    .bold()
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .padding(.leading, 30)
                
                Text(getDate())
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .padding(.leading, 30)
                
                Text("____")
                    .foregroundColor(.accentColor)
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 15, trailing: 0))
                
                Text("Gimana keadaanmu hari ini ?")
                    .font(.title2)
                    .bold()
                
                
                VStack(spacing : 20){
                    Spacer()
                    HStack(spacing : 20){
                        Button(action: {
                            //act
                        }, label :{
                            VStack(spacing : 5){
                                Text("😭")
                                    .font(.title)
                                Text("Sedih")
                                    .font(.title3)
                                    .bold()
                            }.frame(width: 110, height: 110, alignment: .center)
                                .background(Color.white)
                                .cornerRadius(9)
                                .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)
                        })
                        
                        Button(action: {
                            //act
                        }, label :{
                            VStack(spacing : 5){
                                Text("☺️")
                                    .font(.title)
                                Text("Senang")
                                    .font(.title3)
                                    .bold()
                            }.frame(width: 110, height: 110, alignment: .center)
                                .background(Color.white)
                                .cornerRadius(9)
                                .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)
                        })
                        
                    }
                    HStack(spacing : 20){
                        Button(action: {
                            //act
                        }, label :{
                            VStack(spacing : 5){
                                Text("😡")
                                    .font(.title)
                                Text("Marah")
                                    .font(.title3)
                                    .bold()
                            }.frame(width: 110, height: 110, alignment: .center)
                                .background(Color.white)
                                .cornerRadius(9)
                            .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)})
                        
                        Button(action: {
                            //act
                        }, label :{
                            VStack(spacing : 5){
                                Text("😐")
                                    .font(.title)
                                Text("Normal")
                                    .font(.title3)
                                    .bold()
                            }.frame(width: 110, height: 110, alignment: .center)
                                .background(Color.white)
                                .cornerRadius(9)
                            .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)})
                    }
                    
                    HStack(spacing : 0){
                        Text("•")
                            .foregroundColor(.accentColor)
                            .font(.title)
                        Text("•")
                            .foregroundColor(.gray)
                            .font(.title)
                    }
                    
                    
                }
                NavigationLink(destination:MindfulView()){
                    VStack{
                        Text("Lanjut")
                            .foregroundColor(Color.white)
                            .bold()
                    }.frame(width: UIScreen.main.bounds.width-100, height: 50, alignment: .center)
                        .background(Color.accentColor)
                        .cornerRadius(25)
                        .padding()
                }
                
                
            }.navigationBarTitle("", displayMode: .inline)
                .padding(.top,30)
            
        }.background(Image("BGDashboard"))
    }
    
    func getDate() -> String {
        let date = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM y"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
