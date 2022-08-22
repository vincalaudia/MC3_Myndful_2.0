//
//  GratitudeListView.swift
//  MC2-Mindful-App
//
//  Created by Muhammad Nur Faqqih on 22/08/22.
//

import SwiftUI

struct GratitudeListView: View {
    
    @ObservedObject var activityModel: ActivityViewModel = ActivityViewModel()
    
    
    var body: some View {

        VStack(){
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
                
                
        
                
                Text("Apa hal yang anda syukuri ?")
                    .font(.title2)
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
                
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
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
   
//                NavigationLink(destination:MindfulView()){
           
                    
                    NavigationLink(destination: CongratsView(activityModel: activityModel, image: "Meditating", congratsBody: "Anda telah berhasil \nmenyelesaikan aktivitas mindful \nini, mari kita lebih sadar akan minfulness !.")) {
                    
                    VStack{
                        Text("Selesai")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                
                    .frame(width: UIScreen.main.bounds.width-70, height: 50, alignment: .center)
                        .background(Color.accentColor)
                        .cornerRadius(25)
                        .padding(.horizontal)
                        .padding(.vertical,2)
                        .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)
                
                    }.simultaneousGesture(TapGesture().onEnded{
                    
                        activityModel.journaling(activity: activityModel.selectedActivity)
                        
                    })
                    
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
        .background(Image("BGDashboard"))
    }
    
    
    func getDate() -> String {
        let date = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM y"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}

struct GratitudeListView_Previews: PreviewProvider {
    static var previews: some View {
        GratitudeListView(activityModel: ActivityViewModel())
    }
}
