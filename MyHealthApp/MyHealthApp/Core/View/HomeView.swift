//
//  HomeView.swift
//  MyHealthApp
//
//  Created by Magdalena Samuel on 11/14/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var manager: HealthManager
    var welcomeArray = ["Welcome", "Բարի գալուստ", "Добро пожаловать", "歡迎", "Bienvenidos", "Bienvenue"]
    @State private var currentWelcomeIdx = 0
    var body: some View {
        VStack(alignment: .leading) {
            Text(welcomeArray[currentWelcomeIdx])
                .font(.largeTitle)
                .foregroundColor(.secondary)
                .padding()
                .animation(.easeOut(duration: 1), value: currentWelcomeIdx)
                .onAppear {
                    startWelcomeTimer()
                }
            
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                ForEach(manager.mockActivity.sorted(by: { $0.value.id < $1.value.id} ), id: \.key) { item in
                    ActivityCard(activity: item.value)
                }
            }
            .padding(.horizontal)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    func startWelcomeTimer() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            withAnimation {
                currentWelcomeIdx = (currentWelcomeIdx + 1) % welcomeArray.count
            }
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HealthManager())
    }
}

