//
//  TeamsView.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 14/09/26.
//

import SwiftUI

struct TeamsView: View {
    // 1. Panggil ViewModel untuk menarik data pembalap
    @StateObject private var viewModel = DriversViewModel()
    
    let teams = [
        Constructor(id: "ferrari", name: "Ferrari", fullName: "Scuderia Ferrari HP", themeColor: Color.red, carImageName: "ferrari_car", flag: "🇮🇹"),
        Constructor(id: "mclaren", name: "McLaren", fullName: "McLaren F1 Team", themeColor: Color.orange, carImageName: "mclaren_car", flag: "🇬🇧"),
        Constructor(id: "mercedes", name: "Mercedes", fullName: "Mercedes-AMG Petronas", themeColor: Color.teal, carImageName: "mercedes_car", flag: "🇩🇪")
    ]
    
    @State private var selectedTeamIndex = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.15, green: 0.15, blue: 0.16).ignoresSafeArea()
                
                RadialGradient(
                    gradient: Gradient(colors: [(teams[selectedTeamIndex].themeColor ?? .gray).opacity(0.3), .clear]),
                    center: .center,
                    startRadius: 100,
                    endRadius: 400
                )
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.5), value: selectedTeamIndex)
                
                if viewModel.isLoading {
                    ProgressView().tint(.white).scaleEffect(1.5)
                } else {
                    VStack {
                        Text("F1 Constructors")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 20)
                        
                        Spacer()
                        
                        TabView(selection: $selectedTeamIndex) {
                            ForEach(Array(teams.enumerated()), id: \.element.id) { index, currentTeam in
                                let safeColor = currentTeam.themeColor ?? .gray
                                let logoName = currentTeam.id
                                
                                // 2. Filter pembalap khusus untuk tim ini
                                let teamDrivers = viewModel.drivers.filter { driver in
                                    let safeTeamName = currentTeam.name ?? ""
                                    return driver.teamName?.localizedCaseInsensitiveContains(safeTeamName) ?? false
                                }
                                
                                // 3. BUNGKUS KAPSUL DENGAN NAVIGATION LINK
                                NavigationLink(destination: TeamDetailView(team: currentTeam, drivers: teamDrivers)) {
                                    VStack(spacing: 30) {
                                        ZStack {
                                            Capsule()
                                                .fill(
                                                    LinearGradient(colors: [Color(white: 0.6), Color(white: 0.4)], startPoint: .topLeading, endPoint: .bottomTrailing)
                                                )
                                                .frame(width: 280, height: 380)
                                            
                                            Capsule()
                                                .stroke(Color.white.opacity(0.5), lineWidth: 1)
                                                .frame(width: 280, height: 380)
                                            
                                            Capsule()
                                                .stroke(safeColor.opacity(0.8), lineWidth: 3)
                                                .blur(radius: 5)
                                                .mask(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom))
                                                .frame(width: 280, height: 380)
                                            
                                            Image(logoName)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 180)
                                        }
                                        .shadow(color: .black.opacity(0.4), radius: 20, x: 0, y: 15)
                                        
                                        VStack(spacing: 8) {
                                            HStack(spacing: 10) {
                                                Text(currentTeam.flag ?? "")
                                                    .font(.title)
                                                Text(currentTeam.name ?? "")
                                                    .font(.system(size: 32, weight: .bold))
                                                    .foregroundColor(.white)
                                            }
                                            Text(currentTeam.fullName ?? "")
                                                .font(.headline)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                                .buttonStyle(PlainButtonStyle()) // Menghapus efek biru bawaan Apple
                                .padding(.bottom, 40)
                                .tag(index)
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .always))
                        .frame(height: 550)
                        
                        Spacer()
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
        // 4. Tarik data saat layar muncul
        .task {
            await viewModel.loadDrivers()
        }
    }
}

#Preview {
    TeamsView()
}
