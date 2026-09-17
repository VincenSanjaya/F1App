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
    
    let teams = [
        Constructor(id: "ferrari", name: "Ferrari", fullName: "Scuderia Ferrari HP", themeColor: Color.red, flag: "🇮🇹", carImageName: "ferrari_car"),
        Constructor(id: "mclaren", name: "McLaren", fullName: "McLaren F1 Team", themeColor: Color.orange, flag: "🇬🇧", carImageName: "mclaren_car"),
        Constructor(id: "mercedes", name: "Mercedes", fullName: "Mercedes-AMG Petronas", themeColor: Color.teal, flag: "🇩🇪", carImageName: "mercedes_car")
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
                                // LOGIKA PINTAR: Menyaring 2 pembalap milik tim ini
                                let teamDrivers = viewModel.drivers.filter { driver in
                                    driver.teamName?.localizedCaseInsensitiveContains(team.name) ?? false
                                }
                                
                                // MEMBUNGKUS KARTU DENGAN TOMBOL NAVIGASI
                                NavigationLink {
                                    // Tujuan saat diklik:
                                    TeamDetailView(team: team, drivers: teamDrivers)
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
