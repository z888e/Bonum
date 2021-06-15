//
//  HealthKitOnboarding.swift
//  Bonum
//
//  Created by Zoé Hartman on 15/06/2021.
//

import SwiftUI
import HealthKit

struct HealthKitOnboarding: View {
    
    private var healthStore: HealthStoreData?
    //replace with observable
    @State private var steps = [DataValue]()

    init() {
        healthStore = HealthStoreData()
    }

    private func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection){
        
        statisticsCollection.enumerateStatistics(from: startDate!, to: endDate) {
            (statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let step = DataValue(count: Int(count ?? 0), date: statistics.startDate)
            steps.append(step)
        }
    }
    
    var body: some View {
        Text("Hello, HealthKit")
            .onAppear{
                if let healthStore = healthStore {
                    healthStore.requestAuthorization { success in
                        if success {
                            healthStore.calculateSteps{ statisticsCollection in
                                if let statisticsCollection = statisticsCollection {
                                    //update ui
                                    print(statisticsCollection)
                                    updateUIFromStatistics(statisticsCollection)
                                }
                            }
                        }
                    }
                }
            }
    }
}

struct HealthKitOnboarding_Previews: PreviewProvider {
    static var previews: some View {
        HealthKitOnboarding()
    }
}
