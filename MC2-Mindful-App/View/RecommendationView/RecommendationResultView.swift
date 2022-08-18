//
//  RecommendationResultView.swift
//  MC2-Mindful-App
//
//  Created by Muhammad Nur Faqqih on 01/08/22.
//

import SwiftUI

struct RecommendationResultView: View {
    
    @ObservedObject var activityModel: ActivityViewModel
    @State var data: [Activity] = []

    // MArk : Environment Values
    @Environment(\.self) var env
    
    @State var slideGesture: CGSize = CGSize.zero
    @State var curSlideIndex = 0
    var distance: CGFloat = UIScreen.main.bounds.size.width
    
    
    let mood : String
    let timeHave : Int
    var body: some View {
        VStack{
           
            
            GeometryReader { geo in
            VStack {
           
//                Color(.systemBackground).edgesIgnoringSafeArea(.all)
                
                ZStack(alignment: .center) {
                    ForEach(0..<data.count, id: \.self) { i in
                        
                        RecommendedActivityCarouselView(data: self.data[i])
                            .offset(x: CGFloat(i) * self.distance)
                            .offset(x: self.slideGesture.width - CGFloat(self.curSlideIndex) * self.distance)
                            .animation(.spring())
                            .gesture(DragGesture().onChanged{ value in
                                self.slideGesture = value.translation
                            }
                                     
                            .onEnded{ value in
                                if self.slideGesture.width < -50 {
                                    if self.curSlideIndex < self.data.count - 1 {
                                        withAnimation {
                                            self.curSlideIndex += 1
                                        }
                                    }
                                }
                                
                                if self.slideGesture.width > 50 {
                                    if self.curSlideIndex > 0 {
                                        withAnimation {
                                            self.curSlideIndex -= 1
                                        }
                                    }
                                }
                                self.slideGesture = .zero
                            })
                        
                    }
                    
                }
                
                

            }.padding(.top, 35)
                    .frame(maxHeight: geo.size.height * 1,alignment: .center)
            
            
            }
            
            
//            VStack{
//                            VStack {
//
//                                Spacer()
                                self.progressView()
                                    .padding(.vertical,24.0)
                                    .padding(.bottom,  20)
//            }
            //                    HStack {
            //
            //                        Button(action: nextButton) {
            //                            self.arrowView()
            //                        }
            //                    }
//                            }
//                            .padding(20)
  
        }
        .frame(maxHeight: .infinity,alignment: .center)
        .navigationTitle("Rekomendasi")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            activityModel.loadRecommendedActivities(mood: mood, timeHave: timeHave)
            print(activityModel.recommendedActivities)
            
            data = activityModel.recommendedActivities
        })
    }
    
    
    func nextButton() {
        if self.curSlideIndex == self.data.count - 1 {
            return
        }
        
        if self.curSlideIndex < self.data.count  - 1 {
            withAnimation {
                self.curSlideIndex += 1
            }
        }
    }
    
//    func arrowView() -> some View {
//        Group {
//            if self.curSlideIndex == self.data.count  - 1 {
//                HStack {
//                    Text("Let's Start")
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity, alignment: .center)
//                }
//                .padding([.leading, .trailing],6.0)
//                .padding(.vertical,13)
//                .padding(.horizontal,13)
//                .background(
//                    RoundedRectangle(cornerRadius: 32.0)
//                        .fill(Color.blue)
//                )
//                .padding([.leading, .trailing],16.0)
//
//            } else {
//                HStack{
//                    Text("Skip")
//                        .fontWeight(.medium)
//                        .foregroundColor(.gray)
//                        .frame(maxWidth: .infinity, alignment: .center)
//                HStack {
//                    Text("Next")
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity, alignment: .center)
//                }
//                .padding([.leading, .trailing],6.0)
//                .padding(.vertical,13)
//                .padding(.horizontal,13)
//                .background(
//                    RoundedRectangle(cornerRadius: 8.0)
//                        .fill(Color.blue)
//                )
//            }
//                .padding(.trailing,24)
//            }
//        }
//    }
    
    func progressView() -> some View {
        HStack {
            ForEach(0..<data.count, id: \.self) { i in
                if i == curSlideIndex{
                Rectangle()
                        .frame(width: 20, height: 10)
                        .cornerRadius(10)
                        .foregroundColor(.blue)
                } else {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.gray)
                    
                }
            }
        }
    }
    
    
    @ViewBuilder
    func RecommendedActivityCarouselView(data: Activity)->some View{
        // Incase if we missed the task
   

         
        VStack(alignment: .center){
            
            VStack{
                Image(systemName: data.image ?? "wind")
                .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .padding(.bottom, 40)


                
            }.padding(10)
            
            
            VStack{
                
      
                
                //                VStack(alignment : .leading){
                                    Text(data.title ?? "")
                                    .font(.title2)
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .padding(.vertical, 30)
//                                    .padding(.horizontal, 20)

                                    Text(data.activityDescription ?? "")
                                    .font(.subheadline)

                                .multilineTextAlignment(.center)
                                        .padding(.bottom, 30)
//                                        .padding(.horizontal, 20)
                //                }.padding([.leading, .trailing], 20)
                
      
        VStack{
            
            
            
            
            
                HStack {
                    
//                    Text("Let's Start")
//                                    .fontWeight(.bold)
//                                    .foregroundColor(Color("AccentColor"))
//                                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    
                    
                    if (data.viewDestination == "Mindful_Breathing_Intro" ){
                        NavigationLink(destination: Mindful_Breathing_Intro(activityModel: activityModel)){
                            Text("Mulai")
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("AccentColor"))
                                            .frame(maxWidth: .infinity, alignment: .center)
                                    }.simultaneousGesture(TapGesture().onEnded{
                                        
                                        activityModel.selectedActivity = data
                                        print(activityModel.selectedActivity)
                                    })
                            
                        
          
                    } else if (data.viewDestination == "JournalingView" ){
                        NavigationLink(destination: JournalingView(activityModel: activityModel)){
                            Text("Mulai")
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("AccentColor"))
                                            .frame(maxWidth: .infinity, alignment: .center)
                                    }.simultaneousGesture(TapGesture().onEnded{
                                        
                                        activityModel.selectedActivity = data
                                        print(activityModel.selectedActivity)
                                    })
                            

                    }
                    
                    else if (data.viewDestination == "ScavengerHunt" ){
                        NavigationLink(destination: ScavengerHunt(activityModel: activityModel)){
                            Text("Mulai")
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("AccentColor"))
                                            .frame(maxWidth: .infinity, alignment: .center)
//                                            .disabled(true)
                                    }.simultaneousGesture(TapGesture().onEnded{
                                        
                                        activityModel.selectedActivity = data
                                        print(activityModel.selectedActivity)
                                    })
                            
                                
                    }
                    
                    else if (data.viewDestination == "ComingSoonView" ){
                        NavigationLink(destination: ComingSoonView(item: data)){
                            Text("Segera Hadir")
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("AccentColor"))
                                            .frame(maxWidth: .infinity, alignment: .center)
//                                            .disabled(true)
                                    }.simultaneousGesture(TapGesture().onEnded{
                                        
                                        activityModel.selectedActivity = data
                                        print(activityModel.selectedActivity)
                                    })
                            
                                
                    }
    
                            }
 
                    
                    
                    
                    
                    
                    
                            }
                .frame(alignment: .bottom)
//                            .padding([.leading, .trailing],6.0)
                            .padding(.vertical,13)
                            .padding(.horizontal,13)
                            .background(
                                RoundedRectangle(cornerRadius: 32.0)
                                    .fill(Color.white)
                            )
                    
//                            .padding([.leading, .trailing],16.0)
                
                
            }.padding(.bottom, 25)
                .padding(.horizontal, 25)
        
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .background(LinearGradient(
                colors: [Color(red: 180/255, green: 194/255, blue: 253/255), Color(red: 122/255, green: 181/255, blue: 252/255)],
                startPoint: .top,
                endPoint: .bottom
                
            ))
                .cornerRadius(30)
                .padding(.horizontal,30)
//                .padding(.vertical,30)
                .foregroundColor(Color.white)
                .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.2), radius: 5, x: 0, y: 4)
//                .background(Image("BGRecents")
//                    .resizable()
//                )
        
            
    }
    
}

struct RecommendationResultView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationResultView(activityModel: ActivityViewModel(), mood: "normal", timeHave: 3)
    }
}
