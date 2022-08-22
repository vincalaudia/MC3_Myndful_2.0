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
    @State var progressValue2: Float = 0.0
    @State var alphabet = randomString()
    @State var currentTime = 0
    @State var moveToNextScreen = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            //            Text("Jadi lebih mindful dengan\nlingkungan sekitar anda")
            //                .font(.title)
            //                .bold()
            //                .padding(.bottom, 20)
            
            Text("Cari Objek yang berawalan\ndengan huruf...")
                .font(.body)
            
            ZStack{
                
                NavigationLink(destination: CongratsView(activityModel: activityModel, image: "Meditating", congratsBody: "Yay kamu telah berhasil menemukan  \n\(activityModel.found) objek dari total \(activityModel.found+activityModel.miss)"), isActive: $moveToNextScreen) {
                    
                    EmptyView()
                    
                }
                ProgressBar(progress: self.$progressValue)
                    .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2)
                
                ProgressBar2(progress: self.$progressValue2)
                    .frame(width: UIScreen.main.bounds.width/2 + 40, height: UIScreen.main.bounds.width/2 + 40)
                
                ZStack(){
                    
                    Text(alphabet)
                        .foregroundColor((Color(red: 123/255, green: 180/255, blue: 252/255)))
                        .font(.system(size: 55))
                        .bold()
                        .onReceive(timer){ _ in
                            if(currentTime <= 120){
                                currentTime += 1
                                progressValue += 1/12
                                progressValue2 += 1/120
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
                    
                    
                    
                    
                }
                
            }.navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Scavenger Hunt")
            
                .padding(30)
            
            HStack( spacing : 30){
                VStack(spacing : 10){
                    Text("Found")
                        .bold()
                        .frame(width: UIScreen.main.bounds.width/5, height: 25)
                        .background(Color.white)
                        .foregroundColor((Color(red: 162/255, green: 182/255, blue: 220/255)))
                    Text("\(activityModel.found)")
                        .foregroundColor(Color.white)
                        .bold()
                        .font(.title2)
                }
                .frame(width: UIScreen.main.bounds.width/5, height: UIScreen.main.bounds.width/5, alignment: .center)
                .background(Color(red: 172/255, green: 207/255, blue: 255/255))
                .cornerRadius(6)
                    
                VStack(spacing : 10){
                    Text("Miss")
                        .bold()
                        .frame(width: UIScreen.main.bounds.width/5, height: 25)
                        .background(Color.white)
                        .foregroundColor(Color(red: 181/255, green: 181/255, blue: 220/255))
                    Text("\(activityModel.miss)")
                        .foregroundColor(Color.white)
                        .bold()
                        .font(.title2)
                }
                
                .frame(width: UIScreen.main.bounds.width/5, height: UIScreen.main.bounds.width/5, alignment: .center)
                .background(Color(red: 181/255, green: 195/255, blue: 253/255))
                .cornerRadius(6)
                
            }.padding(.bottom, 10)
            
            HStack{
                Button("Ketemu"){
                    alphabet = randomString()
                    progressValue = 0.0
                    activityModel.found+=1
                }.frame(width: UIScreen.main.bounds.width/3, height: 50, alignment: .center)
                    .background(Color(red: 123/255, green: 180/255, blue: 252/255))
                    .foregroundColor(.white)
                    .cornerRadius(7)
                
            }
        }
        .multilineTextAlignment(.center)
        
    }
    
    
}

struct ProgressBar2: View {
    @Binding var progress: Float
    
    var body: some View {
        GeometryReader{ geo in
            ZStack {
                Circle()
                    .stroke(lineWidth: 15.0)
                    .foregroundColor(Color(red: 181/255, green: 195/255, blue: 253/255))
                    .opacity(0.3)
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color(red: 181/255, green: 195/255, blue: 253/255))
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear(duration: 1.0))
                
            }.animation(.linear(duration: 1.0))
        }
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
