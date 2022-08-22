//
//  MindfulView.swift
//  dashboard
//
//  Created by Jovinca Claudia on 26/06/22.
//

import SwiftUI

import WrappingHStack
import SwiftUIBottomSheet


struct MindfulView: View {

    // MArk : Environment Values
    @Environment(\.self) var env
    
    @StateObject var activityModel: ActivityViewModel = .init()
    @State private var showFilterSheetActivity: Bool = false
    

    
    var body: some View {
        
        VStack{
            
            
            HStack(){
                
                
            Text("Aktivitas Kesadaran")
                .font(.title2)
                .bold()
                .foregroundColor(Color(UIColor(named:"darkBrown")!))
                .frame(maxWidth:.infinity, alignment : .leading)
                
    //                .padding([.top,.leading] ,30)
            
                
                Button {
                    showFilterSheetActivity = true
                }
            label: {
                Image(systemName:"slider.horizontal.3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22)
                    .foregroundColor(Color(UIColor(named:"darkBrown")!))
                
            }
                
                //            Text("____")
                //                .foregroundColor(.accentColor)
                //                .frame(maxWidth:.infinity, alignment: .leading)
                //                .padding(EdgeInsets(top: 0, leading: 30, bottom: 15, trailing: 0))
                
            }
            
            .padding(.horizontal,20)
            .padding(.top,20)
            .padding(.bottom,5)
            
            
                        Text("____")
                            .foregroundColor(.accentColor)
                            .frame(maxWidth:.infinity, alignment: .leading)
                            .padding(EdgeInsets(top: 0, leading: 30, bottom: 15, trailing: 0))
       
            
            
            
        ScrollView{
            
//            Text("Aktivitas Mindfulness")
//                .font(.title2)
//                .bold()
//                .foregroundColor(Color(UIColor(named:"darkBrown")!))
//                .frame(maxWidth:.infinity, alignment : .leading)
//                .padding([.top,.leading] ,30)
//
//
//            Text("____")
//                .foregroundColor(.accentColor)
//                .frame(maxWidth:.infinity, alignment: .leading)
//                .padding(EdgeInsets(top: 0, leading: 30, bottom: 15, trailing: 0))
//
            
            
            ForEach (activityModel.activityArray) {item in
                
                
//                NavigationLink(destination: IntroActivityView(activityModel: activityModel)) {
//                HStack(){
//                    Image(systemName: item.image ?? "wind")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(maxWidth: 25, maxHeight: 25)
//                        .padding(.leading, UIScreen.main.bounds.width*1/14)
//
//
//                    VStack(alignment : .leading){
//                        Text(item.title ?? "")
//                            .font(.headline)
//
//                        Text(item.type ?? "")
//                            .font(.caption)
//
//                        Text(item.timeString ?? "")
//                            .font(.caption)
//                    }.padding([.leading, .trailing], UIScreen.main.bounds.width*1/17)
//                        .multilineTextAlignment(.leading)
//
//                }.frame(width : UIScreen.main.bounds.width*11/12, height: 86, alignment: .leading)
//                    .foregroundColor(Color.white)
//                    .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.2), radius: 5, x: 0, y: 4)
//                    .background(Image("BGRecents")
//                        .resizable()
//                    )
//
//            }.simultaneousGesture(TapGesture().onEnded{
//                activityModel.selectedActivity = item
//                print(activityModel.selectedActivity)
//            })
//
//                if (item.viewDestination == "ComingSoonView" ){
//
//                    ActivityCard(item: item, viewDestination: AnyView(ComingSoonView(item: item)))
//
//                }
//
//                if (item.id != 15 &&  item.id != 16) {

//                    ActivityCard(item: item, viewDestination: AnyView(ComingSoonView(item: item)))

                    NavigationLink(destination: IntroActivityView(activityModel: activityModel)) {
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
            
            
//        }
            
//            ForEach (activityModel.activityArray) {item in
//
//                if (item.viewDestination == "Mindful_Breathing_Intro" ){
//                    ActivityCard(item: item, viewDestination: AnyView(Mindful_Breathing_Intro(activityModel: activityModel)))
            
            
            
//                } else if (item.viewDestination == "JournalingView" ){
//                    ActivityCard(item: item, viewDestination: AnyView(JournalingView(activityModel: activityModel)))
//
//                }
//
//                else if (item.viewDestination == "ScavengerHunt" ){
//
//                    ActivityCard(item: item, viewDestination: AnyView(ScavengerHunt(activityModel: activityModel)))
//
//                }
//
//                else if (item.viewDestination == "ComingSoonView" ){
//
//                    ActivityCard(item: item, viewDestination: AnyView(ComingSoonView(item: item)))
//
//                }
//        }
            
        }
        .padding(.bottom, 25)
    
//            .navigationBarTitle("Back")
//        .navigationBarTitle("")
//            .navigationBarHidden(true)
//            .navigationBarBackButtonHidden(true)
            .onAppear(perform: {
                activityModel.loadActivities()
            })
          
        
    }  .bottomSheet(
        isPresented: $showFilterSheetActivity){
        VStack(alignment: .leading) {
            HStack(alignment: .top){
                Text("Filter").font(.headline).bold()

                Spacer()

                Text("Atur Ulang")
                    .foregroundColor(Color("AccentColor"))
                    .font(.headline).bold()
                    .onTapGesture {
                        withAnimation {
                            activityModel.currentTimeIntEnum = .tercepat
                            activityModel.currentEffectEnum = .all
                        activityModel.currentTypeEnumActivities  = .all
                            showFilterSheetActivity = false
                            activityModel.loadActivities()
                        }
                    }
            }
            .padding(.bottom,15)
            
            
            HStack(alignment: .top){
                Text("Urutkan").font(.subheadline).bold()

            }


            activityTimeIntSorting().padding(.bottom,15)


            HStack(alignment: .top){
                Text("Tujuan").font(.subheadline).bold()

            }


            effectFiltering()    .padding(.bottom,5)

            
            HStack(alignment: .top){
                Text("Kategori").font(.subheadline).bold()

            }


            typeFiltering()      .padding(.bottom,15)




            Spacer()

            
            Button(action: {
                withAnimation {
                    showFilterSheetActivity = false
                activityModel.loadActivities()
                }
            }) {
                Text("Terapkan Filter")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.callout)
//                        .border(Color.blue)
                    .foregroundColor(.white)
                    .background(Color("AccentColor"))
                    .cornerRadius(10)
//                        .padding()
            }
            
            }.padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)




        }
        
        .background(Image("BGDashboard"))
        
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
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
    
    
    @ViewBuilder
    func activityTimeIntSorting()->some View{
        // Incase if we missed the task
        
        let tabs: [timeIntEnum] = [.tercepat, .terlama]
//        HStack(spacing: 10){
//            ForEach(tabs,id: \.self){ tab in
        
        WrappingHStack(tabs, id:\.self) { tab in
            
                Text(tab.rawValue)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .scaleEffect(0.9)
                    .foregroundColor(activityModel.currentTimeIntEnum == tab ? .white : .gray)
                    .padding(10)
//                    .frame(maxWidth: .infinity)
                    .background{
                        if activityModel.currentTimeIntEnum == tab{
                            Rectangle()
                                .fill(Color("AccentColor"))
//                                .matchedGeometryEffect(id: "timestamp", in: animation)

                        }
                        if activityModel.currentTimeIntEnum != tab{

                            Rectangle()
                                .fill(Color("lightGrey"))


                        }
                    }
                    .cornerRadius(6)

                    .onTapGesture {
                        withAnimation{
                            activityModel.currentTimeIntEnum = tab
                            
                            print("tab enum : \(activityModel.currentTimeIntEnum)" )
//                            taskModel.loadTasks(currentTab: tab)
                        }
                    }
            
            
        }

    }
    
    
    
    @ViewBuilder
    func typeFiltering()->some View{
        // Incase if we missed the task
        
        let tabs: [typeEnum] = [.all, .observation, .breathingTechique , .journalling, .outdoorObservation]
//        HStack(spacing: 10){
//            ForEach(tabs,id: \.self){ tab in
        
        WrappingHStack(tabs, id:\.self) { tab in
            
            
                Text(tab.rawValue)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .scaleEffect(0.9)
                    .foregroundColor(activityModel.currentTypeEnumActivities == tab ? .white : .gray)
                    .padding(10)
                    .background{
                        if activityModel.currentTypeEnumActivities == tab{
                            Rectangle()
                                .fill(Color("AccentColor"))
//                                .matchedGeometryEffect(id: "type", in: animation)

                        }
                        if activityModel.currentTypeEnumActivities != tab{

                            Rectangle()
                                .fill(Color("lightGrey"))


                        }
                    }
                    .cornerRadius(6)
                    .padding(.bottom, 10)

                    .onTapGesture {
                        withAnimation{
                            activityModel.currentTypeEnumActivities = tab
                            
                            print("tab enum : \(activityModel.currentTypeEnumActivities)" )
//                            taskModel.loadTasks(currentTab: tab)
                        }
                    }
            
            
        }

    }
    
//
//    @ViewBuilder
//    func situationFiltering()->some View{
//        // Incase if we missed the task
//
//        let tabs: [situationEnum] = [.all,.cemas,.emosional,.gugup,.kecewa,.linglung,.lowSelfesteem,.marah,.negatif,.panik,.putusAsa,.sedih,.senang,.stress]
////        HStack(spacing: 10){
////            ForEach(tabs,id: \.self){ tab in
//
//        WrappingHStack(tabs, id:\.self) { tab in
//
//                Text(tab.rawValue)
//                    .font(.callout)
//                    .fontWeight(.semibold)
//                    .scaleEffect(0.9)
//                    .foregroundColor(activityModel.currentSituationEnum == tab ? .white : .gray)
//                    .padding(10)
////                    .frame(maxWidth: .infinity)
//                    .background{
//                        if activityModel.currentSituationEnum == tab{
//                            Rectangle()
//                                .fill(Color("AccentColor"))
////                                .matchedGeometryEffect(id: "timestamp", in: animation)
//
//                        }
//                        if activityModel.currentSituationEnum != tab{
//
//                            Rectangle()
//                                .fill(Color("lightGrey"))
//
//
//                        }
//                    }
//                    .cornerRadius(6)
//                    .padding(.bottom, 10)
//
//                    .onTapGesture {
//                        withAnimation{
//                            activityModel.currentSituationEnum = tab
//
//                            print("tab enum : \(activityModel.currentSituationEnum)" )
////                            taskModel.loadTasks(currentTab: tab)
//                        }
//                    }
//
//
//        }
//
//    }
    
    @ViewBuilder
    func effectFiltering()->some View{
        // Incase if we missed the task
        
        let tabs: [effectEnum] = [.all,.fokus,.kreatif,.optimis,.tenang,.tidur]
//        HStack(spacing: 10){
//            ForEach(tabs,id: \.self){ tab in
        
            WrappingHStack(tabs, id:\.self) { tab in
            
            
                Text(tab.rawValue)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .scaleEffect(0.9)
                    .foregroundColor(activityModel.currentEffectEnum == tab ? .white : .gray)
            
                    .padding(10)
                    
//                    .frame(maxWidth: .infinity)
                    .background{
                        if activityModel.currentEffectEnum == tab{
                            Rectangle()
                                .fill(Color("AccentColor"))
//                                .matchedGeometryEffect(id: "type", in: animation)

                        }
                        if activityModel.currentEffectEnum != tab{

                            Rectangle()
                                .fill(Color("lightGrey"))


                        }
                    }
                    .cornerRadius(6)
                    .padding(.bottom, 10)

                    .onTapGesture {
                        withAnimation{
                            activityModel.currentEffectEnum = tab
                            
                            print("tab enum : \(activityModel.currentEffectEnum)" )
//                            taskModel.loadTasks(currentTab: tab)
                        }
                    }
            
            
        }

    }
    
}


struct MindfulView_Previews: PreviewProvider {
    static var previews: some View {
        MindfulView()
    }
}
