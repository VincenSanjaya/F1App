//
//  ChooseFavoritesView.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 14/09/26.
//

import SwiftUI

struct ChooseFavoritesView: View {
    // Array data tim, sekarang ditambah bendera (menggunakan emoji)
    let teams = [
        Constructor(id: "ferrari", name: "Ferrari", fullName: "Scuderia Ferrari HP", themeColor: Color.red, flag: "🇮🇹", carImageName: "ferrari_car",),
        Constructor(id: "mclaren", name: "McLaren", fullName: "McLaren F1 Team", themeColor: Color.orange, flag: "🇬🇧", carImageName: "mclaren_car"),
        Constructor(id: "mercedes", name: "Mercedes", fullName: "Mercedes-AMG Petronas", themeColor: Color.teal, flag: "🇩🇪", carImageName: "mercedes_car")
    ]
    
    @State private var selectedTeamIndex = 0
    
    var body: some View {
        // 1. DIBUNGKUS DENGAN NAVIGATION STACK
        NavigationStack {
            ZStack {
                // Latar Belakang Dasar Abu-abu Gelap
                Color(red: 0.15, green: 0.15, blue: 0.16).ignoresSafeArea()
                
                // Bias Cahaya Halus dari Warna Tim di Latar Belakang
                RadialGradient(
                    gradient: Gradient(colors: [teams[selectedTeamIndex].themeColor.opacity(0.3), .clear]),
                    center: .center,
                    startRadius: 100,
                    endRadius: 400
                )
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.5), value: selectedTeamIndex)
                
                VStack {
                    // Header (Bisa disesuaikan dengan tombol navigasi nanti)
                    Text("Choose Favorites")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    Spacer()
                    
                    // Carousel Tim
                    TabView(selection: $selectedTeamIndex) {
                        ForEach(0..<teams.count, id: \.self) { index in
                            VStack(spacing: 30) {
                                
                                // Container "Besi Metal" Bentuk Kapsul Besar
                                ZStack {
                                    Capsule()
                                        .fill(
                                            // Gradien warna metal solid
                                            LinearGradient(
                                                colors: [Color(white: 0.6), Color(white: 0.4)],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .frame(width: 280, height: 380) // Ukuran raksasa (Fixed size)
                                        // Garis tepi tipis agar pinggirannya tajam
                                        .overlay(
                                            Capsule()
                                                .stroke(Color.white.opacity(0.5), lineWidth: 1)
                                        )
                                        // Efek cahaya di bagian bawah sesuai warna tim (seperti di referensimu)
                                        .overlay(
                                            Capsule()
                                                .stroke(teams[index].themeColor.opacity(0.8), lineWidth: 3)
                                                .blur(radius: 5)
                                                .mask(
                                                    LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
                                                )
                                        )
                                        // Bayangan agar kapsulnya terlihat 3D dan mengambang
                                        .shadow(color: .black.opacity(0.4), radius: 20, x: 0, y: 15)
                                    
                                    // Logo Tim di Tengah Kapsul
                                    Image(teams[index].imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 180) // Ukuran logo besar di dalam kapsul
                                }
                                
                                // Teks Bendera, Nama, dan Sub-nama
                                VStack(spacing: 8) {
                                    HStack(spacing: 10) {
                                        Text(teams[index].flag)
                                            .font(.title)
                                        
                                        Text(teams[index].name)
                                            .font(.system(size: 32, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                    
                                    Text(teams[index].fullName)
                                        .font(.headline)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.bottom, 40)
                            .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .frame(height: 550) // Ruang untuk Carousel
                    
                    Spacer()
                    
                    // 2. TOMBOL DIUBAH MENJADI NAVIGATION LINK
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
