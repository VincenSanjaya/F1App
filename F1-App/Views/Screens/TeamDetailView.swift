//
//  TeamDetailView.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 15/09/26.
//

import SwiftUI

struct TeamDetailView: View {
    let team: Constructor
    let drivers: [Driver]
    
    init(team: Constructor, drivers: [Driver] = []) {
        self.team = team
        self.drivers = drivers
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                // ==========================================
                // 1. HEADER / BANNER TIM
                // ==========================================
                ZStack {
                    // Layer Bawah: Warna Tim
                    (team.themeColor ?? Color.gray)
                    
                    // Layer Tengah: Watermark Logo Besar
                    if let logo = team.logoImageName {
                        Image(logo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 350)
                            .opacity(0.15)
                            .offset(x: 100, y: 50)
                    }
                    
                    // Layer Atas: Teks Info & Mobil
                    VStack(alignment: .leading) {
                        // Info Nama Tim
                        VStack(alignment: .leading, spacing: 5) {
                            Text(team.name ?? "Unknown Team")
                                .font(.system(size: 40, weight: .black))
                                .foregroundColor(.white)
                            
                            Text(team.fullName ?? "-")
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding(.top, 60)
                        .padding(.leading, 20)
                        
                        Spacer()
                        
                        // Gambar Mobil F1 (Pastikan ada gambar mobil di Assets)
                        if let car = team.carImageName {
                            Image(car)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100) // Sesuaikan jika mobil terlalu kecil/besar
                                .padding(.horizontal, 10)
                                .padding(.bottom, 20)
                                .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 10)
                        } else {
                            // Placeholder jika belum ada gambar mobil
                            Image(systemName: "car.side.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                                .foregroundColor(.white.opacity(0.5))
                                .padding(.bottom, 20)
                                .padding(.leading, 20)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(height: 280) // Tinggi banner
                .clipped()
                
                // ==========================================
                // 2. STATISTIK & INFO TIM
                // ==========================================
                VStack(spacing: 25) {
                    // KOTAK STATISTIK
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                        TeamStatBox(title: "Constructors' Titles", value: "8")
                        TeamStatBox(title: "Drivers' Titles", value: "12")
                        TeamStatBox(title: "Race Wins", value: "183")
                        TeamStatBox(title: "Pole Positions", value: "156")
                    }
                    .padding(.horizontal)
                    
                    // INFO DASAR
                    VStack(alignment: .leading, spacing: 15) {
                        Text("TEAM INFO")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                        
                        VStack(spacing: 0) {
                            TeamBioRow(title: "Base", value: "Woking, UK")
                            Divider().background(Color.white.opacity(0.1))
                            TeamBioRow(title: "Team Chief", value: "Andrea Stella")
                            Divider().background(Color.white.opacity(0.1))
                            TeamBioRow(title: "Power Unit", value: "Mercedes")
                        }
                        .background(Color(white: 0.15))
                        .cornerRadius(15)
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 40)
                }
                .padding(.top, 25)
            }
        }
        .background(Color(white: 0.1).ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.dark)
        .ignoresSafeArea(edges: .top)
    }
}

// MARK: - Komponen Kotak Statistik Tim
struct TeamStatBox: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
                .textCase(.uppercase)
            
            Text(value)
                .font(.title2)
                .fontWeight(.black)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(white: 0.15))
        .cornerRadius(12)
    }
}

// MARK: - Komponen Baris Bio Tim
struct TeamBioRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
    }
}

// MARK: - PREVIEW
#Preview {
    NavigationStack {
        TeamDetailView(
            team: Constructor(
                id: "mclaren",
                name: "McLaren",
                fullName: "McLaren F1 Team",
                themeColor: .orange,
                logoImageName: "mclaren", // Ganti sesuai nama logo di Assets
                carImageName: "mclaren_car" // Ganti sesuai nama mobil di Assets
            )
        )
    }
}
