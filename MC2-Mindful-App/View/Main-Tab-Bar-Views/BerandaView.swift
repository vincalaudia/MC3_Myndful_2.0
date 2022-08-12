//
//  BerandaView.swift
//  dashboard
//
//  Created by Jovinca Claudia on 26/06/22.
//

import SwiftUI

struct BerandaView: View {
    @State private var showSheetView = false
    //    @State var streak = 80
    
    @StateObject var activityModel: ActivityViewModel = .init()
    
    
    // MArk : Environment Values
    @Environment(\.self) var env
    
    
    var body: some View {

            ScrollView(){
                
                VStack{
                    HStack(){
                        Image("myndful")
                            .padding(.trailing, UIScreen.main.bounds.width*6/13)
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
                        Text("Daily Streak Counter : \(activityModel.dailyStreak) ")
                            .font(.headline)
                            .foregroundColor(Color(UIColor(named:"darkBrown")!))
                        Image("flame.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:20)
                        
                    }
                    
                    .frame(width: UIScreen.main.bounds.width*11/12, height: 50, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)
                    
                    Text("Rekomendasi")
                        .font(.headline)
                        .frame(maxWidth:.infinity, alignment: .leading)
                        .padding([.top, .leading],30)
                        .foregroundColor(Color(UIColor(named:"darkBrown")!))
                    
                    //Destinationnya figanti ke reccomendation view nya
                    NavigationLink(destination: RecommendationView()) {
                        Image("LihatRekomendasiMFmu")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth:UIScreen.main.bounds.width*11/12, alignment: .leading)
                            .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)
                    }
                    
                    Text("Aktivitas Terakhir")
                        .foregroundColor(Color(UIColor(named:"darkBrown")!))
                        .font(.headline)
                        .frame(maxWidth:.infinity, alignment: .leading)
                        .padding([.top, .leading],30)
                    
                    
                    ForEach (activityModel.recentUserActivities) {item in
                        
                        
                        
                        if item.activity!.viewDestination == "Mindful_Breathing_Intro" {
                            
                            ActivityCard(item: item.activity!, viewDestination: AnyView(Mindful_Breathing_Intro(activityModel: activityModel)))
                            
                        } else if item.activity!.viewDestination == "JournalingView" {
                            
                            ActivityCard(item: item.activity!, viewDestination: AnyView(JournalingView(activityModel: activityModel)))
                            
                            
                        } else if item.activity?.viewDestination == "ComingSoonView" {
                            
                            ActivityCard(item: item.activity ?? Activity(), viewDestination: AnyView(ComingSoonView(item: item.activity ?? Activity())))
                            
                        }
                        
                        
                        //                        if (item.viewDestination == "Mindful_Breathing_Intro" ){
                        //                            ActivityCard(item: item, viewDestination: AnyView(Mindful_Breathing_Intro(activityModel: activityModel)))
                        //                        } else if (item.viewDestination == "JournalingView" ){
                        //                            ActivityCard(item: item, viewDestination: AnyView(JournalingView(activityModel: activityModel)))
                        //
                        //                        } else if (item.viewDestination == "ComingSoonView" ){
                        //
                        //                            ActivityCard(item: item, viewDestination: AnyView(ComingSoonView(item: item)))
                        //
                        //                        }
                    }
                    
                    
                    
                    
                }.padding(.top, 30)
                
                
            }
            .padding(.bottom, 25)
            .background(Image("BGDashboard"))
            .navigationBarTitle("Back")
            .navigationBarHidden(true)
            .onAppear(perform: {
                
                activityModel.countStreak()
                activityModel.loadRecentActivities()
                print("Huahahaha")
                //                    print(activityModel.recentActivities)
                
            })
       
    }
    
    
    
    @ViewBuilder
    func ActivityCard(item: Activity,viewDestination: AnyView )->some View{
        // Incase if we missed the task
        
        
        
        NavigationLink(destination: viewDestination) {
            HStack(){
                Image(systemName: item.image ?? "wind")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 25, maxHeight: 25)
                    .padding(.leading, UIScreen.main.bounds.width*1/14)
                
                
                VStack(alignment : .leading){
                    Text(item.title ?? "")
                        .font(.headline)
                    
                    Text(item.type ?? "")
                        .font(.caption)
                    
                    Text(item.timeString ?? "")
                        .font(.caption)
                }.padding([.leading, .trailing], UIScreen.main.bounds.width*1/17)
                    .multilineTextAlignment(.leading)
                
            }.frame(width : UIScreen.main.bounds.width*11/12, height: 86, alignment: .leading)
                .foregroundColor(Color.white)
                .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.2), radius: 5, x: 0, y: 4)
                .background(Image("BGRecents")
                    .resizable()
                )
        }.simultaneousGesture(TapGesture().onEnded{
            
            activityModel.selectedActivity = item
            print(activityModel.selectedActivity)
        })
        
        
    }
    
    
}

struct BerandaView_Previews: PreviewProvider {
    static var previews: some View {
        BerandaView()
            .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
    }
}
