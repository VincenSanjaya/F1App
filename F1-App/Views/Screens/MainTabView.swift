//
//  MainTabView.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 17/09/26.
//


import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            // Tab 1: Paddock (Home)
            HomeView()
                .tabItem {
                    Image(systemName: "flag.checkered")
                    Text("Paddock")
                }
            
            // Tab 2: Schedule
            ScheduleView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Schedule")
                }
            
            // Tab 3: Standings
            StandingsView()
                .tabItem {
                    Image(systemName: "trophy.fill")
                    Text("Standings")
                }
            
            // Tab 4: Teams
            TeamsView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Teams")
                }
        }
        .tint(.red) // <-- Ubah di sini saja
        .preferredColorScheme(.dark)
    }
}

#Preview {
    MainTabView()
}
