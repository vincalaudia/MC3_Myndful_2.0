//
//  GratitudeListView.swift
//  MC2-Mindful-App
//
//  Created by Muhammad Nur Faqqih on 22/08/22.
//

import SwiftUI

struct IntentionSettingView: View {
    
    @State var moveToNextScreen = false
    
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
                Text("Intention Setting")
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
                
                
        
                
                Text("Hari ini, berniat melakukan :")
                    .font(.title2)
                    .bold()
                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 15, trailing: 0))
                    .frame(maxWidth:.infinity, alignment: .leading)
                
         
                
                GeometryReader{ geo in
                    VStack(alignment: .center ,spacing : 20){
        
                        
                    VStack{
                        
                        HStack {
                            TextField(
                                  "Masukan yang anda pikirkan",
                                  text: $activityModel.journalingListName
                            ).onChange(of: activityModel.journalingListName, perform: { _ in
                                if activityModel.journalingListName == "" {
                                    
                                    isEmpty = Color(.gray)
                                } else {
                                    
                                    isEmpty = Color("AccentColor")
                                }
                                
                                
                            })
                            
                            .padding()
                            
                            
                             Button(action: {
                                 // Closure will be called once user taps your button
                                 print(self.$activityModel.journalingListName)
                                 
                                 
                        
                                         
                                activityModel.newJournalingList()
                                 
                                 
                                activityModel.journalingListName = ""
                                         
                                
                             })
                    {
                        Text("Add +").foregroundColor(.white).font(.callout)
                             }
                    .disabled(activityModel.journalingListName == "")
                    .padding(.top, 20)
                                .padding(.bottom, 20)
                                .padding(.horizontal, 8)
                            
//                            if activityModel.journalingListName != ""{
                                .background(LinearGradient(
                                    colors: [Color(red: 180/255, green: 194/255, blue: 253/255), isEmpty],
                                    startPoint: .topTrailing,
                                    endPoint: .bottomTrailing
                                    
                                ))
//                            } else {
//                                .background(Color(.gray))
//
//
//                            }
                        }
                        
//                        ZStack{
//                            TextEditor(text: $activityModel.journalBody).foregroundColor(.gray)
////                            TextEditor(text:$activityModel.journalBody)
////                            TextField("dwadwad", text:$activityModel.journalBody, Axis: .vertical)
//
//                            Text(activityModel.journalBody).opacity(0).padding(.all, 0)
//                        }.padding(.horizontal,15)
//                            .padding(.vertical, 20)
                        
                        
        
                        
                    }
                
                    .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal, 30)
                        .padding(.vertical,3)
                        .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)
                
                        
                        
//                        VStack{
                        
                        List{
                            
                            ForEach(activityModel.journalingListArrayToAdd, id: \.id) { item in

                                JournalingListRow(item: item)
                                
                            }
                            .onDelete(perform: deleteJournalingList)
//                            .onDelete { (indexSet) in
//                                                    deleteJournalingList(at: indexSet)
//                                                }
                            .onMove(perform: moveJournalingList)
                        
                

                        }.padding(.horizontal,5)
//                        .listStyle(.inset)
////                            .environment(\.editMode, $editMode)
////
//                        } .frame(maxWidth: .infinity,maxHeight: geo.size.height * 0.5, alignment: .center)
//                                .background(Color.white)
//                                .cornerRadius(15)
//                                .padding(.horizontal, 30)
//                                .padding(.top,3)
//                                .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)


//                Spacer()
                    
                        

                }.frame(maxWidth: geo.size.width * 1, alignment: .center)
                }
                
                Spacer()
                
                NavigationLink(destination: CongratsView(activityModel: activityModel, image: "congrats", congratsBody: "Anda telah berhasil \nmenyelesaikan aktivitas mindful \nini, mari kita lebih sadar akan minfulness !."), isActive: $moveToNextScreen) {
                    EmptyView()
                    
                }
   
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
            
        }
        .onAppear(){
            
                UITableView.appearance().backgroundColor = .clear
                UITableViewCell.appearance().backgroundColor = .clear
                UITableView.appearance().tableFooterView = UIView()
        }
        .navigationBarItems(trailing: Button {
            // Mark : IF success closing the View
//            if  activityModel.addTask(context: env.managedObjectContext) {
//                taskModel.subtaskArrayToAdd = []
//                taskModel.loadTasks(currentTab: taskModel.currentTabEnum)
//                env.dismiss()
//            }
            
            activityModel.gratitudeList()
            moveToNextScreen = true
            
            
        } label: {
            Text("Save")
       
        }
            .disabled(activityModel.journalingListArrayToAdd.count ==  0)
                            )
//            .opacity(taskModel.taskTitle == "" ? 0.6 : 1))
//        .ignoresSafeArea(.keyboard)
        .onTapGesture {
                    let keyWindow = UIApplication.shared.connectedScenes
                                       .filter({$0.activationState == .foregroundActive})
                                       .map({$0 as? UIWindowScene})
                                       .compactMap({$0})
                                       .first?.windows
                                       .filter({$0.isKeyWindow}).first
                    keyWindow!.endEditing(true)

                }
        .background(Image("BGDashboard")
            .resizable()
            .scaledToFill())
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
                TextField("Subtask Name", text: $item.name.toUnwrapped(defaultValue: ""))
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
    
    
    func getDate() -> String {
        let date = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM y"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}

struct IntentionSettingView_Previews: PreviewProvider {
    static var previews: some View {
        IntentionSettingView(activityModel: ActivityViewModel())
    }
}
