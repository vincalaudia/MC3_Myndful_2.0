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

let activities : [Activities] = [Activities(title: "Mindful Breathing 4-7-8", type: "Pernafasan", image: Image(systemName: "wind"), time: "1 menit", description: "Dapat digunakan dimanapun dan kapanpun dan saat kondisi apapun. untuk lebih\ntenang dan nyaman.", viewDestination: AnyView(JournalingView()))]


