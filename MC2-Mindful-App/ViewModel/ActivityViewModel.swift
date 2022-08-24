//
//  ActivityViewModel.swift
//  MC2-Mindful-App
//
//  Created by Muhammad Nur Faqqih on 31/07/22.
//

import SwiftUI
import CoreData



enum timestampEnum: String{
    case terbaru = "Terbaru"
    case terlama = "Terlama"
}

enum timeIntEnum: String{
    case terlama = "Terlama"
    case tercepat = "Tercepat"
}

enum typeEnum: String{
    case all = "Semua"
    
    case breathingTechique = "Pernafasan"
    
    case journalling = "Jurnal"
    
    case observation = "Observasi"
    
    case outdoorObservation = "Observasi Outdoor"
}



struct TypeDummy : Identifiable{
    var id: Int
    var name : String
    
    init(id: Int, name: String){
        self.id = id
        self.name = name
    }
}


enum situationEnum: String {
    case all = "Semua"
    
    case stress = "Stress"
    
    case cemas = "Cemas"
    
    case marah = "Marah"
    
    case panik = "Panik"
    
    case kecewa = "Kecewa"
    
    case gugup = "Gugup"
    
    case senang = "Senang"
    
    case lowSelfesteem = "Low self-esteem"
    
    case negatif = "Negatif"
    
    case sedih = "Sedih"
    
    case putusAsa = "Putus asa"
    
    case emosional = "Emosional"
    
    case linglung = "Linglung"
    
}
 
enum effectEnum: String {
    case all = "Semua"
    
    case tenang = "Tenang"
    
    case fokus = "Fokus"
    
    case tidur = "Tidur"
    
    case optimis = "Optimis"
    
    case kreatif = "Kreatif"
    
    case sadar = "Sadar"
}

class ActivityViewModel: ObservableObject {
    
    // Riwayat Filter and sorting
    
    @Published var currentTimestampEnum: timestampEnum = .terbaru
    
    @Published var currentTypeEnum: typeEnum = .all

    @Published var selectedMonth: String = Date().month
    @Published var selectedYear: Int = Calendar.current.component(.year, from: Date())
    
    
//    @Published var selectedActivityType: typeEnum = .all
    
    // Activities Filter
    @Published var currentTimeIntEnum: timeIntEnum = .tercepat
    
    @Published var currentEffectEnum: effectEnum = .all
    
    @Published var currentTypeEnumActivities: typeEnum = .all
    
//    @Published var currentSituationEnum: situationEnum = .all
    
    
    
    let types : [TypeDummy] = [TypeDummy(id: 0, name: "Pernafasan"),
                               TypeDummy(id: 1, name: "Kesadaran Menjurnal"),
                               TypeDummy(id: 2, name: "Kesadaran Mengobservasi"),
                               TypeDummy(id: 3, name: "Kesadaran Meditasi")]
    
    
    
    
    private let persistenceController = PersistenceController.shared
    
    
    @Published var showCongrats: Bool = false
    
    @Published var activityArray: [Activity] = []
    @Published var selectedActivity = Activity()
    @Published var selectedUserActivityForDetail = UserActivity()
    
    @Published var userActivityHistoryArray: [UserActivity] = []
    
    @Published var recommendedActivities: [Activity] = []
    
    @Published var recentUserActivities: [UserActivity] = []
    
    // For Streak
    
    @Published var dailyStreak: Int = 0
    
    
    // For Recommendation View
    
    @Published var effectForRecommendation: String = ""
    @Published var timeHave: Int = 0
    
    // For Jounaling
    
    @Published var feeling: String = ""
    @Published var emoji: String = ""
    @Published var selectedFeeling: String = ""
    @Published var isFeelingSelected: Bool = false
    @Published var journalBody: String = "Write your story !"
    
    
    // For Scavenger Hunt
    
    @Published var found: Int = 0
    @Published var miss: Int = 0
    
    
    // For Gratitude List and Intention setting
    
    @Published var journalingListArrayToAdd: [JournalingList] = []
    @Published var journalingListName: String = ""
    
    
    func gratitudeList(){
        let context = persistenceController.container.viewContext
        let userActivity = UserActivity(context: context)
        
        userActivity.activityId = selectedActivity.id
        userActivity.id = UUID()
        userActivity.timestamp = Date()
        userActivity.activityType = selectedActivity.type
        userActivity.activity = selectedActivity
        
        
        if journalingListArrayToAdd.count != 0 {
            for journalList in journalingListArrayToAdd{
                journalList.userActivity = userActivity
            }
            
        }
        
        do {
            try context.save()

            print("User Activity (Gratitude list) has been added!")
            
        }catch{

            print("Error getting data. \(error.localizedDescription)")
        }
        
    }
    
    
    func intentionSetting(){
        let context = persistenceController.container.viewContext
        let userActivity = UserActivity(context: context)
        
        userActivity.activityId = selectedActivity.id
        userActivity.id = UUID()
        userActivity.timestamp = Date()
        userActivity.activityType = selectedActivity.type
        userActivity.activity = selectedActivity
        
        
        if journalingListArrayToAdd.count != 0 {
            for journalList in journalingListArrayToAdd{
                journalList.userActivity = userActivity
            }
            
        }
        
        do {
            try context.save()

            print("User Activity (Intention Setting) has been added!")
            
        }catch{

            print("Error getting data. \(error.localizedDescription)")
        }
        
    }
    
    
    // Bisa digunakan untuk semua macam aktivitas jurnaling yang memang membutuhkan array list
    func newJournalingList(){
        
    
    var newJournalingList: JournalingList!
    let context = persistenceController.container.viewContext
        
            journalingListArrayToAdd = journalingListArrayToAdd.sorted(by: { $0.order < $1.order })
        
            newJournalingList = JournalingList(context: context)
            newJournalingList.id = UUID()
            newJournalingList.name = journalingListName
    //            newSubtask.isComplete = false
            newJournalingList.order = (journalingListArrayToAdd.last?.order ?? 0) + 1
            
            journalingListArrayToAdd.append(newJournalingList)
//        print("Nilai last order : \(subtasks?.last?.order)")
//        newSubtask.task = task
        
        
        
//        if let _ = try? context.save(){
//
//            print("Berhasil Menambah Data Subtask!")
//            return true
//
//        }
//
//        return false
        
        
    }
    
    
    // For Watch The Clouds
    
    @Published var timeCloud: String = ""
    func watchTheClouds(){
        let context = persistenceController.container.viewContext
        let userActivity = UserActivity(context: context)
        userActivity.activityId = selectedActivity.id
        userActivity.id = UUID()
        userActivity.timestamp = Date()
        userActivity.activityType = selectedActivity.type
        userActivity.activity = selectedActivity
        
        userActivity.timeCloud = timeCloud
        
        do {
            try context.save()

            print("User Activity (Watch The Clouds) has been added!")
            
            
//            selectedActivity = Activity()
//            resetAllAttirbute()
         
        }catch{
            // If it doesn't work
            print("Error getting data. \(error.localizedDescription)")
        }
        
    }
    
    // For Take A Walk
    
    @Published var timeWalk: String = ""
    func takeAWalk(){
        let context = persistenceController.container.viewContext
        let userActivity = UserActivity(context: context)
        userActivity.activityId = selectedActivity.id
        userActivity.id = UUID()
        userActivity.timestamp = Date()
        userActivity.activityType = selectedActivity.type
        userActivity.activity = selectedActivity
        
        userActivity.timeWalk = timeWalk
        
        do {
            try context.save()

            print("User Activity (Watch The Clouds) has been added!")
            
            
//            selectedActivity = Activity()
//            resetAllAttirbute()
         
        }catch{
            // If it doesn't work
            print("Error getting data. \(error.localizedDescription)")
        }
        
    }
    
    func fiveSenseExercise(){
        let context = persistenceController.container.viewContext
        let userActivity = UserActivity(context: context)
        userActivity.activityId = selectedActivity.id
        userActivity.id = UUID()
        userActivity.timestamp = Date()
        userActivity.activityType = selectedActivity.type
        userActivity.activity = selectedActivity
        
        do {
            try context.save()

            print("User Activity (Watch The Clouds) has been added!")
            
            
//            selectedActivity = Activity()
//            resetAllAttirbute()
         
        }catch{
            // If it doesn't work
            print("Error getting data. \(error.localizedDescription)")
        }
        
    }
    
    func resetAllAttirbute(){
            feeling = ""
            emoji = ""
            selectedFeeling = ""
            isFeelingSelected = false
            journalBody = ""
                
//        selectedActivity = Activity()
    }
    
    
    // Scavenger Hunt Functions
    
    func scavengerHunt(activity: Activity){
        
        
        let context = persistenceController.container.viewContext
        let userActivity = UserActivity(context: context)
        userActivity.activityId = selectedActivity.id
        userActivity.id = UUID()
        userActivity.timestamp = Date()
        userActivity.activityType = activity.type
        userActivity.activity = selectedActivity
        userActivity.scavengerHuntFound = Int16(found)
        userActivity.scavengerHuntMiss = Int16(miss)
        
        do {
            try context.save()

            print("User Activity (Scavenger Hunt) has been added!")
            
            
//            selectedActivity = Activity()
//            resetAllAttirbute()
         
        }catch{
            // If it doesn't work
            print("Error getting data. \(error.localizedDescription)")
        }
    }
    
    
    
    //For Heartbeat
    
    @Published var heartbeatAvg: Double = 0.0
    func heartbeat(){
        let context = persistenceController.container.viewContext
        let userActivity = UserActivity(context: context)
        userActivity.activityId = selectedActivity.id
        userActivity.id = UUID()
        userActivity.timestamp = Date()
        userActivity.activityType = selectedActivity.type
        userActivity.activity = selectedActivity
        
        userActivity.heartbeatAvg = heartbeatAvg
        
        do {
            try context.save()

            print("User Activity (Watch The Clouds) has been added!")
            
            
//            selectedActivity = Activity()
//            resetAllAttirbute()
         
        }catch{
            // If it doesn't work
            print("Error getting data. \(error.localizedDescription)")
        }
        
    }
    
    
    // Journaling Functions
    
    func journaling(activity: Activity){
        print("Hihihihihih !")
        let context = persistenceController.container.viewContext

        let userActivity = UserActivity(context: context)
        userActivity.activityId = selectedActivity.id
        userActivity.id = UUID()
        userActivity.timestamp = Date()
        userActivity.emoji = emoji
        userActivity.feeling = selectedFeeling
        userActivity.journalBody = journalBody
        userActivity.activityType = activity.type
        userActivity.activity = selectedActivity
        
        do {
            try context.save()

            print("User Activity (Journaling) has been added!")
            
            
//            selectedActivity = Activity()
//            resetAllAttirbute()
         
        }catch{
            // If it doesn't work
            print("Error getting data. \(error.localizedDescription)")
        }
        
    }
    
    // Exactly looks like morning pages without image hehehe
    
    
    func morningPages(){
        print("Hihihihihih !")
        let context = persistenceController.container.viewContext

        let userActivity = UserActivity(context: context)
        userActivity.activityId = selectedActivity.id
        userActivity.id = UUID()
        userActivity.timestamp = Date()
        userActivity.journalBody = journalBody
        userActivity.activityType = selectedActivity.type
        userActivity.activity = selectedActivity
        
        do {
            try context.save()

            print("User Activity (Morning Pages) has been added!")
            
            
//            selectedActivity = Activity()
//            resetAllAttirbute()
         
        }catch{
            // If it doesn't work
            print("Error getting data. \(error.localizedDescription)")
        }
        
    }
    
    
    
    // Breathing Functions
    
    func breathing(activity: Activity){
        print("Hihihihihih !")
//        print(selectedActivity.title)
        
        let context = persistenceController.container.viewContext

        let userActivity = UserActivity(context: context)
        userActivity.id = UUID()
        userActivity.timestamp = Date()
        userActivity.activityId = activity.id
        userActivity.activity = activity
        userActivity.activityType = activity.type

        do {
            try context.save()
//            print("Saved data with id \(userActivity.id)")

            print("User Activity (Breathing) has been added!")
        }catch{
            // If it doesn't work
            print("Error getting data. \(error.localizedDescription)")
        }
        
    }
    
    
    
//    func addTypeDummy(){
//        var type: Type!
//
//        type = Type(context: persistenceController.container.viewContext)
//
//        type.id = 3
//        type.name = "Kesadaran Meditasi"
//
////                    for item in types {
////                        newType.id = Int16(item.id)
////                        newType.name = item.name
////
////                        typeArray.append(newType)
////
////                    }
//
//        if let _ = try? persistenceController.container.viewContext.save(){
//            print("Berhasil !")
//        }
//
//        print("end !")
//
//
//    }
    
    

    func loadActivities(){
        
        var selectedSort:Bool = true
        
        switch currentTimeIntEnum {
        case .terlama:
            selectedSort = false
        case .tercepat:
            selectedSort = true
        }
        
        let request = NSFetchRequest<Activity>(entityName: "Activity")
        let sort = NSSortDescriptor(key: "timeInt", ascending: selectedSort)
    
    
        
        request.sortDescriptors = [sort]
        
        
        var predicate: NSPredicate!
    

        if currentEffectEnum == .all && currentTypeEnumActivities == .all {
            // No condition
        } else if currentEffectEnum != .all && currentTypeEnumActivities != .all{
            
            predicate = NSPredicate(format: "(effect CONTAINS %@ OR type CONTAINS %@)", argumentArray:[currentEffectEnum.rawValue,currentTypeEnumActivities.rawValue])
            
            
            request.predicate = predicate
            
            
        } else if currentEffectEnum != .all && currentTypeEnumActivities == .all{
            
            predicate = NSPredicate(format: "effect CONTAINS %@", argumentArray:[currentEffectEnum.rawValue])
            
            
            request.predicate = predicate
            
            
        } else if currentEffectEnum == .all && currentTypeEnumActivities != .all{
            
            predicate = NSPredicate(format: "type CONTAINS %@", argumentArray:[currentTypeEnumActivities.rawValue])
            
            
            request.predicate = predicate
            
            
        }
        
        // this will fetch task between today and tommowrow which is 24 hours
        // 0-flase, 1-true
 
        
        do {
            try activityArray = persistenceController.container.viewContext.fetch(request)
            print("Type sukses di ambil !")
//            print(typeArrayFetched)
        }catch{
            // If it doesn't work
            print("Error getting data. \(error.localizedDescription)")
        }
    }
    
    func loadUserActivities(){
        
        var selectedSort:Bool = true
        
        switch currentTimestampEnum {
        case .terbaru:
            selectedSort = false
        case .terlama:
            selectedSort = true
        }
        
        var StringToConvert: String = ""
        
        StringToConvert = selectedMonth + " 20, " + String(selectedYear)
        
        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "id")
        dateFormatter.dateFormat = "MMM d, yyyy"
        var date = dateFormatter.date(from: StringToConvert)
//            print("Before converted : \(StringToConvert)")
//            print("After converted : \(date.addingTimeInterval(7 * 3600))")
//            var datea = date.addingTimeInterval(7 * 3600)
//            print("Start of the month : \(datea.startOfMonth())")
//            print("End of the month : \(datea.endOfMonth())")
        
        var theDate = date!.addingTimeInterval(7 * 3600)
        var startOfTheMonth = theDate.startOfMonth()
        var endOfTheMonth = theDate.endOfMonth()
        endOfTheMonth = endOfTheMonth.addingTimeInterval(25199)
//
//        print("Start : \(startOfTheMonth ?? Date())")
//        print("End : \(endOfTheMonth ?? Date())")

        
        
//        if selectedMonth == "Jan" {
//
//            StringToConvert = selectedMonth
//
//        }else if selectedMonth == "Feb" {
//
//        }else if selectedMonth == "Mar" {
//
//        }else if selectedMonth == "Apr" {
//
//        }else if selectedMonth == "May" {
//
//        }else if selectedMonth == "Jun" {
//
//        }else if selectedMonth == "Jul" {
//
//        }else if selectedMonth == "Aug" {
//
//        }else if selectedMonth == "Sep" {
//
//        }else if selectedMonth == "Oct" {
//
//        }else if selectedMonth == "Nov" {
//
//        }else if selectedMonth == "Dec" {
//
//        }
//
        
        let request = NSFetchRequest<UserActivity>(entityName: "UserActivity")
        let sort = NSSortDescriptor(key: "timestamp", ascending: selectedSort)
        request.sortDescriptors = [sort]
        
        
      
        var predicate: NSPredicate!
    

//
//        var query:String = "timestamp >= %@ AND timestamp < %@"
//        switch currentTypeEnum {
//            
//        case .all:
//            query = ""
//        default:
//            query = "activityType == \(currentTypeEnum)"
//            
//        }
        
//        switch currentTypeEnum {
//        case .all:
//           print("Nothing")
//        case .breathingTechique:
//            query += "AND activityType == %@"
//        case .journalling:
//            query += "AND activityType == %@"
//        case .observation:
//            query += "AND activityType == %@"
//        case .outdoorObservation:
//            query += "AND activityType == %@"
//        }
//
        
//        let predicateString = String(format:query, argumentArray: [startOfTheMonth,endOfTheMonth,currentTypeEnum.rawValue])

        if currentTypeEnum == .all {
        predicate = NSPredicate(format: "timestamp >= %@ AND timestamp < %@", argumentArray:[startOfTheMonth,endOfTheMonth])
        } else {
            predicate = NSPredicate(format: "timestamp >= %@ AND timestamp < %@ AND activityType == %@", argumentArray:[startOfTheMonth,endOfTheMonth,currentTypeEnum.rawValue])
            
        }
        
        request.predicate = predicate
        
//        if query != "" {
//
//        predicate = NSPredicate(format: "activityType == %@",argumentArray: [currentTypeEnum.rawValue])
//
//
//        request.predicate = predicate
//
//        }
        
//        if query == "" {
//
//        predicate = NSPredicate(format: "activityType == ''")
//
//
//        request.predicate = predicate
//
//        }
        
        
        // this will fetch task between today and tommowrow which is 24 hours
        // 0-flase, 1-true
        
 
        
        do {
            try userActivityHistoryArray = persistenceController.container.viewContext.fetch(request)
            print("Type sukses di ambil !")
//            print(typeArrayFetched)
        }catch{
            // If it doesn't work
            print("Error getting data. \(error.localizedDescription)")
        }
    }
    
    
    func loadRecentActivities(){
        
        let request = NSFetchRequest<UserActivity>(entityName: "UserActivity")
        let sort = NSSortDescriptor(key: "timestamp", ascending: false)
        request.sortDescriptors = [sort]
        
        request.fetchLimit = 7
        
//        let column = "activityId"
//
//        // 4. Use the only result type allowed for getting distinct values
//
//        request.resultType = .managedObjectResultType
//
//        // 5. Set that you want distinct results
//        request.returnsDistinctResults = true
//
//        // 6. Set the column you want to fetch
//        request.propertiesToFetch = [column]

        
        // this will fetch task between today and tommowrow which is 24 hours
        // 0-flase, 1-true
 
        
        do {
            let raw = try persistenceController.container.viewContext.fetch(request)
                

                recentUserActivities = raw.unique{$0.activityId}
      
                
//            }
            print("Type sukses di ambil !")
//            print(typeArrayFetched)
        }catch{
            // If it doesn't work
            print("Error getting data. \(error.localizedDescription)")
        }
    }
    
    
    
    
    
    
    func loadRecommendedActivities(effect: String, timeHave: Int){
        
        let request = NSFetchRequest<Activity>(entityName: "Activity")
        let sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]
        
        var predicate: NSPredicate!
     
        // filter Key
        
        // this will fetch task between today and tommowrow which is 24 hours
        // 0-flase, 1-true
        if (timeHave > 2) {
        predicate = NSPredicate(format: "timeInt > %@ AND effect CONTAINS %@",
                                argumentArray: [2,effect])
        } else {
            
            predicate = NSPredicate(format: "timeInt <= %@ AND effect CONTAINS %@",
                                    argumentArray: [2,effect])
            
        }
        request.predicate = predicate
        
       
        do {
            try recommendedActivities = persistenceController.container.viewContext.fetch(request)
        
            
            recommendedActivities = recommendedActivities.shuffled()
            print("Berhasil.")
        }catch{
            print("Belum berhasil")
        }

        
        
    }
    
    
    
    // PERCOBAAN PRELOAD DATA
    
    
    func loadFromLocalFile() {
        let filePath = Bundle.main.path(forResource: "activities", ofType: "csv")
        let str = try? String.init(contentsOfFile: filePath!, encoding: .utf8)
        let items: [(id: String, title: String, activityDescription: String, type: String, timeInt: String, timeString: String, image: String, viewDestination: String, breathingData: String, howTo: String,situation: String, effect: String)] = parseCsvString(csvString: str!)
        
        let context = persistenceController.container.viewContext
        
        for item in items {
            print(item.id + " " + item.title + " " + item.activityDescription + " " + item.type + " " + item.timeInt + " " + item.timeString + " " + item.image + " " + item.viewDestination)
            
            let activity = Activity(context: context)
            activity.id = Int16(item.id) ?? 69
            activity.title = item.title
            activity.activityDescription = item.activityDescription
            activity.type = item.type
            activity.timeInt = Float(item.timeInt) ?? 69
            activity.timeString = item.timeString
            activity.image = item.image
            activity.viewDestination = item.viewDestination
            activity.breathingData = item.breathingData
            activity.howTo = item.howTo
            activity.situation = item.situation
            activity.effect = item.effect
            
            do {
                try context.save()
                print("Saved data with id \(activity.id)")
            }catch{
                // If it doesn't work
                print("Error getting data. \(error.localizedDescription)")
            }
        }
    }
    
    
    
    func parseCsvString(csvString: String) -> [(String, String, String, String, String, String, String, String, String, String,String, String)] {
        var items: [(String, String, String, String, String, String, String, String, String, String, String, String)] = []
        let lines: [String] = csvString.components(separatedBy: NSCharacterSet.newlines) as [String]
        
        for line in lines {
            var values: [String] = []
            if line != "" {
                if line.range(of: "\"") != nil {
                    var textToScan:String = line
                    var value:NSString?
                    var textScanner:Scanner = Scanner(string: textToScan)
                    while textScanner.string != "" {
                        
                        if (textScanner.string as NSString).substring(to: 1) == "\"" {
                            textScanner.scanLocation += 1
                            textScanner.scanUpTo("\"", into: &value)
                            textScanner.scanLocation += 1
                        } else {
                            textScanner.scanUpTo(",", into: &value)
                        }
                        
                        // Store the value into the values array
                        values.append(value! as String)
                        
                        // Retrieve the unscanned remainder of the string
                        if textScanner.scanLocation < textScanner.string.count {
                            textToScan = (textScanner.string as NSString).substring(from: textScanner.scanLocation + 1)
                        } else {
                            textToScan = ""
                        }
                        textScanner = Scanner(string: textToScan)
                    }
                    
                    // For a line without double quotes, we can simply separate the string
                    // by using the delimiter (e.g. comma)
                } else  {
                    values = line.components(separatedBy: ";")
                }
                
                // Put the values into the tuple and add it to the items array
                let item = (values[0], values[1] ,values[2], values[3],values[4], values[5],values[6], values[7], values[8], values[9], values[10], values[11])
                items.append(item)
            }
        }
        return items
    }
    
    
    // Count Streaks
    
    func datesToStreaks(input: [NSDate]) -> [[NSDate]] {
            var ranges:[[NSDate]] = [[]]
            input.forEach { currentDay in
                var lastRange = ranges.last ?? []
                if let lastDate = lastRange.last {
                    if lastDate.addingTimeInterval(86400).isEqual(to: currentDay as Date) {
                        lastRange.append(currentDay)
                        ranges.removeLast()
                        ranges.append(lastRange)
                    }
                    else {
                        ranges.append([currentDay])
                    }
                }
                else {
                    lastRange.append(currentDay)
                    ranges.removeLast()
                    ranges.append(lastRange)
                }

            }
            return ranges
        }


    
    func countStreak(){
        
        let request = NSFetchRequest<NSDictionary>(entityName: "UserActivity")
        let sort = NSSortDescriptor(key: "timestamp", ascending: false)
        request.sortDescriptors = [sort]
//
//        request.fetchLimit = 7
//
        let column = "timestamp"

        // 4. Use the only result type allowed for getting distinct values

        request.resultType = .dictionaryResultType

        // 5. Set that you want distinct results
        request.returnsDistinctResults = true

        // 6. Set the column you want to fetch
        request.propertiesToFetch = [column]

    
        
        do {
            var test = try persistenceController.container.viewContext.fetch(request)
                
            print("count harusnya 2")
            
            var myArray: [Date] = []
            
            print(test.count)
            
//            test = test as
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "MM/dd/yyyy"

            print("This is the console output: \(test)")
            
            let today = dateFormatterGet.date(from: dateFormatterGet.string(from: Date()))!
            
            myArray.append(today ?? Date())
   
            for item in test{
                let get = item["timestamp"] as! Date
                    let date = dateFormatterGet.date(from: dateFormatterGet.string(from: get))!
                      print("date pas udah di convert !")
                        // print(date?.formatted(date: .numeric, time: .omitted))
                            myArray.append(date ?? Date())
                                print("batas !")
            }
            
            myArray = myArray.unique()
            
            var count = 0
            
            for i in 0...myArray.count-1 {
              
                if i == (myArray.count-1) {
                    
                    break
                    
                } else {
                    
                    if myArray[i].addingTimeInterval(-86400) == myArray[i+1]  {
                        
                        count = count + 1
                        
                    } else {
                        
                         break
                        
                    }
                        
                    
                    
                }
                
            }
//            print("Total Streak")
//            print(count)
            
            dailyStreak = count
//
//            print("Array ku !")
//
//            print(myArray)
//
//            print(myArray.unique()) // prints: [1, 2, 3]
            
            
       
            
//            let sortedDays:[NSDate] = input
//                    .map { date in
//                        return date}
//
//
//
//            let maxStreak = datesToStreaks(input: sortedDays)
//                    .map{$0.count}
//                    .reduce(0, {return max($0,$1)})
//
//
//
//            print("print streak")
//            print(maxStreak)
//
//            print(test)
            
//            var arr = [Int]()
            
//            print("This is the console output: \(test as AnyObject)")
//
//            print(type(of: test))
//
//            var myArray = [AnyObject]()
//
//
//            self.myArray = test["data"]! as [AnyObject]
            
            
            
//
            
//
//            print(test.first)
//            for item in test{
//                print(item)
//
//            }
            
//            let array = Array(test.values.map{ $0 })
            
//            print("array ni !")
//            print(array)
//            }
            print("Type sukses di ambil !")
//            print(typeArrayFetched)
        }catch{
            // If it doesn't work
            print("Error getting data. \(error.localizedDescription)")
        }
        
        
    }
    
    
}



extension Array {
    func unique<T:Hashable>(by: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(by(value)) {
                set.insert(by(value))
                arrayOrdered.append(value)
            }
        }

        return arrayOrdered
    }
}


extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
