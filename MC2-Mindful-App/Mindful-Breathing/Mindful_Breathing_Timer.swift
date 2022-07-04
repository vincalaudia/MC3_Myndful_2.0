//
//  Mindful_Breathing_Timer.swift
//  MC2-Mindful-App
//
//  Created by Billi Umar Daeli on 04/07/22.
//

import SwiftUI

struct Mindful_Breathing_Timer: View {
    @State var tarikNafas: String = "Tarik Nafas"
    @State var brethingFinish: Bool = false
    @State var moveToNextScreen: Bool = false
    @State var buttonColor: Color = .blue
    @State var buttonRadius: CGFloat = 0
    @State var scalePoint: Double = 1
    @State var countDownTimer = 4
    @State var animationDuration = 1.0
    @State var breathState = 0 //0: Breateh, 1: Hold, 2: Release
    @State var timerRunning = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            
            Button {
                simpleSuccess()
            } label: {
                Text("\(countDownTimer)")
                    .frame(width: 150, height: 150, alignment: .center)
                    .background(LinearGradient(
                        colors: [Color(red: 180/255, green: 194/255, blue: 253/255), Color(red: 122/255, green: 181/255, blue: 252/255)],
                        startPoint: .top,
                        endPoint: .bottom
                    ))
                    .cornerRadius(75)
                    .font(.system(size: 40))
                    .tint(.white)
                    .onReceive(timer)
                { _ in
                    if countDownTimer > 1 && timerRunning {
                        countDownTimer -= 1
                        
                    } else {
                        timerRunning = false
                        
                        if brethingFinish {
                            moveToNextScreen = true
                            return
                        }
                        resetTimer()
                        switch(breathState){
                        case 0:
                            scalePoint = 1.5
                            breathState = 1
                        case 1:
                            scalePoint = 1.5
                            breathState = 2
                        case 2:
                            scalePoint = 1
                            breathState = 0
                            brethingFinish = true
                        default:
                            print("fail")
                        }
                            
                            timerRunning = true
                    }
                    
                }
            }
            .scaleEffect(scalePoint)
            .animation(.linear(duration: animationDuration), value: scalePoint)
            .padding()

            NavigationLink(destination: Mindful_Breathing_Congrats(), isActive: $moveToNextScreen) {
                EmptyView()
                
            }
        }.onAppear {
            
           
        }
        
    }
    
    func resetTimer() {
        switch(breathState){
        case 0:
            countDownTimer = 4
        case 1:
            countDownTimer = 7
        case 2:
            countDownTimer = 8
        default:
            print("fail")
        }
        
        animationDuration = Double(countDownTimer)
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

struct Mindful_Breathing_Timer_Previews: PreviewProvider {
    static var previews: some View {
        Mindful_Breathing_Timer()
    }
}

