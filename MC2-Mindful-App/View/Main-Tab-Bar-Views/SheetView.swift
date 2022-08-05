//
//  SheetView.swift
//  dashboard
//
//  Created by Jovinca Claudia on 26/06/22.
//

import SwiftUI
import EventKit

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var currentDate = Date.now
    
    
    
    var body: some View {
        NavigationView(){
            VStack(spacing : 20) {
                
                DatePicker( "Waktu", selection: $currentDate, displayedComponents: .hourAndMinute)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    
                
            }
            .navigationTitle("Pengingat")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Simpan"){
                notifikasi()
                dismiss()
                
            }
            )
            .padding(30)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Image("BGDashboard"))
        }
        
    }
    
    func notifikasi() {
        // BUAT KONTEN DULU
        let content = UNMutableNotificationContent()
        content.title = "Mindfulness Memanggil"
        content.body = "Ayo lakukan aktivitas mindfulness harian mu!"
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.hour, .minute], from: currentDate), repeats: true)
        

        let randomIdentifier = UUID().uuidString
        let request = UNNotificationRequest(identifier: randomIdentifier, content: content, trigger: trigger)
        
        
        UNUserNotificationCenter.current().add(request) { error in
          if error != nil {
            print("something went wrong")
          }
        }
    }
    
}


struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
    }
}
