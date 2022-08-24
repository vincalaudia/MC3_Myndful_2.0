//
//  MainView.swift
//  dashboard
//
//  Created by Jovinca Claudia on 26/06/22.
//

import SwiftUI

struct MainView: View {
    //Main View untuk segala yang punya tab bar : dashboard, list activities, and history
    @AppStorage("isBreathingIntroStarted") private var isBreathingIntroStarted: Bool = false
    // Hold the state for which tab is active/selected
    @State var selection: Int = 0
    
    var body: some View {
        NavigationView{
            //             Your native TabView here
            if isBreathingIntroStarted{
                
                TabView(selection: $selection) {
                    BerandaView()
                        .tag(0)
                    
                    MindfulView()
                        .tag(1)
                    
                    RiwayatView(dateRange: .init(uncheckedBounds: (lower: Calendar.current.date(byAdding: .month, value: 2, to: Date())!.startOfMonth(), upper: Calendar.current.date(byAdding: .month, value: 2, to: Date())!.endOfMonth())))
                        .tag(2)
                    
                }
                
                .overlay( // Overlay the custom TabView component here
                    Color.white // Base color for Tab Bar
                        .edgesIgnoringSafeArea(.vertical)
                        .frame(height: 100) // Match Height of native bar
                        .cornerRadius(radius: 20.0, corners: [.topLeft, .topRight])
                        .padding(.bottom, -35)
                        .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.05), radius: 5, x: 0, y: -5)
                        .overlay(HStack(spacing : 75) {
                            
                            // First Tab Button
                            Button(action: {
                                self.selection = 0
                            }, label: {
                                VStack{
                                    Image(selection == 0 ? "Home":"Home2")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25, height: 25, alignment: .center)
                                    Text("Beranda")
                                        .font(.caption)
                                        .opacity(selection == 0 ? 1 : 0.5)
                                }.foregroundColor(selection == 0 ? Color(red: 167/255, green: 176/255, blue: 249/255) : Color.gray)
                                    .padding(.top, 10)
                            })
                            
                            // Second Tab Button
                            Button(action: {
                                self.selection = 1
                            }, label: {
                                VStack{
                                    Image(selection == 1 ? "Category":"Category2")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25, height: 25, alignment: .center)
                                    Text("Mindful")
                                        .font(.caption)
                                        .opacity(selection == 1 ? 1 : 0.5)
                                    
                                }.foregroundColor(selection == 1 ? Color(red: 167/255, green: 176/255, blue: 249/255): Color.gray)
                                    .padding(.top, 10)
                            })
                            
                            
                            // Third Tab Button
                            Button(action: {
                                self.selection = 2
                            }, label: {
                                VStack{
                                    Image(selection == 2 ? "Document":"Document2")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25, height: 25, alignment: .center)
                                    Text("Riwayat")
                                        .font(.caption)
                                        .opacity(selection == 2 ? 1 : 0.5)
                                    
                                }
                            })
                            .foregroundColor(selection == 2 ? Color(red: 167/255, green: 176/255, blue: 249/255) : Color.gray)
                            .padding(.top, 10)
                            
                        }
                                )
                    ,alignment: .bottom)
            } else if  !isBreathingIntroStarted{
                Breathing_Intro_Screen()
            }
            //                    .navigationBarHidden(true)
            //                    .navigationBarBackButtonHidden(true)
            // Align the overlay to bottom to ensure tab bar stays pinned.
            
        }.navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        
        
    }
}

//dari sini----
struct CornerRadiusShape: Shape {
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}
//---sampe sini cuma buat bikin rounded corner wkwkw

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
