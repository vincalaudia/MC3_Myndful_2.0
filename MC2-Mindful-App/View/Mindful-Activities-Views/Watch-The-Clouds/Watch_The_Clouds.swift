//
//  Watch-The-Clouds.swift
//  MC2-Mindful-App
//
//  Created by Jovinca Claudia on 16/08/22.
//

import SwiftUI
import Combine



struct Watch_The_Clouds: View {
    @ObservedObject var stopWatch = StopWatch()
    @State var isPaused = false
    @State var startAnimation = false
    @State var moveToNextScreen = false
    @ObservedObject var activityModel: ActivityViewModel
    
    @State var currentColor: Color = Color(red: 120/255, green: 190/255, blue: 255/255)
    
    var body: some View {
        ZStack(alignment: .bottom){
            currentColor
            //Clouds
            VStack{
                Spacer()
                Image("Cloud1")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.width/3, alignment: startAnimation ? .trailing : .leading)
                    .animation(Animation.easeInOut(duration: 12.0).repeatForever(autoreverses: true), value: startAnimation)
                    .padding([.top, .bottom], 5)
                    .padding(.leading, 40)
                
                Image("Cloud2")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.width/3, alignment: startAnimation ? .leading : .trailing)
                    .animation(Animation.easeInOut(duration: 15.0).repeatForever(autoreverses: true), value: startAnimation)
                    .padding(.bottom, 10)
                    .padding(.leading, 80)
                
                Image("Cloud3")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.width/3, alignment: startAnimation ? .trailing : .leading)
                    .animation(Animation.easeInOut(duration: 12.0).repeatForever(autoreverses: true), value: startAnimation)
                    .padding(.trailing, 60)
                    .padding(.bottom, 20)
                
                Image("Cloud4")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.width/3-20, alignment: startAnimation ? .leading : .trailing)
                    .animation(Animation.easeInOut(duration: 9.0).repeatForever(autoreverses: true), value: startAnimation)
                    .padding(.leading, 70)
                    .padding(.bottom, 50)
                
                Image("Cloud5")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.width/3, alignment: startAnimation ? .trailing : .leading)
                    .animation(Animation.easeInOut(duration: 17.0).repeatForever(autoreverses: true), value: startAnimation)
                
                
            }.padding(.bottom, UIScreen.main.bounds.width/2-20)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                .opacity(0.8)
            
            //Time
            VStack{
                Text("Nikmati dan ceritakan pemandangan yang anda lihat dari bentuk dan pergerakan dari awan di langit…")
                    .bold()
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
                .onAppear(){self.startAnimation.toggle()}
                
                NavigationLink(destination: CongratsView(activityModel: activityModel, image: "Meditating", congratsBody: "Jadi lebih mindful dengan memerhatikan lngkungan sekitarmu!"), isActive: $moveToNextScreen) {
                    HStack{
                        Text("Selesai")
                        Image(systemName: "chevron.right")
                        
                    }.frame(width: UIScreen.main.bounds.size.width / 2 - 20, height: 50)
                        .foregroundColor(Color.blue)
                        .background(Color.white)
                        .cornerRadius(7)
                }.simultaneousGesture(TapGesture().onEnded{
                    activityModel.timeCloud = self.stopWatch.stopWatchTime
                     activityModel.watchTheClouds()
                     
                 })
                
            }.padding(.bottom, UIScreen.main.bounds.height/2 - 130)
            
            //Picker
            ColorPickerView(chosenColor: $currentColor)
                .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
                .offset(x: 0, y: 0)
                .background(.white)
            
        }.edgesIgnoringSafeArea(.all) // fill past all edges
    }
}

struct ColorPickerView: View {
    @Binding var chosenColor: Color
    
    // 1
    @State private var isDragging: Bool = false
    @State private var startLocation: CGFloat = .zero
    @State private var dragOffset: CGSize = .zero
    
    init(chosenColor: Binding<Color>) {
        self._chosenColor = chosenColor
    }
    
    private var colors: [Color] = {
        let hueValues = Array(0...359)
        return hueValues.map {
            Color(UIColor(hue: CGFloat($0) / 359.0 ,
                          saturation: 120/255,
                          brightness: 240/255,
                          alpha: 0.8))
        }
    }()
    
    // 2
    private var circleWidth: CGFloat {
        isDragging ? 35 : 17
    }
    
    private var linearGradientWidth: CGFloat = 200
    
    /// Get the current color based on our current translation within the view
    private var currentColor: Color {
        Color(UIColor.init(hue: self.normalizeGesture() / linearGradientWidth, saturation: 120/255, brightness: 240/255, alpha: 0.8))
    }
    
    /// Normalize our gesture to be between 0 and 200, where 200 is the height.
    /// At 0, the users finger is on top and at 200 the users finger is at the bottom
    private func normalizeGesture() -> CGFloat {
        let offset = startLocation + dragOffset.width // Using our starting point, see how far we've dragged +- from there
        let maxY = max(0, offset) // We want to always be greater than 0, even if their finger goes outside our view
        let minY = min(maxY, linearGradientWidth) // We want to always max at 200 even if the finger is outside the view.
        
        return minY
    }
    
    var body: some View {
        // 3
        ZStack(alignment: .leading) {
            LinearGradient(gradient: Gradient(colors: colors),
                           startPoint: .leading,
                           endPoint: .trailing)
            .frame(width: linearGradientWidth, height:15)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5).stroke(Color.white, lineWidth: 2)
            )
            .gesture(
                DragGesture()
                    .onChanged({ (value) in
                        self.dragOffset = value.translation
                        self.startLocation = value.startLocation.x
                        self.chosenColor = self.currentColor
                        self.isDragging = true // 4
                    })
                // 5
                    .onEnded({ (_) in
                        self.isDragging = false
                    })
            )
            
            // 6
            Circle()
                .foregroundColor(self.currentColor)
                .frame(width: self.circleWidth, height: self.circleWidth, alignment: .leading)
                .shadow(radius: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: self.circleWidth / 2.0).stroke(Color.white, lineWidth: 2.0)
                )
                .offset(x: self.normalizeGesture() - self.circleWidth / 2, y: self.isDragging ? -self.circleWidth : 0.0)
                .animation(Animation.spring().speed(2))
        }
    }
}

struct Watch_The_Clouds_Previews: PreviewProvider {
    static var previews: some View {
        Watch_The_Clouds(activityModel: ActivityViewModel())
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView(chosenColor: Binding.constant(Color.white))
    }
}

