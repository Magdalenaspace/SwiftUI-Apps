//
//  ContentView.swift
//  BalanceBeat
//
//  Created by Magdalena Samuel on 1/17/24.
//

import SwiftUI

struct ContentView: View {
    
    //holds initial and further state
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    var body: some View {
        
        //display appropriate screen depending on the  actual state of this new property stored in the app storage
        
        ZStack {
          if isOnboardingViewActive {
            OnboardingView()
          } else {
            HomeView()
          }
        }
    }
}

#Preview {
    ContentView()
}
