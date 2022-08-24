//
//  GratitudeListView.swift
//  MC2-Mindful-App
//
//  Created by Muhammad Nur Faqqih on 22/08/22.
//

import SwiftUI

struct DetailJournalingActivitiesView: View {
    
    @ObservedObject var activityModel: ActivityViewModel = ActivityViewModel()
    
    @State var editMode: EditMode = .active
    @State var isEditing = true
    
    @State var isEmpty = Color(.gray)
    
    
//
//    UITableView.appearance().backgroundColor = .clear
//    UITableViewCell.appearance().backgroundColor = .clear
//    UITableView.appearance().tableFooterView = UIView()
    
    @State var gratitudeText: String = ""
    var body: some View {

        VStack(){
            VStack(spacing : 5){
                
//                if activityModel.selectedActivityForDetail.viewDestination == "GratitudeListView" {
                
                HStack{
                Text(activityModel.selectedUserActivityForDetail.activity?.title ?? "")
                    .font(.title)
                    .bold()
            
                    
                    if (activityModel.selectedUserActivityForDetail.activity?.viewDestination == "JournalingView") {
                        Spacer()
                        Text(activityModel.selectedUserActivityForDetail.emoji ?? "😅").font(.title)
                    }
                    
                }        .frame(maxWidth:.infinity, alignment: .leading)
                    .padding(.horizontal, 30)
//                }
                    

                Text(getDate(timestamp: activityModel.selectedUserActivityForDetail.timestamp ?? Date()))
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .padding(.leading, 30)
                
                Text("____")
                    .foregroundColor(.accentColor)
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 15, trailing: 0))
                
    
                
         
                
                GeometryReader{ geo in
                    VStack(alignment: .center ,spacing : 20){
        
                        
        
                         
                            if (activityModel.selectedUserActivityForDetail.activity?.viewDestination == "GratitudeListView" || activityModel.selectedUserActivityForDetail.activity?.viewDestination == "IntentionSettingView"){
                            
                        List{
                            
                            ForEach(
                                Array(activityModel.selectedUserActivityForDetail.journalingList! as Set), id: \.self) { item in

                                    JournalingListRow(item: item as! JournalingList)
                                
                            }
                

                        }
//                        .listStyle(.inset)
                                
                            } else if (activityModel.selectedUserActivityForDetail.activity?.viewDestination == "JournalingView" || activityModel.selectedUserActivityForDetail.activity?.viewDestination == "MorningPagesView"){
                                
                                VStack{
                                
                                ZStack{
                                    TextEditor(text: .constant(activityModel.selectedUserActivityForDetail.journalBody ?? "")).foregroundColor(.gray)
        
                                    Text(activityModel.selectedUserActivityForDetail.journalBody ?? "").opacity(0).padding(.all, 0)
                                }.padding(.horizontal,15)
                                    .padding(.vertical, 20)
                                    
                                } .frame(maxWidth: .infinity,maxHeight: geo.size.height * 0.5, alignment: .center)
                                        .background(Color.white)
                                        .cornerRadius(15)
                                        .padding(.horizontal, 30)
                                        .padding(.top,3)
                                        .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)
                            }
                            
                            
                            
//                            .environment(\.editMode, $editMode)
//
                        


//                Spacer()
                    
                        

                }.frame(maxWidth: geo.size.width * 1, alignment: .center)
                }
                
                Spacer()
                

   
//                NavigationLink(destination:MindfulView()){
           
                    
//                    NavigationLink(destination: CongratsView(activityModel: activityModel, image: "Meditating", congratsBody: "Anda telah berhasil \nmenyelesaikan aktivitas mindful \nini, mari kita lebih sadar akan minfulness !.")) {
//
//                    VStack{
//                        Text("Selesai")
//                            .foregroundColor(Color.white)
//                            .bold()
//                    }
//
//                    .frame(width: UIScreen.main.bounds.width-70, height: 50, alignment: .center)
//                        .background(Color.accentColor)
//                        .cornerRadius(25)
//                        .padding(.horizontal)
//                        .padding(.vertical,2)
//                        .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)
//
//                    }.simultaneousGesture(TapGesture().onEnded{
//
//                        activityModel.journaling(activity: activityModel.selectedActivity)
//
//                    })
                    
//                        .opacity(activityModel.isFeelingSelected ? 1 : 0.5)
//                        .onTapGesture {
//
//
//
//
//                        }
//
            
                
                
//            }
//                }
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle("", displayMode: .inline)
                .padding(.top,30)
            
        }        .onAppear(){
            
            UITableView.appearance().backgroundColor = .clear
            UITableViewCell.appearance().backgroundColor = .clear
            UITableView.appearance().tableFooterView = UIView()
    }

        .onTapGesture {
                    let keyWindow = UIApplication.shared.connectedScenes
                                       .filter({$0.activationState == .foregroundActive})
                                       .map({$0 as? UIWindowScene})
                                       .compactMap({$0})
                                       .first?.windows
                                       .filter({$0.isKeyWindow}).first
                    keyWindow!.endEditing(true)

                }
        .background(Image("BGDashboard"))
    }
    
    struct JournalingListRow: View {
        @ObservedObject var item: JournalingList   // !! @ObserveObject is the key!!!


        @EnvironmentObject var activityModel: ActivityViewModel
//        // MARK : All Environment Values in one variable !
//        @Environment(\.self) var env

//        @EnvironmentObject var taskModel: TaskViewModel
//        // MARK : All Environment Values in one variable !
        @Environment(\.self) var env
//
        var body: some View {
            HStack{
                //        Text(subtask.name ?? "")
                
                Text(item.name ?? "")
//                TextField("Subtask Name", text: $item.name.toUnwrapped(defaultValue: ""))
//                Text("Order : \(subtask.order)")

//                    .onChange(of: subtask.name, perform: { _ in
//                        taskModel.editSubtaskName(context: env.managedObjectContext, subtask: subtask)
//                        //                        taskModel.loadTasks(currentTab: taskModel.currentTabEnum)
//                        print("Berhasil edit subtask")
//                    })

            }
        }
    }
    
    
    
    private func moveJournalingList(at sets:IndexSet,destination:Int){
        let journalingListToMove = sets.first!

        if journalingListToMove < destination {
            var startIndex = journalingListToMove + 1
            let endIndex = destination - 1
            var startOrder = activityModel.journalingListArrayToAdd[journalingListToMove].order
            while startIndex <= endIndex{
                activityModel.journalingListArrayToAdd[startIndex].order = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            activityModel.journalingListArrayToAdd[journalingListToMove].order = startOrder
        }
        else if destination < journalingListToMove {
            var startIndex = destination
            let endIndex = journalingListToMove - 1
            var startOrder = activityModel.journalingListArrayToAdd[destination].order + 1
            let newOrder = activityModel.journalingListArrayToAdd[destination].order
            while startIndex <= endIndex {
                activityModel.journalingListArrayToAdd[startIndex].order = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            activityModel.journalingListArrayToAdd[journalingListToMove].order = newOrder
        }
        do {
            activityModel.journalingListArrayToAdd = activityModel.journalingListArrayToAdd.sorted(by: { $0.order < $1.order })
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    private func deleteJournalingList(at offset:IndexSet){
        withAnimation{
            activityModel.journalingListArrayToAdd.remove(atOffsets: offset)
            do {
//                print("\(activityModel.journalingListArrayToAdd[0].name)")
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    
    func getDate(timestamp: Date) -> String {
        let date = timestamp
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM y"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}

struct DetailJournalingActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        DetailJournalingActivitiesView(activityModel: ActivityViewModel())
    }
}


