//
//  DriverDetailView 2.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 17/09/26.
//


import SwiftUI

struct DriverDetailView: View {
    // Data statis sementara (Nanti akan diisi dari API)
    let name: String = "Max Verstappen"
    let number: String = "1"
    let team: String = "Red Bull Racing"
    let teamColor: Color = .blue
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                
                // 1. HEADER (Nomor Latar & Foto)
                ZStack(alignment: .bottom) {
                    Text(number)
                        .font(.system(size: 150, weight: .black))
                        .foregroundColor(teamColor.opacity(0.15))
                        .offset(y: -20)
                    
                    // Placeholder foto pembalap (Ganti dengan Image dari Assets nanti)
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .foregroundColor(teamColor)
                        .background(Circle().fill(Color(white: 0.15)))
                        .shadow(radius: 10)
                }
                .frame(height: 200)
                .padding(.top, 20)
                
                // 2. NAMA & TIM
                VStack(spacing: 5) {
                    Text(name)
                        .font(.system(size: 32, weight: .black))
                        .foregroundColor(.white)
                    
                    Text(team.uppercased())
                        .font(.headline)
                        .foregroundColor(teamColor)
                }
                
                // 3. STATISTIK KARIR UTAMA
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                    DriverStatBox(title: "World Championships", value: "3")
                    DriverStatBox(title: "Race Wins", value: "61")
                    DriverStatBox(title: "Podiums", value: "107")
                    DriverStatBox(title: "Career Points", value: "2841.5")
                }
                .padding(.horizontal)
                
                // 4. BIODATA PRIBADI
                VStack(alignment: .leading, spacing: 15) {
                    Text("BIOGRAPHY")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    VStack(spacing: 0) {
                        BioRow(title: "Country", value: "Netherlands 🇳🇱")
                        Divider().background(Color.white.opacity(0.1))
                        BioRow(title: "Date of Birth", value: "30/09/1997")
                        Divider().background(Color.white.opacity(0.1))
                        BioRow(title: "Place of Birth", value: "Hasselt, Belgium")
                    }
                    .background(Color(white: 0.15))
                    .cornerRadius(15)
                    .padding(.horizontal)
                }
                
                Spacer(minLength: 40)
            }
        }
        .background(Color(white: 0.1).ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
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

#Preview {
    NavigationStack {
        DriverDetailView()
    }
}