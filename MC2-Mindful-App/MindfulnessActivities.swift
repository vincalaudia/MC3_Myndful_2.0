//
//  MindfulnessActivities.swift
//  dashboard
//
//  Created by Jovinca Claudia on 01/07/22.
//

import Foundation
import SwiftUI

struct Activities : Identifiable{
    var id = UUID()
    var title : String
    var type : String
    var image : Image
    var time :String
    var description : String
    var viewDestination : AnyView
    
    init(title:String, type:String, image : Image, time:String, description : String, viewDestination:AnyView){
        self.title = title
        self.type = type
        self.image = image
        self.time = time
        self.description = description
        self.viewDestination = viewDestination
    }
}

let activities : [Activities] = [Activities(title: "Teknik Pernafasan 4-7-8", type: "Pernafasan", image: Image(systemName: "wind"), time: "20 Detik", description: "Dapat digunakan dimanapun dan kapanpun dan saat kondisi apapun. untuk lebih\ntenang dan nyaman.", viewDestination: AnyView(JournalingView())),

                                 Activities(title: "Jurnal Afirmasi Harian", type: "Kesadaran Menjurnal", image: Image(systemName: "text.book.closed.fill"), time: "1-2 menit", description: "Tuliskan keadaan anda hari ini walaupun\nhanya 1 kata. untuk lebih jujur mengenal\ndiri sendiri.", viewDestination: AnyView(JournalingView())),

                                 Activities(title: "Kesadaran Saat Berjalan", type: "Kesadaran  Mengobservasi", image: Image(systemName: "figure.walk"), time: "> 2 menit", description: "Dapat digunakan dimanapun dan kapanpun\ndan saat kondisi apapun. untuk lebih\nmengenal lingkungan sekitar anda.", viewDestination: AnyView(ComingSoonView(item: 2))),
                                 
                                 Activities(title: "Meditasi", type: "Kesadaran Meditasi", image: Image(systemName: "brain.head.profile"), time: "5 menit", description: "Ayo duduk dan berhenti sejenak untuk\nmerasakan kedamaian diri dari meditasi yang\ndapat anda lakukan di mana saja tempat\nyang tenang.", viewDestination: AnyView(ComingSoonView(item: 3))),
                                 
                                 Activities(title: "Kesadaran Produktivitas", type: "Kesadaran Mengobservasi", image: Image(systemName: "figure.stand.line.dotted.figure.stand"), time: "5 Menit", description: "Di Saat sibuknya pekerjaan  / kegiatan anda,\nberi ruang 2 menit atau lebih\nuntuk lebih memaafkan, menyadari, dan fokus ke\nlingkungan sekitar anda.", viewDestination: AnyView(ComingSoonView(item: 4))),
                                 
                                 Activities(title: "Kesadaran Saat Ngemil", type: "Kesadaran Mengobservasi", image: Image(systemName: "fork.knife"), time: "2 Menit", description: "Gunakan seluruh indera Anda untuk\nmenikmati camilan. Fokus pada aroma, rasa,\ntekstur, bentuk, dan warna makanannya,\nagar Anda dapat benar-benar menikmati\ncamilannya. Dan ingat, selalu tanyakan pada\ndiri sendiri apakah Anda merasa puas.", viewDestination: AnyView(ComingSoonView(item: 5))),
                                 
                                 Activities(title: "Kesadaran Saat Makan", type: "Kesadaran Mengobservasi", image: Image(systemName: "fork.knife"), time: ">15 Menit", description: "Siapkan makanan pagi / siang / sore lalu\nnikmati secara perlahan dan mulai\nmengecap di lidah anda untuk menstimulus\nperasaan anda terhadap makanan yang anda\nnikmati.", viewDestination: AnyView(ComingSoonView(item: 6))),
                                 
                                 Activities(title: "Permainan Suara", type: "Kesadaran Mengobservasi", image: Image(systemName: "ear.and.waveform"), time: "2 Menit", description: "Tugas anda adalah memejamkan mata dan\nmenggambarkan bagaimana tekstur objek\ndan menebaknya dari suara tersebut. ", viewDestination: AnyView(ComingSoonView(item: 7)))
]
                              
