//
//  Recommendation1View.swift
//  MC2-Mindful-App
//
//  Created by Angel Ria Purnamasari on 02/07/22.
//

import SwiftUI

struct RecommendationView: View {
    
    
    @StateObject var activityModel = ActivityViewModel()
    

    // MArk : Environment Values
    @Environment(\.self) var env
    

    
    
    var body: some View {
        VStack(alignment: .center){
            Image("MC2")
                .padding(.top, 55)
                .scaledToFit()
        
            if activityModel.moodForRecommendation == "" {
        VStack{
            
            
            Text("Bagaimana Perasaanmu Hari ini ?")
                .fontWeight(.bold)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding(.horizontal,35)
                .padding(.top, 25)
                .padding(.bottom, 13)
            
            HStack{
                
                VStack{
                    Image("MC2-smile-1").scaledToFit()
                    
                    
                    Text("Bahagia").fontWeight(.bold)
                        .font(.title3)
                    
                }.onTapGesture {
                    withAnimation{
                        
                        activityModel.moodForRecommendation = "bahagia"
                        
                    }
                  
                }.padding(.horizontal, 20)
                
                VStack{
                    Image("MC2-neutral-1").scaledToFit()
                    
                    Text("Normal")      .fontWeight(.bold)
                        .font(.title3)
                    
                }.onTapGesture {
                    withAnimation{
                        
                        activityModel.moodForRecommendation = "normal"
                        
                    }
                  
                }.padding(.horizontal, 20)
                
                
                VStack{
                    Image("MC2-sad-1").scaledToFit()
                    
                    Text("Sedih")      .fontWeight(.bold)
                        .font(.title3)
                    
                }.onTapGesture {
                    withAnimation{
                        
                        activityModel.moodForRecommendation = "sedih"
                        
                    }
                  
                }.padding(.horizontal, 20)
                
//                VStack{
//                    Text("Taik")
//                    Text("ucing")
//
//                }
//
//
//                VStack{
//                    Text("Taik")
//                    Text("ucing")
//
//                }
                
                
            }.frame(maxWidth: .infinity, alignment: .center)
                
    }
                
            }
            
            if activityModel.moodForRecommendation != "" {
                VStack{
                    
                    
                    Text("Apa Kamu punya waktu lebih dari 2 menit ?")
                        .fontWeight(.bold)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal,35)
                        .padding(.top, 25)
                        .padding(.bottom, 10)
                    
                    HStack{
                        
                        VStack{
                            NavigationLink(destination: RecommendationResultView(activityModel: activityModel, mood: activityModel.moodForRecommendation, timeHave: 3)) {

                            Image("MC2-ok").scaledToFit()
                
                                
                            }
                            
                            Text("> 2").fontWeight(.bold)
                                .font(.title3)
                            
                        }.padding(.horizontal, 17)
                        
                        
                     
                        
                        VStack{
                            NavigationLink(destination: RecommendationResultView(activityModel: activityModel,mood: activityModel.moodForRecommendation, timeHave: 1)) {

                            Image("MC2-not-ok").scaledToFit()
                                
                            }
                            
                            Text("< 2")
                                .fontWeight(.bold)
                                .font(.title3)
                            
                        }.padding(.horizontal, 17)
                        
                        
                 
                        
        //                VStack{
        //                    Text("Taik")
        //                    Text("ucing")
        //
        //                }
        //
        //
        //                VStack{
        //                    Text("Taik")
        //                    Text("ucing")
        //
        //                }
                        
                        
                    }
                        
            }
                
                
            }
//
//            Text(data.text)
//                .font(.system(size: 17))
//                .fontWeight(.regular)
//                .foregroundColor(.gray)
//                .padding(.horizontal)
//                .multilineTextAlignment(.center)
        }
        .onAppear(perform: {
            activityModel.moodForRecommendation = ""
            activityModel.timeHave = 0
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Image("BGDashboard").blur(radius: 20))
            .navigationTitle("Tanya")
            .navigationBarTitleDisplayMode(.inline)
     
    }
}

struct RecommendationView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationView()
    }
}
