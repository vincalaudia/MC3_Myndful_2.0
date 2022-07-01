//
//  MindfulView.swift
//  dashboard
//
//  Created by Jovinca Claudia on 26/06/22.
//

import SwiftUI

struct MindfulView: View {
    
    var body: some View {
        ScrollView{
            
            Text("Aktivitas Mindfulness")
                .font(.title2)
                .bold()
                .foregroundColor(Color(UIColor(named:"darkBrown")!))
                .frame(maxWidth:.infinity, alignment : .leading)
                .padding([.top,.leading] ,30)
            
            
            Text("____")
                .foregroundColor(.accentColor)
                .frame(maxWidth:.infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 15, trailing: 0))
            
            
            ForEach(activities){item in
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
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
    
}


struct MindfulView_Previews: PreviewProvider {
    static var previews: some View {
        MindfulView()
    }
}
