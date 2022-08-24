//
//  5-Senses-Exercise-View.swift
//  MC2-Mindful-App
//
//  Created by Jovinca Claudia on 24/08/22.
//

import SwiftUI

struct FiveSenseExerciseView: View {
    @State var activityModel: ActivityViewModel
    @State var moveToNextScreen = false
    
    @State var overallProgress : Float = 0
    @State var foundProgress : Float = 0
    @State var found : Int = 0
    @State var index = 4
    
    let sensesImage = ["mouth", "nose", "ear", "hand.raised", "eye"]
    let sensesText = ["Ucapkan 1 hal yang kamu rasakan dari indra pengecap mu saat ini…\n","Ucapakan 2 objek hirup baunya dengan Indra pernafasan kamu…\n","Dengarkan 3 Suara dari sekitar dengan indra pendengaran kamu…\n","Berikan Atensi pada tubuhmu dan pikirkan 4 hal yang kamu rasakan dengan indra peraba kamu…","Cari 5 objek yang  dengan indra penglihatan kamu…\n"]
    //aku kasih \n di akhir biar genap linenya ada 3
    
    var body: some View {
        VStack{
            Text("\(sensesText[index])")
                .bold()
                .padding(40)
                .multilineTextAlignment(.center)
            
            ZStack{
                NavigationLink(destination: CongratsView(activityModel: activityModel, image: "congrats", congratsBody: "Jadi lebih mindful dengan memerhatikan lngkungan sekitarmu!"), isActive: $moveToNextScreen){
                    EmptyView()
                }
                
                ProgressBar(progress: self.$foundProgress, animationDuration: 0.5)
                    .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2)
                
                ProgressBar2(progress: self.$overallProgress)
                    .frame(width: UIScreen.main.bounds.width/2 + 40, height: UIScreen.main.bounds.width/2 + 40)
                VStack{
                    Image(systemName: sensesImage[index])
                        .resizable()
                        .foregroundColor(Color(red: 155/255, green: 126/255, blue: 239/255))
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width/6, height: UIScreen.main.bounds.width/6, alignment: .center)
                    
                    Text("\(found)/\(index+1)")
                        .foregroundColor(Color(red: 123/255, green: 180/255, blue: 252/255))
                        .bold()
                        .font(.title3)
                }
                
            }
            
            Button("Ketemu"){
                found += 1
                if(found == (index+1)){
                    overallProgress += 1/5
                    foundProgress = Float(found)/Float(index+1)
                    if(index == 0){
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            moveToNextScreen = true
                            activityModel.takeAWalk()
                        }
                    }else{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            found = 0
                            index -= 1
                            foundProgress = Float(found)/Float(index+1)
                        }
                    }
                }else{
                    foundProgress = Float(found)/Float(index+1)
                }
                
                
                
            }.frame(width: UIScreen.main.bounds.width-150, height: 50, alignment: .center)
                .background(Color(red: 123/255, green: 180/255, blue: 252/255))
                .foregroundColor(.white)
                .cornerRadius(7)
                .padding(40)
        }
        
    }
}

struct FiveSenseExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        FiveSenseExerciseView(activityModel: ActivityViewModel())
    }
}
