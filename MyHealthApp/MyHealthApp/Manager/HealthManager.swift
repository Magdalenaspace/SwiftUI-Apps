import Foundation
import HealthKit

// Convert double to string with correct comma formatting and no decimals
extension Double {
    func formattedStringWithCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}


class HealthManager: ObservableObject {
    // HKHealthStore object to request permission to share or read HealthKit data.
    let healthStore = HKHealthStore() // HealthKit Health Store
    
    // Loop and display
    @Published var activities: [String : ActivityModel] = [:]
    
    @Published var mockActivity: [String : ActivityModel] = [
        "TodaySteps": ActivityModel(id: 0, title: "Daily Steps", subtitle: "Goal: 10,000", image: "figure.walk", tintColor: .green, amount: "12.500"),
        "TodaysCalories": ActivityModel(id: 1, title: "Today's Calories", subtitle: "Goal: 900", image: "flame", tintColor: .red, amount: "1200"),
        "WeekRunning": ActivityModel(id: 2, title: "Running", subtitle: "This Week", image: "figure.run", tintColor: .mint, amount: "30  minutes"),
        "WeekStrengthTraining":  ActivityModel(id: 3, title: "Weight Training", subtitle: "This Week", image: "dumbbell.fill", tintColor: .cyan, amount: "60 minutes"),
        "WeekSwimming" :ActivityModel(id: 4, title: "Swimming", subtitle: "This Week", image: "figure.pool.swim", tintColor: .blue, amount: "40 minutes"),
        "WeekClimbing" : ActivityModel(id: 5, title: "Climbing", subtitle: "This Week", image: "figure.climbing", tintColor: .brown, amount: "130 minutes")
    ]
    
    @Published var oneMonthChartData = [DailyStepsView] ()
    // Request users' health information
    init() {
        // Check if HealthKit is available
        guard HKHealthStore.isHealthDataAvailable() else {
            print("HealthKit is not available on this device.")
            return
        }
        
        let steps = HKQuantityType(.stepCount)
        let calories = HKQuantityType(.activeEnergyBurned)
        let workouts = HKQuantityType.workoutType()
        
        let healthTypes: Set = [steps, calories, workouts]
        
//        // Check authorization status for each type
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
                fetchTodaySteps()
                fetchCalories()
                fetchCurrentWeekWorkoutStats()
                fetchPastMonthStepData()
//                fetchWeekRunningSteps()
//                fetchWeekStrengthWorkout()
            } catch {
                debugPrint(error)
            }
        }
    }

    func fetchTodaySteps() {
        let todaySteps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: todaySteps, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("Failed to fetch today's steps with error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            let stepCount = quantity.doubleValue(for: .count())
            let activity = ActivityModel(id: 0, title: "Daily Steps", subtitle: "Goal: 10,000", image: "figure.walk", tintColor: .green, amount: stepCount.formattedStringWithCommas())
            DispatchQueue.main.async {
                self.activities["TodaySteps"] = activity
            }
            print("Today's steps: \(stepCount)")
        }
        healthStore.execute(query)
    }

    func fetchDailySteps(startDate: Date, completion: @escaping([DailyStepsView]) -> Void ) {
        let steps = HKQuantityType(.stepCount)
        let interval = DateComponents(day: 1)
        let query = HKStatisticsCollectionQuery(quantityType: steps, quantitySamplePredicate: nil,
                                                anchorDate: startDate, intervalComponents: interval)
        query.initialResultsHandler = { query, result, error in
            guard let result = result else {
            completion([])
            return
        }
        var dailySteps = [DailyStepsView]()
        
            result.enumerateStatistics(from: startDate, to: Date()) { statistics, stop in
                dailySteps.append(DailyStepsView(date: statistics.startDate,
                                                 stepCount: statistics.sumQuantity()?.doubleValue(for: .count()) ?? 0.00))
            }
            
            completion(dailySteps)
        }
        
        healthStore.execute(query)
    }
    
    
    
    
    func fetchCalories() {
        let calories = HKQuantityType(.activeEnergyBurned)
        let startOfDay = Calendar.current.startOfDay(for: Date())
           let endOfDay = Date()
           let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
           
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("Failed to fetch today's calories with error: \(error?.localizedDescription ?? "Unknown error")")
//                print("Predicate: \(predicate)")

                return
            }
            let caloriesBurned = quantity.doubleValue(for: .kilocalorie())
            let activity = ActivityModel(id: 1, title: "Today's Calories", subtitle: "Goal: 900", image: "flame", tintColor: .red, amount: caloriesBurned.formattedStringWithCommas())
            DispatchQueue.main.async {
                self.activities["TodaysCalories"] = activity
            }
            print("Today's calories: \(caloriesBurned.formattedStringWithCommas())")
        }
        healthStore.execute(query)
    }
    
    @available(iOS 16.0, *)
//    func fetchWeekRunningSteps() {
//        let workout = HKQuantityType.workoutType()
//        let timePredicate = HKQuery.predicateForSamples(withStart: .startOfWeek, end: Date())
//        let workoutPredicate = HKQuery.predicateForWorkouts(with: .running)
//        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [timePredicate, workoutPredicate ])
//        
//        let query = HKSampleQuery(sampleType: workout , predicate: predicate, limit: 25, sortDescriptors: nil) { _, sample, error in
//            guard let workouts = sample as? [HKWorkout], error == nil else {
//                print("Failed to fetch week's workouts with error: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            var count: Int = 0
//            for workout in workouts {
//                let duration = Int(workout.duration)/60
//                count += duration
////                print(workout.allStatistics)
////                print(Int(workout.duration)/60)
////                print(workout.workoutActivityType)
//            }
//            let activity = ActivityModel(id: 2, title: "Running", subtitle: "This Week", image: "figure.run", amount: "\(count) minutes")
//            DispatchQueue.main.async {
//                self.activities["WeekRunning"] = activity
//            }
//        }
//        healthStore.execute(query)
//    }
//    
//    func fetchWeekStrengthWorkout() {
//        let workout = HKQuantityType.workoutType()
//        let timePredicate = HKQuery.predicateForSamples(withStart: .startOfWeek, end: Date())
//        let workoutPredicate = HKQuery.predicateForWorkouts(with: .traditionalStrengthTraining)
//        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [timePredicate, workoutPredicate ])
//        
//        let query = HKSampleQuery(sampleType: workout , predicate: predicate, limit: 20, sortDescriptors: nil) { _, sample, error in
//            guard let workouts = sample as? [HKWorkout], error == nil else {
//                print("Failed to fetch week's workouts with error: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            var count: Int = 0
//            for workout in workouts {
//                let duration = Int(workout.duration)/60
//                count += duration
////                print(workout.allStatistics)
////                print(Int(workout.duration)/60)
////                print(workout.workoutActivityType)
//            }
//            let activity = ActivityModel(id: 3, title: "Weight Training", subtitle: "This Week", image: "dumbbell.fill", amount: "\(count) minutes")
//            DispatchQueue.main.async {
//                self.activities["WeekStrengthTraining"] = activity
//            }
//        }
//        healthStore.execute(query)
//    }
    
    func fetchCurrentWeekWorkoutStats() {
        let workout = HKQuantityType.workoutType()
        
        let timePredicate = HKQuery.predicateForSamples(withStart: .startOfWeek, end: Date())
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .traditionalStrengthTraining)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [timePredicate, workoutPredicate ])
        
        let query = HKSampleQuery(sampleType: workout , predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, sample, error in
            guard let workouts = sample as? [HKWorkout], error == nil else {
                print("Failed to fetch week's workouts with error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            var runningCount: Int = 0
            var strengthCount: Int = 0
            var swimmingCount: Int = 0
            var climbingCount: Int = 0
            
            for workout in workouts {
                if workout.workoutActivityType == .running {
                    let duration = Int(workout.duration)/60
                    runningCount += duration
                } else if workout.workoutActivityType == .traditionalStrengthTraining {
                    let duration = Int(workout.duration)/60
                    strengthCount += duration
                } else if workout.workoutActivityType == .swimming {
                    let duration = Int(workout.duration)/60
                    swimmingCount += duration
                } else if workout.workoutActivityType == .climbing {
                    let duration = Int(workout.duration)/60
                    climbingCount += duration
                }
            }
            
            let runningActivity = ActivityModel(id: 2, title: "Running", subtitle: "This Week", image: "figure.run", tintColor: .mint, amount: "\(runningCount) minutes")
            let strengthActivity = ActivityModel(id: 3, title: "Weight Training", subtitle: "This Week", image: "dumbbell.fill", tintColor: .cyan, amount: "\(strengthCount) minutes")
            let swimmingActivity = ActivityModel(id: 4, title: "Swimming", subtitle: "This Week", image: "figure.pool.swim", tintColor: .blue, amount: "\(swimmingCount) minutes")
            let climbingActivity = ActivityModel(id: 5, title: "Climbing", subtitle: "This Week", image: "figure.climbing", tintColor: .brown , amount: "\(climbingCount) minutes")
            
            DispatchQueue.main.async {
                self.activities["WeekRunning"] = runningActivity
                self.activities["WeekStrengthTraining"] = strengthActivity
                self.activities["WeekSwimming"] = swimmingActivity
                self.activities["WeekClimbing"] = climbingActivity
            }
        }
        healthStore.execute(query)
    }
}

//MARK: -
extension HealthManager {
    
    func fetchPastMonthStepData() {
        fetchDailySteps(startDate: .oneMonthAgo) { dailySteps in
            DispatchQueue.main.async {
                self.oneMonthChartData = dailySteps
            }
        }
    }
}
