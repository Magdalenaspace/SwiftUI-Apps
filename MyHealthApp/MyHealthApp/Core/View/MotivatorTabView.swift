//
//  MotivatorTabView.swift
//  MyHealthApp
//
//  Created by Magdalena Samuel on 11/14/23.
//

import SwiftUI

struct MotivatorTabView: View {

    @EnvironmentObject var manager: HealthManager
    
    @State var selectedTab = "Home"
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tag("Home")
                .tabItem { Image(systemName: "house") }
                .environmentObject(manager)
            ChartView()
                .environmentObject(manager)
                .tag("Charts")
                .tabItem { Image(systemName: "chart.xyaxis.line") }
            
//            ContentView()
//                .tag("Content")
//                .tabItem{
//                    Image(systemName: "person")
//                }
        }
    }
}


struct MotivatorTabView_Previews: PreviewProvider {
    static var previews: some View {
        MotivatorTabView()
            .environmentObject(HealthManager())
    }
}

