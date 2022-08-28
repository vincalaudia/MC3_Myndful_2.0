//
//  JournalingView.swift
//  dashboard
//
//  Created by Jovinca Claudia on 01/07/22.
//

import SwiftUI
import Foundation


struct MorningPagesView: View {
    @ObservedObject var activityModel: ActivityViewModel
    
    @State private var journalBody: String = "Hari ini aku merasa.."

    // MArk : Environment Values

    @State var moveToNextScreen = false
    
    
    var body: some View {
        //INI CONTOH AJA BUAT JOURNALLING VIEW

//        let moods: [String] = ["Sedih", "Senang", "Marah", "Normal"]
        
        
        VStack(){
            VStack(spacing : 5){
                Text("Morning Pages")
                    .font(.title)
                    .bold()
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .padding(.leading, 30)
                
                Text(getDate())
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .padding(.leading, 30)
                
                Text("____")
                    .foregroundColor(Color("BlueAccent"))
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 15, trailing: 0))
                
                
             
                
                Text("Tulis semua yang ada dipikiran mu")
                    .font(.title3)
                    .bold()
                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 15, trailing: 0))
                    .frame(maxWidth:.infinity, alignment: .leading)
                
   
                
                GeometryReader{ geo in
                    VStack(alignment: .center ,spacing : 20){
                
        
                    
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
                            
                            
                            
                
                        

                }.frame(maxWidth: geo.size.width * 1, alignment: .center)
                }
                
                Spacer()
   
                    NavigationLink(destination: CongratsView(activityModel: activityModel, image: "congrats", congratsBody: "Anda telah berhasil \nmenyelesaikan aktivitas mindful \nini, mari kita lebih sadar akan minfulness !."), isActive: $moveToNextScreen) {
                        EmptyView()

                    }
            
                
                
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
            
            activityModel.morningPages()
            moveToNextScreen = true
            
            
        } label: {
            Text("Save")
       
        }
            .disabled(activityModel.journalBody ==  "")
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


struct MorningPagesView_Previews: PreviewProvider {
    
    static var previews: some View {
        MorningPagesView(activityModel: ActivityViewModel())
    }
}
