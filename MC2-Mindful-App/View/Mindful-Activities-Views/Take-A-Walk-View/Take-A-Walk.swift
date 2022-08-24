//
//  Take-A-Walk.swift
//  MC2-Mindful-App
//
//  Created by Jovinca Claudia on 23/08/22.
//

import SwiftUI

struct Take_A_Walk: View {
    @ObservedObject var activityModel: ActivityViewModel
    @State var moveToNextScreen = false
    
    //stopwatch
    @ObservedObject var stopWatch = StopWatch()
    @State var isPaused = false
    
    @State var animate = false
    @State var animate2 = false
    
    var body: some View {
        ZStack(alignment: .bottom){
            LinearGradient(
                colors: [Color(red: 93/255, green: 164/255, blue: 255/255), Color(red: 222/255, green: 230/255, blue: 255/255)],
                startPoint: .top,
                endPoint: .bottom
            ).frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                .opacity(0.6)
            
            WaveForm(color: .white, amplify: 12, geser: -110)
            
            LinearGradient(
                colors: [Color(red: 93/255, green: 164/255, blue: 255/255), Color(red: 222/255, green: 230/255, blue: 255/255)],
                startPoint: .top,
                endPoint: .bottom
            ).frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                .opacity(0.6)
                .mask(
                    WaveForm(color: .white, amplify: 17, geser: 110)
                )
            //Time
            VStack{
                Text("Teruslah berjalan dengan penuh kesadaran")
                    .bold()
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(30)
                    .padding(.bottom, UIScreen.main.bounds.height/12)
                
                Text(self.stopWatch.stopWatchTime)
                    .bold()
                    .font(.system(size: 60))
                
                StopWatchButton(actions: [self.stopWatch.start, self.stopWatch.pause],
                                labels: ["play.fill", "pause.fill"], stat: ["Start", "Pause"],
                                color: Color.white,
                                isPaused: self.stopWatch.isPaused())
                .shadow(color: Color.gray.opacity(0.2), radius: 20, x: 0, y: 0)
                
                NavigationLink(destination: CongratsView(activityModel: activityModel, image: "congrats", congratsBody: "Jadi lebih mindful dengan memerhatikan lngkungan sekitarmu!"), isActive: $moveToNextScreen) {
                    HStack{
                        Text("Selesai")
                        Image(systemName: "chevron.right")
                        
                    }.frame(width: UIScreen.main.bounds.size.width / 2 - 20, height: 50)
                        .foregroundColor(Color.blue)
                        .background(Color.white)
                        .cornerRadius(7)
                        .shadow(color: Color.gray.opacity(0.2), radius: 20, x: 0, y: 0)
                    
                }.simultaneousGesture(TapGesture().onEnded{
                    activityModel.timeWalk = self.stopWatch.stopWatchTime
                    activityModel.takeAWalk()
                    
                })
                
            }.padding(.bottom, UIScreen.main.bounds.height/2 - 130)
            
            
            HStack(){
                Image("leftStep")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 110)
                    .opacity(self.animate ? 0.3 : 0)
                    .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: true))
                
                Image("rightStep")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 110)
                    .opacity(self.animate2 ? 0.3 : 0)
                    .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: true))
            }
            .padding(.bottom, UIScreen.main.bounds.height/12)
            .onAppear(){
                self.animate.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.animate2 = true                  // << here !!
                }
            }
            
        }.edgesIgnoringSafeArea(.all) // fill past all edges
    }
    
}

struct WaveForm: View{
    var color : Color
    var amplify : CGFloat
    var geser : CGFloat
    
    var body: some View{
        TimelineView(.animation){timeline in
            Canvas{context, size in
                //get current time
                let timeNow = timeline.date.timeIntervalSinceReferenceDate
                
                let angle = timeNow.remainder(dividingBy: 2)
                let offset = angle*size.height
                Circle().frame(width: 50, height: 50, alignment: .center)
                
                context.translateBy(x: geser, y: offset)
                
                context.fill(getPath(size: size), with: .color(color))
                context.translateBy(x: 0, y: -size.height)
                
                context.fill(getPath(size: size), with: .color(color))
                context.translateBy(x: 0, y: size.height * 2)
                
                
                context.fill(getPath(size: size), with: .color(color))
                
            }
            
        }
    }
    
    func getPath(size: CGSize) -> Path{
        return Path{path in
            let midWidth = size.width / 2
            let height = size.height
            
            //move wave to center leading
            path.move(to: CGPoint(x: midWidth, y: 0))
            
            path.addCurve(to: CGPoint(x: midWidth, y: height),
                          control1: CGPoint(x: midWidth + amplify, y: height * 0.5),
                          control2: CGPoint(x: midWidth - amplify, y: height * 0.5))
            
            //filling the bottom of remaining area
            path.addLine(to: CGPoint(x: size.width+150, y: height))
            path.addLine(to: CGPoint(x: size.width+150, y: 0))
            
            
        }
    }
}

struct Take_A_Walk_Previews: PreviewProvider {
    static var previews: some View {
        Take_A_Walk(activityModel: ActivityViewModel())
    }
}
