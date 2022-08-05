//
//  DurationView.swift
//  MC2-Mindful-App
//
//  Created by Angel Ria Purnamasari on 02/07/22.
//

import SwiftUI

struct DurationView: View {
    private var images = ["MC2-ok","MC2-not-ok"]
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())];
    
    var body: some View {
        NavigationView {
            VStack {
                VStack() {
                    Image("MC2")
                        .resizable()
                        .scaledToFit()
                }
                
                Spacer()
         
                GeometryReader { geo in
                    VStack {
                        Text("Apakah kamu punya waktu lebih dari 2 menit ?")
                            .font(.system(size: 20))
                            .padding(.top, geo.size.height * 0.09)
                            .padding(.bottom, geo.size.height * 0.08)
                            LazyVGrid(columns: gridItemLayout, spacing: 20) {
                                ForEach((0..<images.count), id: \.self) { i in

                                    Image(images[i])
                                        .resizable()
                                        .frame(width: geo.size.width * 0.15, height: geo.size.height * 0.15)
                                }
                            }
                    }
                }
                
            }
        }
    }
}

struct DurationView_Previews: PreviewProvider {
    static var previews: some View {
        DurationView()
    }
}
