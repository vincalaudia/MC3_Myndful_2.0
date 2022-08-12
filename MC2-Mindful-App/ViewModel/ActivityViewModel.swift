//
//  ActivityViewModel.swift
//  MC2-Mindful-App
//
//  Created by Muhammad Nur Faqqih on 31/07/22.
//

import SwiftUI
import CoreData


struct TypeDummy : Identifiable{
    var id: Int
    var name : String
    
    init(id: Int, name: String){
        self.id = id
        self.name = name
    }
}

class ActivityViewModel: ObservableObject {
    
    let types : [TypeDummy] = [TypeDummy(id: 0, name: "Pernafasan"),
                               TypeDummy(id: 1, name: "Kesadaran Menjurnal"),
                               TypeDummy(id: 2, name: "Kesadaran Mengobservasi"),
                               TypeDummy(id: 3, name: "Kesadaran Meditasi")]
    
    
    
    
    private let persistenceController = PersistenceController.shared
    
    
    @Published var showCongrats: Bool = false
    
    @Published var activityArray: [Activity] = []
    @Published var selectedActivity = Activity()
    
    @Published var userActivityHistoryArray: [UserActivity] = []
    
    @Published var recommendedActivities: [Activity] = []
    
    @Published var recentUserActivities: [UserActivity] = []
    
    // For Streak
    
    @Published var dailyStreak: Int = 0
    
    
    // For Recommendation View
    
    @Published var moodForRecommendation: String = ""
    @Published var timeHave: Int = 0
    
    // For Jounaling
    
    @Published var feeling: String = ""
    @Published var emoji: String = ""
    @Published var selectedFeeling: String = ""
    @Published var isFeelingSelected: Bool = false
    @Published var journalBody: String = "Write your story !"
    
    
    func resetAllAttirbute(){
            feeling = ""
            emoji = ""
            selectedFeeling = ""
            isFeelingSelected = false
            journalBody = ""
                
//        selectedActivity = Activity()
    }
    
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
    
    
    
    
    
    // For Breathing
    
    func breathing(activity: Activity){
        print("Hihihihihih !")
//        print(selectedActivity.title)
        
        let context = persistenceController.container.viewContext

        let userActivity = UserActivity(context: context)
        userActivity.id = UUID()
        userActivity.timestamp = Date()
        userActivity.activityId = activity.id
        userActivity.activity = activity

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
        
        let request = NSFetchRequest<Activity>(entityName: "Activity")
        let sort = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sort]
        
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
        
        let request = NSFetchRequest<UserActivity>(entityName: "UserActivity")
        let sort = NSSortDescriptor(key: "timestamp", ascending: false)
        request.sortDescriptors = [sort]
        
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
    
    
    
    
    
    
    func loadRecommendedActivities(mood: String, timeHave: Int){
        
        let request = NSFetchRequest<Activity>(entityName: "Activity")
        let sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]
        
        var predicate: NSPredicate!
        
     
        // filter Key
        
        // this will fetch task between today and tommowrow which is 24 hours
        // 0-flase, 1-true
        if (timeHave > 2) {
        predicate = NSPredicate(format: "timeInt > %@",
                                argumentArray: [2])
        } else {
            
            predicate = NSPredicate(format: "timeInt <= %@",
                                    argumentArray: [2])
            
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
        let items: [(id: String, title: String, activityDescription: String, type: String, timeInt: String, timeString: String, image: String, viewDestination: String)] = parseCsvString(csvString: str!)
        
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

            do {
                try context.save()
                print("Saved data with id \(activity.id)")
            }catch{
                // If it doesn't work
                print("Error getting data. \(error.localizedDescription)")
            }
        }
    }
    
    
    
    func parseCsvString(csvString: String) -> [(String, String, String, String, String, String, String, String)] {
        var items: [(String, String, String, String, String, String, String, String)] = []
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
                let item = (values[0], values[1] ,values[2], values[3],values[4], values[5],values[6], values[7])
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