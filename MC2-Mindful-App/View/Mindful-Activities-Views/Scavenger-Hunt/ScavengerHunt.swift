//
//  ScavengerHunt.swift
//  MC2-Mindful-App
//
//  Created by Jovinca Claudia on 15/08/22.
//

import SwiftUI

struct ScavengerHunt: View {
    @ObservedObject var activityModel: ActivityViewModel
    @Environment(\.self) var env
    
    @State var progressValue: Float = 0.0
    @State var alphabet = randomString()
//    @State var miss : Int = 0
//    @State var found : Int = 0
    @State var currentTime = 0
    @State var moveToNextScreen = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            Text("Jadi lebih mindful dengan\nlingkungan sekitar anda")
                .font(.title2)
                .padding(.bottom, 20)
            Text("Cari Objek yang berawalan dengan huruf...")
                .font(.caption)
            
            ZStack{
                
                NavigationLink(destination: CongratsView(activityModel: activityModel, image: "Meditating", congratsBody: "Yay kamu telah berhasil menemukan  \n\(activityModel.found) objek dari total \(activityModel.found+activityModel.miss)"), isActive: $moveToNextScreen) {
                                    
                                    EmptyView()
                
                                }
                ProgressBar(progress: self.$progressValue)
                    .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2)
                
                ZStack(){
            
                    Text(alphabet)
                        .font(.largeTitle)
                        .bold()
                        .onReceive(timer){ _ in
                            if(currentTime <= 120){
                                currentTime += 1
                                progressValue += 1/12
                            }
                            else{
                                moveToNextScreen = true
                                
                               
                            }
                            
                            if(progressValue>1){
                                progressValue = 0.0
                                alphabet = randomString()
                                activityModel.miss+=1
                            }
                        }
                    
                    
                    Text("\(activityModel.found) - \(activityModel.miss)")
                        .font(.caption)
                        .bold()
                        .frame(width: UIScreen.main.bounds.width/8, height: 20, alignment: .center)
                        .background(Color(red: 172/255, green: 207/255, blue: 255/255))
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        .padding(.top, 75)
             
                    
                }
                
            }.navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Scavenger Hunt")
      
            .padding(30)
            
            
            HStack{
                Button("Ketemu"){
                    alphabet = randomString()
                    progressValue = 0.0
                    activityModel.found+=1
                }
                
            }
        }

        .multilineTextAlignment(.center)
        
    }
    
    
}

func randomString() -> String {
    let letters = "ABCDEFGHIJKLMNOPRSTUW"
    var s = ""
    s.append(letters.randomElement()!)
    return s
}



struct ScavengerHunt_Previews: PreviewProvider {
    static var previews: some View {
        ScavengerHunt(activityModel: ActivityViewModel())
    }
}
