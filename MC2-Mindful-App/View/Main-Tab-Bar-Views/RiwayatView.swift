//
//  RiwayatView.swift
//  dashboard
//
//  Created by Jovinca Claudia on 26/06/22.
//

import SwiftUI
import HalfASheet
import WrappingHStack
import SwiftUIBottomSheet

struct RiwayatView: View {
    
    @Environment(\.self) var env
    
    @StateObject var activityModel = ActivityViewModel()
    @State private var showFilterSheet: Bool = false
    
    
    // test Year Month Picker
    @State var selectedYear: Int = Calendar.current.component(.year, from: Date())
    @State var selectedMonth: String = Date().month
    
    let months: [String] = Calendar.current.shortMonthSymbols
    @State var dateRange: Range<Date>
    
    // Mark : Matched Geometry Namespace
    @Namespace var animation
    
    
//    let sheet = BottomSheet(
//         isExpanded: $showFilterSheet,
//         minHeight: .points(100),
//         maxHeight: .available,
//         style: .standard
//     )
    
    
    var body: some View {
//        ZStack{
        
        VStack{
            
            VStack{
        HStack(){
            
            
        Text("Riwayat Aktivitas")
            .font(.title2)
            .bold()
            .foregroundColor(Color(UIColor(named:"darkBrown")!))
            .frame(maxWidth:.infinity, alignment : .leading)
            
//                .padding([.top,.leading] ,30)
        
            
            Button {
                showFilterSheet = true
            }
        label: {
            Image(systemName:"slider.horizontal.3")
                .resizable()
                .scaledToFit()
                .frame(width: 22)
                .foregroundColor(Color(UIColor(named:"darkBrown")!))
            
        }
            
        }
        
        .padding(.horizontal,20)
        .padding(.top,20)
        .padding(.bottom,5)
   

            
            VStack{
                       Group {
                           HStack {
                               Image(systemName: "chevron.left")
                                   .foregroundColor(.black)
                                   .frame(width: 24.0)
                                   .onTapGesture {
                                       withAnimation {
                                       selectedYear -= 1;
                                       
                                       activityModel.selectedYear = selectedYear
                                       
                  
                                       activityModel.loadUserActivities()
                                           
                                       }
//                                       selectedMonth = ""
                                       
                                       
                                   }
                               Spacer()
                               Text(String(selectedYear))               .foregroundColor(.black).bold()
//                                   .multilineTextAlignment(.center)
                                   .transition(.move(edge: .trailing))
                               Spacer()
                               Image(systemName: "chevron.right")
                                   .foregroundColor(.black)
                                   .frame(width: 24.0)
                                   .onTapGesture {
                                       withAnimation {
                                       selectedYear += 1;
                                       activityModel.selectedYear = selectedYear
                               
                                       activityModel.loadUserActivities()
                                       }
//                                       selectedMonth = ""
                                   }
                           }
                           .padding(.all, 12.0)
                           
   
                       }
                       Group {
                           ScrollView(.horizontal) {
                               HStack() {
                                   ForEach(months, id: \.self) { item in
                                       Text(item)
                                           .foregroundColor((item == selectedMonth) ? .white:.gray)
                                           .bold()
                                           .font(.footnote)
                                           .padding(12)
                                           .background{
                                               if selectedMonth == item{
                                                   Rectangle()
                                                       .fill(Color("PurpleAccent"))
//
                                               }
                                               if selectedMonth != item{

                                                   Rectangle()
                                                       .fill(Color("lightGrey"))


                                               }
                                           }.cornerRadius(3)
//                                           .padding(.all, 12.0)
                                           .onTapGesture {
                                               withAnimation {

                                               self.setPeriod(selectedMonth: item)
                                               
                                               activityModel.selectedMonth = item
                                               
                                               activityModel.loadUserActivities()
                                               }
                                           }
                                   }
                               }
                           }
                       }
                
                
                Divider().padding(.top,5)
                   }
            
            
        }.background(.white)
//                   .onAppear() {
//                       selectedYear = Int(dateRange.lowerBound.yearFull)!
//                       selectedMonth = dateRange.lowerBound.monthShort
//                   }
//
//
//            Text("____")
//                .foregroundColor(.accentColor)
//                .frame(maxWidth:.infinity, alignment: .leading)
//                .padding(EdgeInsets(top: 0, leading: 30, bottom: 15, trailing: 0))
//        }
        
        ScrollView{
            
            VStack{
  
        
            //Apakah perlu dikasih navigation link???
            //Harusnya nanti di sini pakai coredata, cm sementara pake dummy dulu
            ForEach (activityModel.userActivityHistoryArray) {item in
                HStack(){
                    
                    // Untuk Daily Affirmations
                    if item.activity?.id == 1 {
                        
                        Text(item.emoji ?? "😐")
                            .font(.largeTitle)
                            .frame(maxWidth: 35, maxHeight: 35)
                            .padding(.leading, 26)
                            
             
                    }
                    // Untuk selain itu

                    else {
                        
                        Image(systemName: item.activity?.image ?? "wind")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 25, maxHeight: 25)
                            .padding(.leading, UIScreen.main.bounds.width*1/14)
                            
                        
                    }

                    
                    VStack(alignment : .leading){
                        Text(item.activity?.title ?? "")
                            .font(.headline)
                            .bold()
                        
                                
                                if item.activity?.id == 1 {

                                    Text(item.journalBody ?? "")
                                        .lineLimit(1)
                                        .font(.footnote)



                                }
                        
                                    // Untuk Scavenger Hunt
                                    else if item.activity?.id == 14{
                                        
                                        Text("Found : \(item.scavengerHuntFound) - Miss : \(item.scavengerHuntMiss)" ?? "")
                                            .lineLimit(1)
                                            .font(.footnote)
                                        
                                    }
                                    
                                    // Untuk Breathings
                                    
                        else {

                                    Text(item.activity?.type ?? "")
                                        .font(.caption)
                                    
                                }
                                
             
                        Text("\((item.timestamp ?? Date()).formatted(date: .complete, time: .omitted)) ")
                            .font(.caption)
                    }.padding([.leading, .trailing], UIScreen.main.bounds.width*1/17)
                    
                }.frame(width : UIScreen.main.bounds.width*11/12, height: 86, alignment: .leading)
                    .foregroundColor(Color.white)
                    .shadow(color: Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.2), radius: 5, x: 0, y: 4)
                    .background(Image("BGRecents")
                        .resizable()
                    )
                     
            }
            }
            
            
//            timestampSorting()
            
            
            
        }

        
    
        

        
//            frame(maxWidth:.infinity, alignment : .leading)
            
            
        
//        .navigationBarTitle("")

            
        
    }
        .bottomSheet(
            isPresented: $showFilterSheet){
            VStack(alignment: .leading) {
                HStack(alignment: .top){
                    Text("Filter").font(.headline).bold()

                    Spacer()

                    Text("Atur Ulang")
                        .foregroundColor(Color("AccentColor"))
                        .font(.headline).bold()
                        .onTapGesture {
                            withAnimation {
                            activityModel.currentTimestampEnum = .terbaru
                            activityModel.currentTypeEnum  = .all
                            activityModel.loadUserActivities()
                            showFilterSheet = false
                            }
                        }
                }
                .padding(.bottom,15)


                HStack(alignment: .top){
                    Text("Urutkan").font(.subheadline).bold()

                }


                timestampSorting()      .padding(.bottom,15)

                
                HStack(alignment: .top){
                    Text("Kategori").font(.subheadline).bold()

                }


                typeFiltering()      .padding(.bottom,15)




                Spacer()

                
                Button(action: {
                    withAnimation {
                    showFilterSheet = false
                    activityModel.loadUserActivities()
                    }
                }) {
                    Text("Filter Riwayat")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .font(.callout)
//                        .border(Color.blue)
                        .foregroundColor(.white)
                        .background(Color("AccentColor"))
                        .cornerRadius(10)
//                        .padding()
                }
                
                }.padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)




            }
    .padding(.bottom, 25)
    .background(Image("BGDashboard"))
        .onAppear(perform: {
//            let calendar = Calendar.current
//
//
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy"
//
//            let yearString = dateFormatter.string(from: dateRange.lowerBound)
//
//            selectedYear = Int(yearString)!
//
//            let dateFormatter1 = DateFormatter()
//            dateFormatter1.dateFormat = "MMM"
//            let monthString = dateFormatter1.string(from: Date())
//
//
//            selectedMonth = monthString
//
//            print("Selected Month : \(selectedMonth)")
            activityModel.loadUserActivities()
        })
//        .navigationBarTitle("")
//           .navigationBarHidden(true)
//           .navigationBarBackButtonHidden(true)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
            
            
//            HalfASheet(isPresented: $showFilterSheet, title: "Half a sheet") {
//               Text("Babi")
//            }
//    }
       
  
        
        
    }
    
    
    func setPeriod(selectedMonth: String) {
            self.selectedMonth = selectedMonth
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MMM/yyy"
            let startDate = dateFormatter.date(from: "01/" + selectedMonth + "/" + String(selectedYear))
            let endDate = startDate?.endOfMonth()
        self.dateRange = .init(uncheckedBounds: (lower: startDate!.startOfMonth(), upper: endDate!))
        }

    
    
    
    @ViewBuilder
    func timestampSorting()->some View{
        // Incase if we missed the task
        
        let tabs: [timestampEnum] = [.terbaru, .terlama]
//        HStack(spacing: 10){
//            ForEach(tabs,id: \.self){ tab in
        
        WrappingHStack(tabs, id:\.self) { tab in
            
                Text(tab.rawValue)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .scaleEffect(0.9)
                    .foregroundColor(activityModel.currentTimestampEnum == tab ? .white : .gray)
                    .padding(10)
//                    .frame(maxWidth: .infinity)
                    .background{
                        if activityModel.currentTimestampEnum == tab{
                            Rectangle()
                                .fill(Color("AccentColor"))
                                .matchedGeometryEffect(id: "timestamp", in: animation)

                        }
                        if activityModel.currentTimestampEnum != tab{

                            Rectangle()
                                .fill(Color("lightGrey"))


                        }
                    }
                    .cornerRadius(6)

                    .onTapGesture {
                        withAnimation{
                            activityModel.currentTimestampEnum = tab
                            
                            print("tab enum : \(activityModel.currentTimestampEnum)" )
//                            taskModel.loadTasks(currentTab: tab)
                        }
                    }
            
            
        }

    }
    
    
    
    
    @ViewBuilder
    func typeFiltering()->some View{
        // Incase if we missed the task
        
        let tabs: [typeEnum] = [.all, .observation, .breathingTechique , .journalling, .outdoorObservation]
//        HStack(spacing: 10){
//            ForEach(tabs,id: \.self){ tab in
        
        WrappingHStack(tabs, id:\.self) { tab in
            
            
                Text(tab.rawValue)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .scaleEffect(0.9)
                    .foregroundColor(activityModel.currentTypeEnum == tab ? .white : .gray)
            
                    .padding(10)
                    
//                    .frame(maxWidth: .infinity)
                    .background{
                        if activityModel.currentTypeEnum == tab{
                            Rectangle()
                                .fill(Color("AccentColor"))
                                .matchedGeometryEffect(id: "type", in: animation)

                        }
                        if activityModel.currentTypeEnum != tab{

                            Rectangle()
                                .fill(Color("lightGrey"))


                        }
                    }
                    .cornerRadius(6)
                    .padding(.bottom, 10)

                    .onTapGesture {
                        withAnimation{
                            activityModel.currentTypeEnum = tab
                            
                            print("tab enum : \(activityModel.currentTypeEnum)" )
//                            taskModel.loadTasks(currentTab: tab)
                        }
                    }
            
            
        }

    }
    
    
}

struct RiwayatView_Previews: PreviewProvider {
    static var previews: some View {
        RiwayatView(dateRange: .init(uncheckedBounds: (lower: Calendar.current.date(byAdding: .month, value: 2, to: Date())!.startOfMonth(), upper: Calendar.current.date(byAdding: .month, value: 2, to: Date())!.endOfMonth())))
    }
}

extension Date {

func startOfMonth() -> Date {
    let interval = Calendar.current.dateInterval(of: .month, for: self)
    return (interval?.start.toLocalTime())! // Without toLocalTime it give last months last date
}

func endOfMonth() -> Date {
    let interval = Calendar.current.dateInterval(of: .month, for: self)
    return interval!.end
}

// Convert UTC (or GMT) to local time
func toLocalTime() -> Date {
    let timezone    = TimeZone.current
    let seconds     = TimeInterval(timezone.secondsFromGMT(for: self))
    return Date(timeInterval: seconds, since: self)
}}

extension Date {
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: self)
    }
}

extension String {


    func convertDateString() -> String? {
        return convert(dateString: self, fromDateFormat: "yyyy-MM-dd'T'HH:mm:ssZ", toDateFormat: "yyyy-MM-dd")
    }


    func convert(dateString: String, fromDateFormat: String, toDateFormat: String) -> String? {

        let fromDateFormatter = DateFormatter()
        fromDateFormatter.dateFormat = fromDateFormat

        if let fromDateObject = fromDateFormatter.date(from: dateString) {

            let toDateFormatter = DateFormatter()
            toDateFormatter.dateFormat = toDateFormat

            let newDateString = toDateFormatter.string(from: fromDateObject)
            return newDateString
        }

        return nil
    }

}


