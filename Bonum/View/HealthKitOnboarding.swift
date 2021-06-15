//
//  HealthKitOnboarding.swift
//  Bonum
//
//  Created by Zoé Hartman on 15/06/2021.
//

import SwiftUI
import HealthKit

struct HealthKitOnboarding: View {
    
    @Binding var steps : [DataValue]
    @EnvironmentObject var healthStore: HealthStoreData
    
        private func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection){
    
            statisticsCollection.enumerateStatistics(from: startDate!, to: endDate) {
                (statistics, stop) in
    
                let count = statistics.sumQuantity()?.doubleValue(for: .count())
    
                let step = DataValue(count: Double(count ?? 0), date: statistics.startDate)
                steps.append(step)
            }
        }
    
    var body: some View {
        Text("HealthKit Auth")
            .onAppear{
                healthStore.requestAuthorization { success in
                    if success {
                        healthStore.calculateSteps{ statisticsCollection in
                            if let statisticsCollection = statisticsCollection {
                                print(statisticsCollection)
                            updateUIFromStatistics(statisticsCollection)
                            }
                        }
                    }
                    
                }
            }
    }
}

struct HealthKitOnboardingPreview : View {
    
    @State private var testTab : [DataValue] = MYSTEPS
    
    var body: some View {
        HealthKitOnboarding(steps: $testTab)
    }
    
}

struct HealthKitOnboarding_Previews: PreviewProvider {
    static var previews: some View {
        HealthKitOnboardingPreview().environmentObject(HealthStoreData())
    }
}
