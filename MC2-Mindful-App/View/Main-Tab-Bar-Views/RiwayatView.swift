//
//  RiwayatView.swift
//  dashboard
//
//  Created by Jovinca Claudia on 26/06/22.
//

import SwiftUI

struct RiwayatView: View {
    
    @Environment(\.self) var env
    
    @StateObject var activityModel = ActivityViewModel()
    
    
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
            ForEach (activityModel.userActivityHistoryArray) {item in
                HStack(){
                    
                    // Untuk Daily Affirmations
                    if item.activity?.id == 1 {
                        
                        Text(item.emoji ?? "😐")
                            .font(.largeTitle)
                            .frame(maxWidth: 35, maxHeight: 35)
                            .padding(.leading, 26)
                            
             
                    }
                    // Untuk selain itu

                    else {
                        
                        Image(systemName: item.activity?.image ?? "wind")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 25, maxHeight: 25)
                            .padding(.leading, UIScreen.main.bounds.width*1/14)
                            
                        
                    }

                    
                    VStack(alignment : .leading){
                        Text(item.activity?.title ?? "")
                            .font(.headline)
                            .bold()
                        
                                
                                if item.activity?.id == 1 {

                                    Text(item.journalBody ?? "")
                                        .lineLimit(1)
                                        .font(.footnote)



                                }
                        
                                    // Untuk Scavenger Hunt
                                    else if item.activity?.id == 14{
                                        
                                        Text("Found : \(item.scavengerHuntFound) - Miss : \(item.scavengerHuntMiss)" ?? "")
                                            .lineLimit(1)
                                            .font(.footnote)
                                        
                                    }
                                    
                                    // Untuk Breathings
                                    
                        else {

                                    Text(item.activity?.type ?? "")
                                        .font(.caption)
                                    
                                }
                                
             
                        Text("\((item.timestamp ?? Date()).formatted(date: .complete, time: .omitted)) ")
                            .font(.caption)
                    }.padding([.leading, .trailing], UIScreen.main.bounds.width*1/17)
                    
                }.frame(width : UIScreen.main.bounds.width*11/12, height: 86, alignment: .leading)
                    .foregroundColor(Color.white)
                    .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.2), radius: 5, x: 0, y: 4)
                    .background(Image("BGRecents")
                        .resizable()
                    )
                     
            }
            
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)    
        .padding(.bottom, 25)
        .background(Image("BGDashboard"))
            .onAppear(perform: {
                activityModel.loadUserActivities()
            })
            
       
    }
    
}

struct RiwayatView_Previews: PreviewProvider {
    static var previews: some View {
        RiwayatView()
    }
}
