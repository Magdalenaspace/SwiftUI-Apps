//
//  MyHealthAppApp.swift
//  MyHealthApp
//
//  Created by Magdalena Samuel on 11/14/23.
//

import SwiftUI

@main
struct MyHealthAppApp: App {
    @StateObject var manager = HealthManager()
    
    var body: some Scene {
        WindowGroup {
            MotivatorTabView()
                .environmentObject(manager)
        }
    }
}
