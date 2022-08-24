//
//  Recommendation1View.swift
//  MC2-Mindful-App
//
//  Created by Angel Ria Purnamasari on 02/07/22.
//

import SwiftUI


struct RecommendationEffectModel {
    var image: String
    var effect: String
    var title: String
}

struct RecommendationTimeMoreThan2Minutes {
    var image: String
    var timeHave: Int
    var title: String
}


struct RecommendationView: View {
    
    
    @StateObject var activityModel = ActivityViewModel()
    
    let effectData: [RecommendationEffectModel] = [
        RecommendationEffectModel(image: "Tenang", effect: "Tenang", title: "Tenang"),
        RecommendationEffectModel(image: "Fokus", effect: "Fokus", title: "Fokus"),
        RecommendationEffectModel(image: "Tidur", effect: "Tidur", title: "Tidur"),
        RecommendationEffectModel(image: "Optimis", effect: "Optimis", title: "Optimis"),
        RecommendationEffectModel(image: "Kreatif", effect: "Kreatif", title: "Kreatif"),
        RecommendationEffectModel(image: "Sadar", effect: "Sadar", title: "Sadar"),
    ]

    let timeHaveData: [RecommendationTimeMoreThan2Minutes] = [
        RecommendationTimeMoreThan2Minutes(image: "Ok", timeHave: 3, title: "> 2"),
        RecommendationTimeMoreThan2Minutes(image: "NotOk", timeHave: 3, title: "< 2")
        ]

    // MArk : Environment Values
    @Environment(\.self) var env
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let columns2 = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let data = (1...6).map { "Item \($0)" }
    
    

    
    
    var body: some View {
        VStack(alignment: .center){
            Image("MeditatingNew")
                .padding(.top, 55)
                .scaledToFit()
        
            if activityModel.effectForRecommendation == "" {
        VStack{
            
            
            Text("Apa tujuan yang ingin kamu capai ? ?")
                .fontWeight(.bold)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding(.horizontal,35)
                .padding(.top, 25)
                .padding(.bottom, 13)
            
            
            
            GeometryReader { geo in
            VStack{
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(0..<effectData.count) { i in
                                        VStack(spacing : 5){
                                            VStack{
                                                Image(effectData[i].image).resizable().scaledToFit().padding(.horizontal,5)
                                            Text(effectData[i].title)
                                                    .font(.subheadline)
                                                .bold()
                                            }.padding(5)
                                        }
                                        .frame(width: geo.size.width * 0.27, height: 90, alignment: .center)
                                        .onTapGesture(perform: {
                                            
                                            withAnimation{
                                            activityModel.effectForRecommendation = effectData[i].effect
                                                
                                            }
                                        })
                                .background(.white)
                                            .cornerRadius(20)
                                            .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)
                        }
                    }
                    .padding(.horizontal)
                
            }
                
            } .padding(.horizontal)
            
            
//
//            VStack(spacing : 5){
//                Text("☺️")
//                    .font(.largeTitle)
//                Text("Senang")
//                    .font(.title3)
//                    .bold()
//            }.frame(width: 115, height: 115, alignment: .center)
//                .cornerRadius(20)
//                .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)
//
//            }
//
                
//            HStack{
                
//                VStack{
//                    Image("MC2-smile-1").scaledToFit()
//
//
//                    Text("Bahagia").fontWeight(.bold)
//                        .font(.title3)
//
//                }.onTapGesture {
//                    withAnimation{
//
//                        activityModel.moodForRecommendation = "bahagia"
//
//                    }
//
//                }.padding(.horizontal, 20)
                
//                VStack{
//                    Image("MC2-neutral-1").scaledToFit()
//
//                    Text("Normal")      .fontWeight(.bold)
//                        .font(.title3)
//
//                }.onTapGesture {
//                    withAnimation{
//
//                        activityModel.moodForRecommendation = "normal"
//
//                    }
//
//                }.padding(.horizontal, 20)
//
                
//                VStack{
//                    Image("MC2-sad-1").scaledToFit()
//
//                    Text("Sedih")      .fontWeight(.bold)
//                        .font(.title3)
//
//                }.onTapGesture {
//                    withAnimation{
//
//                        activityModel.moodForRecommendation = "sedih"
//
//                    }
//
//                }.padding(.horizontal, 20)
                
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
                
                
//            }.frame(maxWidth: .infinity, alignment: .center)
                
    }
                
            }
            
            if activityModel.effectForRecommendation != "" {
                VStack{
                    
                    
                    Text("Apa kamu punya waktu lebih dari 2 menit ??")
                        .fontWeight(.bold)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal,35)
                        .padding(.top, 25)
                        .padding(.bottom, 10)
                    
                    GeometryReader { geo in
                        VStack(alignment: .center){
                        
                        HStack(alignment: .center){
                        LazyVGrid(columns: columns2, spacing: 20) {
                            
                            
                            ForEach(0..<timeHaveData.count) { j in
                                
                                NavigationLink(destination: RecommendationResultView(activityModel: activityModel, effect: activityModel.effectForRecommendation, timeHave: timeHaveData[j].timeHave )) {
                                                VStack(spacing : 5){
                                                    VStack{
                                                        Image(timeHaveData[j].image).resizable().scaledToFit().padding(.horizontal,5)
                                                        Text(timeHaveData[j].title).foregroundColor(.black)
                                                            .font(.subheadline)
                                                        .bold()
                                                    }.padding(5)
                                                }.frame(width: geo.size.width * 0.27, height: 90, alignment: .center)
                           
                                        .background(.white)
                                                    .cornerRadius(20)
                                                    .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.1), radius: 5, x: 0, y: 4)
                            }
                                }
                            
                        }
                            }
                            .padding(.horizontal)
                        
                    }
                        
                    } .padding(.horizontal)
                    
                    
//                    HStack{
//
//                        VStack{
//                            NavigationLink(destination: RecommendationResultView(activityModel: activityModel, effect: activityModel.effectForRecommendation, timeHave: 3)) {
//
//                            Image("MC2-ok").scaledToFit()
//
//
//                            }
//
//                            Text("> 2").fontWeight(.bold)
//                                .font(.title3)
//
//                        }.padding(.horizontal, 17)
//
//
//
//
//                        VStack{
//                            NavigationLink(destination: RecommendationResultView(activityModel: activityModel,effect: activityModel.effectForRecommendation, timeHave: 1)) {
//
//                            Image("MC2-not-ok").scaledToFit()
//
//                            }
//
//                            Text("< 2")
//                                .fontWeight(.bold)
//                                .font(.title3)
//
//                        }.padding(.horizontal, 17)
//
//
//
//
//        //                VStack{
//        //                    Text("Taik")
//        //                    Text("ucing")
//        //
//        //                }
//        //
//        //
//        //                VStack{
//        //                    Text("Taik")
//        //                    Text("ucing")
//        //
//        //                }
//
//
//                    }
                        
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
            activityModel.effectForRecommendation = ""
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
