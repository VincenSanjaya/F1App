//
//  ChooseFavoritesView.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 14/09/26.
//

import SwiftUI

struct ChooseFavoritesView: View {
    // Array data tim
    let teams = [
        Constructor(id: "ferrari", name: "Ferrari", fullName: "Scuderia Ferrari HP", themeColor: Color.red, carImageName: "ferrari_car", flag: "🇮🇹"),
        Constructor(id: "mclaren", name: "McLaren", fullName: "McLaren F1 Team", themeColor: Color.orange, carImageName: "mclaren_car", flag: "🇬🇧"),
        Constructor(id: "mercedes", name: "Mercedes", fullName: "Mercedes-AMG Petronas", themeColor: Color.teal, carImageName: "mercedes_car", flag: "🇩🇪")
    ]
    
    @State private var selectedTeamIndex = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Latar Belakang Dasar Abu-abu Gelap
                Color(red: 0.15, green: 0.15, blue: 0.16).ignoresSafeArea()
                
                // Bias Cahaya Halus dari Warna Tim di Latar Belakang
                RadialGradient(
                    gradient: Gradient(colors: [(teams[selectedTeamIndex].themeColor ?? .gray).opacity(0.3), .clear]),
                    center: .center,
                    startRadius: 100,
                    endRadius: 400
                )
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.5), value: selectedTeamIndex)
                
                VStack {
                    Text("Choose Favorites")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    Spacer()
                    
                    // Carousel Tim
                    TabView(selection: $selectedTeamIndex) {
                        ForEach(0..<teams.count, id: \.self) { index in
                            
                            // PERBAIKAN: Variabel diekstrak DI DALAM ForEach agar index terbaca
                            let currentTeam = teams[index]
                            let safeColor = currentTeam.themeColor ?? .gray
                            let logoName = currentTeam.id
                            
                            VStack(spacing: 30) {
                                // Container Kapsul Besar
                                ZStack {
                                    Capsule()
                                        .fill(
                                            LinearGradient(
                                                colors: [Color(white: 0.6), Color(white: 0.4)],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .frame(width: 280, height: 380)
                                    
                                    // Garis tepi tipis
                                    Capsule()
                                        .stroke(Color.white.opacity(0.5), lineWidth: 1)
                                        .frame(width: 280, height: 380)
                                    
                                    // Efek cahaya di bagian bawah
                                    Capsule()
                                        .stroke(safeColor.opacity(0.8), lineWidth: 3)
                                        .blur(radius: 5)
                                        .mask(
                                            LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
                                        )
                                        .frame(width: 280, height: 380)
                                    
                                    // Logo Tim di Tengah
                                    Image(logoName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 180)
                                }
                                .shadow(color: .black.opacity(0.4), radius: 20, x: 0, y: 15) // Pindah bayangan ke luar ZStack kapsul
                                
                                // Teks Bendera, Nama, dan Sub-nama
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
                            .padding(.bottom, 40)
                            .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .frame(height: 550)
                    
                    Spacer()
                    
                    NavigationLink(destination: TeamsView().navigationBarBackButtonHidden(true)) {
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text("Add to favorites")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: "star")
                                    .foregroundColor(.gray)
                            }
                            Text("Get updates on races and drivers")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(20)
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ChooseFavoritesView()
}
