//
//  BreathingTimerView.swift
//  Mindful_WatchApp WatchKit Extension
//
//  Created by Jovinca Claudia on 14/07/22.
//

import SwiftUI
import UIKit



struct Mindful_Breathing_Timer: View {
    
    @ObservedObject var activityModel: ActivityViewModel
    @Environment(\.self) var env
    
    
    @State var splitedBreathData: [String] = []
    
//    @State var breathingSeconds : [Int] = [4, 7, 8, 0]
//    //breath. hold. release. hold
//    @State var breathingRepeat : Int = 3
//    @State var totalSeconds : Float = 57
    
    @State var breathingSeconds : [Int] = []
    //breath. hold. release. hold
    @State var breathingRepeat : Int = 0
    @State var totalSeconds : Float = 0
    

    
    //setted
    @State var progressValue: Float = 0.0
    @State var countdownTimer = 1
    @State var timerRunning = true
    @State var moveToNextScreen = false
    @State var finish = false
    @State var scalePoint : Double = 1.0
    @State var breathDescription : String = "Inhale"
    @State var breathState : Int = 0
    @State var opacityAppear = false
    
    @State var animationDuration : Double = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                ZStack{
                    
                    ProgressBar(progress: self.$progressValue)
                                        .frame(width: geo.size.width/2+80, height: geo.size.width/2+80)
                                      
                    
                    LinearGradient(
                        colors: [Color(red: 93/255, green: 164/255, blue: 255/255), Color(red: 222/255, green: 230/255, blue: 255/255)],
                        startPoint: .top,
                        endPoint: .bottom
                    ).frame(width: geo.size.width/2, height: geo.size.width/2, alignment: .center)
                        .mask(
                            Circle()
                                .frame(width: geo.size.width/3, height: geo.size.width/3, alignment: .center)
                                .blur(radius: 3)
                        )
                        .scaleEffect(scalePoint)
                        .animation(.linear(duration: animationDuration), value: scalePoint)
                    NavigationLink(destination: Mindful_Breathing_Congrats(activityModel: activityModel), isActive: $moveToNextScreen) {
                        EmptyView()
                        
                    }
                    
                    Text("\(countdownTimer)")
                        .foregroundColor(.white)
                        .font(.system(size: 50))
                        .bold()
                        .onReceive(timer){ _ in
                            progressValue += 1/totalSeconds
                            
                            if countdownTimer>1 && timerRunning{
                                countdownTimer -= 1
                                Haptics.shared.play(.soft)
                     
                            }
                            else{
                                if finish {
                                    timerRunning = false
                                    moveToNextScreen = true
                                    return
                                }
                                updateTimer()
                                
                                switch(breathState){
                                case 0:
                                    scalePoint = 1.5
                                    breathDescription = "Inhale"
                                    playSound(sound: "inhale", type: "wav")
                                    Haptics.shared.play(.heavy)
                                    if breathingSeconds[1] == 0{
                                        breathState = 2
                                    }
                                    else{
                                        breathState = 1
                                    }
                                case 1:
                                    Haptics.shared.play(.medium)
                                    scalePoint = 1.5
                                    breathState = 2
                                    playSound(sound: "hold", type: "wav")
                                    breathDescription = "Hold"
                                case 2:
                                    Haptics.shared.play(.heavy)
                                    scalePoint = 1
                                    playSound(sound: "exhale", type: "wav")
                                    breathDescription = "Exhale"
                                    if breathingSeconds[3] == 0{
                                        breathState = 0
                                        breathingRepeat-=1
                                        finish = breathingRepeat==0 ? true : false
                                    }else{
                                        breathState = 3
                                    }
                                case 3:
                                    Haptics.shared.play(.soft)
                                    scalePoint = 1
                                    breathState = 0
                                    breathingRepeat-=1
                                    playSound(sound: "hold", type: "wav")
                                    breathDescription = "Hold"
                                    finish = breathingRepeat==0 ? true : false
                                default:
                                    print("fail")
                                }
                                Haptics.shared.play(.light)
                            }
                        }
                    
                }
                .padding(.bottom,40)
                .onAppear{
                    withAnimation(Animation.spring().speed(0.06)) {
                        opacityAppear.toggle()
                    }
                }
                .opacity(opacityAppear ? 1:0)
                
                
                Text(breathDescription)
                    .bold()
                    .opacity(opacityAppear ? 1:0.1)
                    .font(.system(size: 36))
                    .foregroundColor(Color(red: 180/255, green: 194/255, blue: 253/255))
                    .padding(.bottom, 50)
                
                //)
            }.navigationTitle(activityModel.selectedActivity.title ?? "Breathing")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }.onAppear(perform: {
            
            var splitted = activityModel.selectedActivity.breathingData?.components(separatedBy: "-")
            var totalSecondsSplitted = 0
            
            print(splitted)
            
            for (index, split) in splitted!.enumerated() {
                if index != 4{
                    totalSecondsSplitted = totalSecondsSplitted + Int(split)!
                    breathingSeconds.append(Int(split)!)
                } else {
                    totalSecondsSplitted = totalSecondsSplitted * Int(split)!
                    breathingRepeat = Int(split)!
                }
            }

            totalSeconds = Float(totalSecondsSplitted)
            
        })
    }
    
    func updateTimer(){
        switch(breathState){
        case 0:
            countdownTimer = breathingSeconds[0]
        case 1:
            countdownTimer = breathingSeconds[1]
        case 2:
            countdownTimer = breathingSeconds[2]
        case 3:
            countdownTimer = breathingSeconds[3]
        default:
            print("fail")
        }
        animationDuration = Double(countdownTimer)
    }
    
    class Haptics {
        static let shared = Haptics()
        
        private init() { }
        
        func play(_ feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
            UIImpactFeedbackGenerator(style: feedbackStyle).impactOccurred()
        }
    }


}

struct ProgressBar: View {
    @Binding var progress: Float
    
    var body: some View {
        GeometryReader{ geo in
            ZStack {
                Circle()
                    .stroke(lineWidth: 25.0)
                    .foregroundColor(Color(red: 214/255, green: 231/255, blue: 255/255))
                    .blur(radius: 3)
                
                Circle()
                        .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                        .stroke(style: StrokeStyle(lineWidth: 25.0, lineCap: .round, lineJoin: .round))
                        .blur(radius: 3)
                        .foregroundColor(Color(red: 172/255, green: 207/255, blue: 255/255))
                        .rotationEffect(Angle(degrees: 270.0))
                        .animation(.linear(duration: 1.0))
                
            }.animation(.linear(duration: 1.0))
        }
    }
    
    
}



struct Mindful_Breathing_Timer_Previews: PreviewProvider {
    static var previews: some View {
        Mindful_Breathing_Timer(activityModel: ActivityViewModel())
    }
}
