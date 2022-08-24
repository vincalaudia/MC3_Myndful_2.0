//
//  OnboardingStepView.swift
//  MC2-Mindful-App
//
//  Created by Benni L M Sinaga on 05/07/22.
//

import SwiftUI

struct OnboardingStepView: View {
    var data: OnboardingDataModel
    
    var body: some View {
        VStack {
            Image(data.image)
                .resizable()
                .scaledToFit()
                .padding(.bottom, 36)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
            
            Text(data.heading)
                .font(.system(size: 25))
                .fontWeight(.bold)
                .padding(.bottom, 8)
            
            Text(data.text)
                .font(.system(size: 17))
                .fontWeight(.regular)
                .foregroundColor(.gray)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
        }
        .padding(.top, -70.0)
    }
}

struct OnboardingStepView_Previews: PreviewProvider {
    static var data = OnboardingDataModel.data[0]
    static var previews: some View {
        OnboardingStepView(data: data)
    }
}
