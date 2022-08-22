//
//  Mindful_Breathing_Intro.swift
//  MC2-Mindful-App
//
//  Created by Billi Umar Daeli on 04/07/22.
//

import SwiftUI

struct IntroActivityView: View {
    @ObservedObject var activityModel: ActivityViewModel
    
    
    var body: some View {
        VStack(alignment: .center){
            
            Spacer()
            Image ("Meditating")
                .resizable()
                .frame(maxWidth: .infinity, alignment: .center)
                .aspectRatio(contentMode: .fit)
                .padding(.top, 80)
                .padding(20)
            
            Text("Ayo Kita Mulai \nLatihan \(activityModel.selectedActivity.title ?? "")")
                .fontWeight(.bold)
                .font(.system(size: 24))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("\(activityModel.selectedActivity.activityDescription ?? "")")
                .fontWeight(.bold)
                .font(.subheadline)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
            
            //di sini nanti var nya diganti tergantung berapa detikannya sih
//            NavigationLink(destination: Mindful_Breathing_Timer(activityModel: activityModel)) {
//                Text("Ayo Mulai").frame(height: 50).padding([.leading, .trailing], 80)
//                    .background(Color.white)
//                    .cornerRadius(30)
//            }  .padding(.bottom,50)
            
            
            if (activityModel.selectedActivity.viewDestination == "Mindful_Breathing_Timer" ){
                
                NavigationLink(destination: Mindful_Breathing_Timer(activityModel: activityModel)) {
                    Text("Ayo Mulai").frame(height: 50).padding([.leading, .trailing], 80)
                        .background(Color.white)
                        .cornerRadius(30)
                }  .padding(.bottom,50)
                
//                ActivityCard(item: item, viewDestination: AnyView(Mindful_Breathing_Intro(activityModel: activityModel)))
                
            } else if (activityModel.selectedActivity.viewDestination == "JournalingView" ){
//                ActivityCard(item: item, viewDestination: AnyView(JournalingView(activityModel: activityModel)))
                NavigationLink(destination: JournalingView(activityModel: activityModel)) {
                    Text("Ayo Mulai").frame(height: 50).padding([.leading, .trailing], 80)
                        .background(Color.white)
                        .cornerRadius(30)
                }  .padding(.bottom,50)
                .simultaneousGesture(TapGesture().onEnded{
                        
                        
                        activityModel.selectedActivity = activityModel.selectedActivity
                        print(activityModel.selectedActivity)
                    })

                
//                                        NavigationLink(destination: JournalingView(activityModel: activityModel)){
//                                            Text("Mulai")
//                                                            .fontWeight(.bold)
//                                                            .foregroundColor(Color("AccentColor"))
//                                                            .frame(maxWidth: .infinity, alignment: .center)
//                                                    }
            }
            
            else if (activityModel.selectedActivity.viewDestination == "ScavengerHunt" ){
    
                NavigationLink(destination: ScavengerHunt(activityModel: activityModel)) {
                    Text("Ayo Mulai").frame(height: 50).padding([.leading, .trailing], 80)
                        .background(Color.white)
                        .cornerRadius(30)
                }  .padding(.bottom,50)
                
                
//                ActivityCard(item: item, viewDestination: AnyView(ScavengerHunt(activityModel: activityModel)))
                        
            }
            
//            else if (activityModel.selectedActivity.viewDestination == "ComingSoonView" ){
//
//                ActivityCard(item: item, viewDestination: AnyView(ComingSoonView(item: item)))
//
//            }
            
            
            
            
        }.navigationBarTitle(activityModel.selectedActivity.type ?? "", displayMode: .inline)
            .frame(maxHeight: .infinity)
            .background(Image("BreathingSectionBG")
                .resizable())
            .ignoresSafeArea()
            .onAppear(perform: {
                
                print("Test : please")
                print(activityModel.selectedActivity.title)
            })
        
          
        
        
        
        
    }
}

struct IntroActivityView_Previews: PreviewProvider {
    static var previews: some View {
        IntroActivityView(activityModel: ActivityViewModel())
    }
}

