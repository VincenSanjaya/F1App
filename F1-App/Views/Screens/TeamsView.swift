//
//  TeamsView.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 15/09/26.
//

import SwiftUI

struct TeamsView: View {
    // Memanggil "pelayan" yang akan menarik data dari API
    @StateObject private var viewModel = DriversViewModel()
    
    // PERBAIKAN 1: Posisi carImageName ditaruh SEBELUM flag
    let teams = [
        Constructor(id: "ferrari", name: "Ferrari", fullName: "Scuderia Ferrari HP", themeColor: Color.red, carImageName: "ferrari_car", flag: "🇮🇹"),
        Constructor(id: "mclaren", name: "McLaren", fullName: "McLaren F1 Team", themeColor: Color.orange, carImageName: "mclaren_car", flag: "🇬🇧"),
        Constructor(id: "mercedes", name: "Mercedes", fullName: "Mercedes-AMG Petronas", themeColor: Color.teal, carImageName: "mercedes_car", flag: "🇩🇪")
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Color(white: 0.1).ignoresSafeArea()
                
                // Jika data API masih ditarik, tampilkan indikator loading
                if viewModel.isLoading {
                    VStack(spacing: 15) {
                        ProgressView()
                            .tint(.red)
                            .scaleEffect(1.5)
                        Text("Memanaskan mesin...")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                } else {
                    // Jika data sudah masuk, tampilkan daftarnya
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(teams) { team in
                                // PERBAIKAN 2 & 3: Ekstrak teks opsional menjadi teks pasti (String)
                                let teamDrivers = viewModel.drivers.filter { driver in
                                    let safeTeamName = team.name ?? ""
                                    return driver.teamName?.localizedCaseInsensitiveContains(safeTeamName) ?? false
                                }
                                
                                // MEMBUNGKUS KARTU DENGAN TOMBOL NAVIGASI
                                NavigationLink {
                                    // Tujuan saat diklik:
                                    TeamDetailView(team: team)
                                } label: {
                                    // Tampilan kartunya:
                                    TeamCardView(team: team, drivers: teamDrivers)
                                }
                                // Menghilangkan gaya tombol biru bawaan Apple
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("F1 Teams")
            // Memaksa mode gelap
            .preferredColorScheme(.dark)
        }
        // Perintah untuk menjalankan fungsi tarik data API saat layar ini dibuka
        .task {
            await viewModel.loadDrivers()
        }
    }
}

#Preview {
    TeamsView()
}
