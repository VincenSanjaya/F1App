//
//  HomeView.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 17/09/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    
                    // 1. HEADER SECTION
                    Text("NEXT RACE")
                        .font(.subheadline)
                        .fontWeight(.black)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    // 2. HERO CARD: NEXT RACE
                    NextRaceCard()
                        .padding(.horizontal)
                    
                    // 3. SECTION TITLE: TOP STANDINGS
                    Text("TOP STANDINGS")
                        .font(.subheadline)
                        .fontWeight(.black)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    // Placeholder untuk klasemen (Kita isi nanti)
                    TopStandingsCard()
                        .padding(.horizontal)
                    
                    Spacer(minLength: 40)
                }
            }
            .background(Color(white: 0.1).ignoresSafeArea())
            .navigationTitle("Paddock")
            .navigationBarTitleDisplayMode(.large)
            .preferredColorScheme(.dark)
        }
    }
}

// MARK: - Komponen Kartu Next Race
struct NextRaceCard: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Latar Belakang Kartu
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(
                    colors: [Color.red.opacity(0.8), Color.black],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(height: 220)
                .shadow(color: .red.opacity(0.3), radius: 10, x: 0, y: 5)
            
            // Gambar Siluet Sirkuit (Elemen Baru)
            Image("cota_circuit") // Ganti dengan nama file sirkuit di Assets
                .resizable()
                .scaledToFit()
                .frame(height: 160)
                .padding(.bottom, 20)
                .padding(.trailing, -20)
                .opacity(0.25)
                .frame(maxWidth: .infinity, alignment: .trailing) // Mendorong gambar sirkuit ke kanan
            
            // Ornamen Garis Estetik
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
            
            VStack(alignment: .leading, spacing: 15) {
                // Info Hari & Tanggal
                HStack {
                    VStack(alignment: .leading) {
                        Text("ROUND 15")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text("20 - 22 OCT")
                            .font(.title3)
                            .fontWeight(.black)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    // Bendera Negara
                    Text("🇺🇸")
                        .font(.system(size: 40))
                }
                
                Spacer()
                
                // Info Sirkuit
                VStack(alignment: .leading, spacing: 4) {
                    Text("United States")
                        .font(.title)
                        .fontWeight(.black)
                        .italic()
                        .foregroundColor(.white)
                    
                    Text("Circuit of The Americas")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            .padding(20)
        }
    }
}

// MARK: - Komponen Top 3 Standings
struct TopStandingsCard: View {
    var body: some View {
        VStack(spacing: 0) {
            // Baris 1
            StandingRow(position: 1, name: "Max VERSTAPPEN", team: "Red Bull", points: "393", teamColor: .blue)
            
            Divider().background(Color.white.opacity(0.1))
            
            // Baris 2
            StandingRow(position: 2, name: "Lando NORRIS", team: "McLaren", points: "331", teamColor: .orange)
            
            Divider().background(Color.white.opacity(0.1))
            
            // Baris 3
            StandingRow(position: 3, name: "Charles LECLERC", team: "Ferrari", points: "300", teamColor: .red)
        }
        .background(Color(white: 0.15))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }
}

// MARK: - Komponen Baris Klasemen
struct StandingRow: View {
    let position: Int
    let name: String
    let team: String
    let points: String
    let teamColor: Color
    
    var body: some View {
        HStack(spacing: 15) {
            Text("\(position)")
                .font(.title3)
                .fontWeight(.black)
                .foregroundColor(.white)
                .frame(width: 30)
            
            // Garis vertikal warna tim
            Rectangle()
                .fill(teamColor)
                .frame(width: 4, height: 30)
                .cornerRadius(2)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(team)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            HStack(alignment: .lastTextBaseline, spacing: 4) {
                Text(points)
                    .font(.headline)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                
                Text("PTS")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
    }
}

#Preview {
    HomeView()
}
