//
//  OnboardingDataModel.swift
//  MC2-Mindful-App
//
//  Created by Benni L M Sinaga on 05/07/22.
//

import Foundation
//<<<<<<< Updated upstream
//=======

struct OnboardingDataModel {
    var image: String
    var heading: String
    var text: String
}

extension OnboardingDataModel {
    static var data: [OnboardingDataModel] = [
        OnboardingDataModel(image: "slide", heading: "Dapatkan Rekomendasi", text: "Kamu bisa mendapatkan rekomendasi mindfulnes activity yang cocok denganmu"),
        OnboardingDataModel(image: "nanjak", heading: "Mudah Digunakan", text: "Dapat digunakan dimanapun dan kapanpun."),
        OnboardingDataModel(image: "anjingJalan", heading: "Bentuk Habit Baru", text: "Ayo coba berbagai macam jenis Aktivitas mindfulness."),
       
    ]
}
//>>>>>>> Stashed changes
