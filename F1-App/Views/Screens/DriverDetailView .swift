//
//  DriverDetailView.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 17/09/26.
//

import SwiftUI

struct DriverDetailView: View {
    // Meminta data Driver dan Warna Tim dari halaman sebelumnya
    let driver: Driver
    let teamColor: Color
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                
                // 1. HERO HEADER (Banner ala Web F1)
                ZStack(alignment: .bottom) {
                    // Background Tim
                    teamColor
                    
                    // Watermark Angka Raksasa di Kanan Bawah
                    Text(driver.driverNumber != nil ? "\(driver.driverNumber!)" : "")
                        .font(.system(size: 180, weight: .black))
                        .foregroundColor(.white.opacity(0.15))
                        .offset(x: 30, y: 40)
                        .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                    
                    // Teks Nama & Tim di Kiri Bawah, Foto di Kanan
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(driver.fullName ?? "Unknown Driver")
                                .font(.system(size: 28, weight: .black))
                                .foregroundColor(.white)
                                .lineLimit(2)
                                .minimumScaleFactor(0.8)
                            
                            Text(driver.teamName?.uppercased() ?? "UNKNOWN TEAM")
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.9))
                        }
                        .padding(.leading, 20)
                        .padding(.bottom, 20)
                        
                        Spacer()
                        
                        // Gambar Pembalap (SEMENTARA pakai ikon. Nanti ganti dengan Image("nama_file_assets"))
                        Image(systemName: "person.crop.square.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .foregroundColor(.white.opacity(0.5))
                            .padding(.trailing, 20)
                    }
                }
                .frame(height: 280) // Tinggi banner
                .clipped() // Potong elemen watermark yang keluar jalur
                
                // 2. STATISTIK KARIR UTAMA (Sementara Statis)
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                    DriverStatBox(title: "World Championships", value: "3")
                    DriverStatBox(title: "Race Wins", value: "61")
                    DriverStatBox(title: "Podiums", value: "107")
                    DriverStatBox(title: "Career Points", value: "2841.5")
                }
                .padding(.horizontal)
                
                // 3. BIODATA PRIBADI (Dinamis dari model)
                VStack(alignment: .leading, spacing: 15) {
                    Text("BIOGRAPHY")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    VStack(spacing: 0) {
                        BioRow(title: "Country", value: driver.countryCode ?? "-")
                        Divider().background(Color.white.opacity(0.1))
                        BioRow(title: "Driver Number", value: driver.driverNumber != nil ? "\(driver.driverNumber!)" : "-")
                        Divider().background(Color.white.opacity(0.1))
                        BioRow(title: "Acronym", value: driver.nameAcronym ?? "-")
                    }
                    .background(Color(white: 0.15))
                    .cornerRadius(15)
                    .padding(.horizontal)
                }
                
                Spacer(minLength: 40)
            }
        }
        .background(Color(white: 0.1).ignoresSafeArea())
        .edgesIgnoringSafeArea(.top) // Membuat banner menabrak batas atas layar dengan keren
        .preferredColorScheme(.dark)
    }
}

// MARK: - Komponen Kotak Statistik Pembalap
struct DriverStatBox: View {
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

// MARK: - Komponen Baris Biodata
struct BioRow: View {
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
        // Data Dummy untuk Preview Canvas
        DriverDetailView(
            driver: Driver(
                driverNumber: 1,
                fullName: "Max Verstappen",
                nameAcronym: "VER",
                teamName: "Red Bull Racing",
                countryCode: "NED"
            ),
            teamColor: .blue
        )
    }
}
