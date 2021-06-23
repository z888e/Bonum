//
//  ImpactIllustration.swift
//  Bonum
//
//  Created by Zoé Hartman on 22/06/2021.
//

import SwiftUI

struct ImpactIllustration: View {
    
    let impactLevel : Int
    
    var body: some View {
        HStack(spacing: 1){
            VStack{
                Spacer()
                RoundedRectangle(cornerRadius: 1)
                    .fill(impactLevel >= 1 ? Color("AppColor1") : Color("AppColor3"))
                    .frame(width: 5, height: 5)
            }
            VStack{
                Spacer()
                RoundedRectangle(cornerRadius: 1)
                    .fill(impactLevel >= 2 ? Color("AppColor1") : Color("AppColor3"))
                    .frame(width: 5, height: 10)
            }
            VStack{
                Spacer()
                RoundedRectangle(cornerRadius: 1)
                    .fill(impactLevel >= 3 ? Color("AppColor1") : Color("AppColor3"))
                    .frame(width: 5, height: 15)
            }
        }.padding(0)
    }
}

struct ImpactIllustration_Previews: PreviewProvider {
    static var previews: some View {
        ImpactIllustration(impactLevel: 2)
    }
}
