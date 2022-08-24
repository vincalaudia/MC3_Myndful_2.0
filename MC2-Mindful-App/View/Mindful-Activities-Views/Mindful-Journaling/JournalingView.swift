//
//  JournalingView.swift
//  dashboard
//
//  Created by Jovinca Claudia on 01/07/22.
//

import SwiftUI
import Foundation


struct JournalingView: View {
    @ObservedObject var activityModel: ActivityViewModel
    
    @State private var journalBody: String = "Here is your story !"

    // MArk : Environment Values

    @State var moveToNextScreen = false
    
    let selectedForegroundColor = Color.white
    let selectedbackgroundColor = "AccentColor"
    
    var body: some View {
        //INI CONTOH AJA BUAT JOURNALLING VIEW

//        let moods: [String] = ["Sedih", "Senang", "Marah", "Normal"]
        
        
        VStack(){
            VStack(spacing : 5){
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
                
                
                if activityModel.selectedFeeling == "" {
                
                Text("Gimana keadaanmu hari ini ?")
                    .font(.title2)
                    .bold()
                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 15, trailing: 0))
                    .frame(maxWidth:.infinity, alignment: .leading)
                
                } else {
                    
                    Text("Apa yang terjadi hari ini ?")
                        .font(.title2)
                        .bold()
                        .padding(EdgeInsets(top: 0, leading: 30, bottom: 15, trailing: 0))
                        .frame(maxWidth:.infinity, alignment: .leading)
                }
                
                GeometryReader{ geo in
                    VStack(alignment: .center ,spacing : 20){
                
                        if activityModel.selectedFeeling == "" {
                    HStack(spacing : 20){
                        Button(action: {
                            activityModel.feeling = "Sedih"
                            activityModel.emoji = "😭"
                            activityModel.isFeelingSelected = true
                        }, label :{
                            
                            if activityModel.feeling != "Sedih" {
                            VStack(spacing : 5){
                                
                                Text("😭")
                                    .font(.largeTitle)
                                Text("Sedih")
                                    .font(.title3)
                                    .bold()
                            }.frame(width: 115, height: 115, alignment: .center)
                                .background(Color.white)
                                .cornerRadius(20)
                                .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)
                                
                            }
                            
                            
                            if activityModel.feeling == "Sedih"{
                            VStack(spacing : 5){
                                
                                Text("😭")
                                    .font(.largeTitle)
                                
                                Text("Sedih")
                                    .font(.title3)
                                    .foregroundColor(selectedForegroundColor)
                                    .bold()
                            }.frame(width: 115, height: 115, alignment: .center)
                                .background(Color(selectedbackgroundColor))
                                .cornerRadius(20)
                                .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)
                                
                            }
                            
                        })
                        
                        Button(action: {
                            activityModel.feeling = "Senang"
                            activityModel.emoji = "☺️"
                            activityModel.isFeelingSelected = true
                        }, label :{
                            
                            if activityModel.feeling != "Senang" {
                            VStack(spacing : 5){
                                Text("☺️")
                                    .font(.largeTitle)
                                Text("Senang")
                                    .font(.title3)
                                    .bold()
                            }.frame(width: 115, height: 115, alignment: .center)
                                .background(Color.white)
                                .cornerRadius(20)
                                .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)
                                
                            }
                            
                            
                            if activityModel.feeling == "Senang" {
                            VStack(spacing : 5){
                                Text("☺️")
                                    .font(.largeTitle)
                                Text("Senang")
                                    .font(.title3)
                                    .foregroundColor(selectedForegroundColor)
                                    .bold()
                            }.frame(width: 115, height: 115, alignment: .center)
                                .background(Color(selectedbackgroundColor))
                                .cornerRadius(20)
                                .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)
                                
                            }
                        })
                        
                    }.frame(maxWidth: .infinity, alignment: .center)


                    HStack(spacing : 20){
                        Button(action: {
                            activityModel.feeling = "Marah"
                            activityModel.emoji = "😡"
                            activityModel.isFeelingSelected = true
                        }, label :{
                            
                            
                            
                        if activityModel.feeling == "Marah" {
                            
                            VStack(spacing : 5){
                                Text("😡")
                                    .font(.largeTitle)
                                Text("Marah")
                                    .font(.title3)
                                    .foregroundColor(selectedForegroundColor)
                                    .bold()
                            }.frame(width: 115, height: 115, alignment: .center)
                                .background(Color(selectedbackgroundColor))
                                .cornerRadius(20)
                                .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)
                                
                            
                       
                        } else {
                        
                            VStack(spacing : 5){
                                Text("😡")
                                    .font(.largeTitle)
                                Text("Marah")
                                    .font(.title3)
                                    .bold()
                            }.frame(width: 115, height: 115, alignment: .center)
                                .background(Color.white)
                                .cornerRadius(20)
                            .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)
                           
                            
                        }
                            
                            
                            
                        })
                        
                        Button(action: {
                            activityModel.feeling = "Normal"
                            activityModel.emoji = "😐"
                            activityModel.isFeelingSelected = true
                        }, label :{
                            
                            if activityModel.feeling == "Normal" {
                            VStack(spacing : 5){
                                Text("😐")
                                    .font(.largeTitle)
                                Text("Normal")
                                    .font(.title3)
                                    .foregroundColor(selectedForegroundColor)
                                    .bold()
                            }.frame(width: 115, height: 115, alignment: .center)
                                .background(Color(selectedbackgroundColor))
                                .cornerRadius(20)
                                .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)
                                
                            } else {
                                VStack(spacing : 5){
                                    Text("😐")
                                        .font(.largeTitle)
                                    Text("Normal")
                                        .font(.title3)
                                        .bold()
                                }.frame(width: 115, height: 115, alignment: .center)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)
                    
                                
                            }
                            
                            
                            
                        })
                        
                        
                    }.frame(maxWidth: .infinity, alignment: .center)
                            
                } else {
                            
                    
                    VStack{
                        ZStack{
                            TextEditor(text: $activityModel.journalBody).foregroundColor(.gray)
//                            TextEditor(text:$activityModel.journalBody)
//                            TextField("dwadwad", text:$activityModel.journalBody, Axis: .vertical)
                            
                            Text(activityModel.journalBody).opacity(0).padding(.all, 0)
                        }.padding(.horizontal,15)
                            .padding(.vertical, 20)
                        
                    }
                
                    .frame(maxWidth: .infinity, maxHeight: geo.size.height * 0.5, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(25)
                        .padding(.horizontal, 30)
                        .padding(.vertical,3)
                        .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)
                
                        .onTapGesture {
                           
                        }
                            
                            
                            
                }
                        

                }.frame(maxWidth: geo.size.width * 1, alignment: .center)
                }
                
                Spacer()
   
//                NavigationLink(destination:MindfulView()){
           
                if activityModel.selectedFeeling == "" {
                    VStack{
                        Text("Lanjut")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                
                    .frame(width: UIScreen.main.bounds.width-70, height: 50, alignment: .center)
                        .background(Color.accentColor)
                        .cornerRadius(25)
                        .padding()
                        .opacity(activityModel.isFeelingSelected ? 1 : 0.5)
                        .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)
                        .onTapGesture {
                            if activityModel.feeling != ""{
                                withAnimation{
                                    activityModel.selectedFeeling = activityModel.feeling
                                }
                            }
                        }
                    
                }
                
                else {

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
//                       print("Isinya si selected activity")
//                        print(activityModel.selectedActivity)
//
//                        print("Isinya si selected feeling")
//                         print(activityModel.selectedFeeling)
//
//                        print("Isinya si selected emoji")
//                         print(activityModel.emoji)
//
//
//                        print("Isinya si selected journal body")
//                         print(activityModel.journalBody)
//
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
                    
                    NavigationLink(destination: CongratsView(activityModel: activityModel, image: "congrats", congratsBody: "Anda telah berhasil \nmenyelesaikan aktivitas mindful \nini, mari kita lebih sadar akan minfulness !."), isActive: $moveToNextScreen) {
                        EmptyView()

                    }
                    
//
                    VStack{
                        Text("Kembali")
                            .bold()
                    }


                    .frame(width: UIScreen.main.bounds.width-70, height: 50, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(25)
                        .padding(.horizontal)
//                        .opacity(activityModel.isFeelingSelected ? 1 : 0.5)
                        .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)

                        .onTapGesture {
//                            if activityModel.feeling != ""{
//                                activityModel.selectedFeeling = activityModel.feeling
//                            }
                            withAnimation{
                            activityModel.selectedFeeling = ""
                            }
                        }

                }
                
                
//            }
//                }
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle("", displayMode: .inline)
                .padding(.top,30)
            
        }
        .navigationBarItems(trailing: Button {
            // Mark : IF success closing the View
//            if  activityModel.addTask(context: env.managedObjectContext) {
//                taskModel.subtaskArrayToAdd = []
//                taskModel.loadTasks(currentTab: taskModel.currentTabEnum)
//                env.dismiss()
//            }
            
            activityModel.journaling(activity: activityModel.selectedActivity)
            moveToNextScreen = true
            
            
        } label: {
            Text("Save")
       
        }
            .disabled(activityModel.selectedFeeling ==  "")
                 )
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
    
    func getDate() -> String {
        let date = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM y"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}


struct JournalingView_Previews: PreviewProvider {
    
    static var previews: some View {
        JournalingView(activityModel: ActivityViewModel())
    }
}
