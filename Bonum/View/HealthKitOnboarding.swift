//
//  HealthKitOnboarding.swift
//  Bonum
//
//  Created by Zoé Hartman on 15/06/2021.
//

import SwiftUI
import HealthKit

struct HealthKitOnboarding: View {

    @Binding var stepsVariable : DataElement
    @EnvironmentObject var userData:UserData

    private func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection){

            statisticsCollection.enumerateStatistics(from: startDate!, to: endDate) {
                (statistics, stop) in

                let count = statistics.sumQuantity()?.doubleValue(for: .count())

                let stepsFromHK = DataValue(count: Double(count ?? 0), date: statistics.startDate)
                print(stepsFromHK)
                stepsVariable.values = [stepsFromHK]
                userData.userElementsList.append(stepsVariable)
            }
        }

    var body: some View {
        Text("")
            .onAppear(){
                userData.requestAuthorization { success in
                    if success {
                        userData.calculateSteps{ statisticsCollection in
                            if let statisticsCollection = statisticsCollection {
                            updateUIFromStatistics(statisticsCollection)
                            }
                        }
                    }

                }
            }
    }
}

struct HealthKitOnboardingPreview : View {

    @State private var testTab : [DataValue] = MYSTEPSDATA

    var body: some View {
        HealthKitOnboarding(stepsVariable: .constant(MYSTEPSELEMENT))
//        HealthKitOnboarding()
    }

}

struct HealthKitOnboarding_Previews: PreviewProvider {
    
    static var previews: some View {
        HealthKitOnboardingPreview()
    }
}
