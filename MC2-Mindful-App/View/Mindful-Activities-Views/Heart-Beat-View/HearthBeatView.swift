//
//  Heartbeat.swift
//  MC2-Mindful-App
//
//  Created by Jovinca Claudia on 23/08/22.
//

import SwiftUI

struct HearthBeatView: View {
    @ObservedObject var activityModel: ActivityViewModel
    
    @State var animate = false
    @State var scalePoint : Double = 1.0
    
    //store 40 data trs diambil averagenya dr situ
    @State var totalTime : Double = 0
    @State var currentTime: Double = 0
    @State var beforeTimeLap: Double = 0
    @State var timeLap: Double = 0
    @State var averageBeat : Double = 0
    @State var index = 0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
 
    @State var progressValue: Float = 0
    
    @State var moveToNextScreen = false
    
    var body: some View {
        ZStack{
            NavigationLink(destination: CongratsView(activityModel: activityModel, image: "congrats", congratsBody: "Jadi lebih sadar dengan dirimu sendiri! (Detak Jantung : \(String(format: "%.1f", averageBeat)) bpm)"), isActive: $moveToNextScreen) {
                EmptyView()
            }
            
            VStack(){
                Text("Your Heartbeat")
                    .padding(.top, UIScreen.main.bounds.height/12)
                    .font(.title3)
                    .foregroundColor(Color(red: 93/255, green: 164/255, blue: 255/255))
                Text("\(String(format: "%.1f", averageBeat)) bpm")
                    .bold()
                    .font(.system(size:40))
                    .foregroundColor(Color(red: 93/255, green: 164/255, blue: 255/255))
                
                Spacer()
                Text("Ketuk ketika anda merasakan detak jantung anda")
                    .padding(.top, UIScreen.main.bounds.height/7)
                    .font(.body)
                    .foregroundColor(Color(red: 170/255, green: 201/255, blue: 247/255))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, UIScreen.main.bounds.height/8)
                    .padding([.trailing,.leading], 30)
            }
            
            ZStack{
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(self.animate ? 2.5 : 0.5)
                    .opacity(self.animate ? 0.03 : 0)
                    .foregroundColor(Color.blue)
                    .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2, alignment: .center)
                
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(self.animate ? 2.0 : 0.5)
                    .opacity(self.animate ? 0.03 : 0)
                    .foregroundColor(Color.blue)
                    .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2, alignment: .center)
                
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(self.animate ? 1.5 : 0.5)
                    .opacity(self.animate ? 0.03 : 0)
                    .foregroundColor(Color.blue)
                    .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2, alignment: .center)
            } .animation(animate ? Animation.easeInOut(duration: 0.5) : .default, value: animate)
                .onReceive(timer){ _ in
                    currentTime += 0.1
                    progressValue += 1/600
                    //ceritanya 60 detik
                    if(progressValue>1){
                        moveToNextScreen = true
                        activityModel.heartbeatAvg = averageBeat
                    }
                }
            
            
            Button{
                playSound(sound: "knockSound", type: "wav")
                Haptics.shared.play(.heavy)
                self.animate.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.animate = false                  // << here !!
                }
                
                beforeTimeLap = timeLap
                timeLap = currentTime
                
                if(beforeTimeLap != 0 && !moveToNextScreen){
                    totalTime += timeLap-beforeTimeLap
                    index += 1
                    averageBeat = 60/(totalTime/Double(index))
                }
                
                
            }label: {
                ZStack{
                    LinearGradient(
                        colors: [Color(red: 93/255, green: 164/255, blue: 255/255), Color(red: 222/255, green: 230/255, blue: 255/255)],
                        startPoint: .top,
                        endPoint: .bottom
                    ).frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2, alignment: .center)
                        .mask(
                            Circle()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width/3+50, height: UIScreen.main.bounds.width/3+50, alignment: .center)
                        ).shadow(color: Color.blue.opacity(0.2), radius: 20, x: 0, y: 0)
                    Image(systemName: "heart.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.white)
                        .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3, alignment: .center)
                }
            }
            
            ProgressBar(progress: self.$progressValue)
                .frame(width: UIScreen.main.bounds.width/2+50, height: UIScreen.main.bounds.width/2+50)
        }.padding(.top, 80)
            .navigationBarTitleDisplayMode(.inline)
    }
    class Haptics {
        static let shared = Haptics()
        
        private init() { }
        
        func play(_ feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
            UIImpactFeedbackGenerator(style: feedbackStyle).impactOccurred()
        }
    }
}
/*
 ZStack{
 Circle()
 .fill(Color.orange.opacity(0.25))
 .frame(width: 350, height:350)
 .scaleEffect(self.animate ? 1 : 0)
 
 Circle().fill(Color.orange.opacity(0.35)).frame(width: 250, height:
 250) .scaleEffect(self.animate ? 1: 0)
 Circle().fill(Color.orange.opacity(0.45)).frame (width: 150, height:
 150) .scaleEffect(self.animate ? 1 : 0)
 Circle().fill(Color.orange).frame(width: 30, height: 30)
 }. onAppear
 self.animate.toggle()
 }
 .animation(Animation.linear(duration: 1.5).repeatForever(autoreverses:
 false))
 */
struct HearthBeatView_Previews: PreviewProvider {
    static var previews: some View {
        HearthBeatView(activityModel: ActivityViewModel())
    }
}
