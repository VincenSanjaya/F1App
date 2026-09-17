//
//  TrackDetailView.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 17/09/26.
//


//
//  TrackDetailView.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 17/09/26.
//

import SwiftUI

struct TrackDetailView: View {
    // Data statis untuk contoh (Nanti bisa diganti dinamis dari API)
    let country: String = "Italy"
    let circuitName: String = "Autodromo Nazionale Monza"
    let date: String = "30 AUG - 01 SEP"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                
                // 1. HEADER (Bendera & Nama Sirkuit)
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("🇮🇹") // Placeholder bendera
                            .font(.title)
                        Text(country.uppercased())
                            .font(.headline)
                            .foregroundColor(.red)
                    }
                    
                    Text(circuitName)
                        .font(.system(size: 32, weight: .black))
                        .foregroundColor(.white)
                    
                    Text(date)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                // 2. GAMBAR SIRKUIT (Placeholder interaktif)
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(white: 0.15))
                        .frame(height: 250)
                    
                    // Nanti ini diganti dengan Image("monza") dari Assets kamu
                    VStack {
                        Image(systemName: "map.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray.opacity(0.5))
                        Text("Circuit Map")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                }
                .padding(.horizontal)
                
                // 3. STATISTIK LINTASAN (Grid)
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                    StatBox(title: "Track Length", value: "5.793", unit: "km")
                    StatBox(title: "Number of Laps", value: "53", unit: "laps")
                    StatBox(title: "Race Distance", value: "306.72", unit: "km")
                    StatBox(title: "Lap Record", value: "1:21.046", unit: "R. Barrichello")
                }
                .padding(.horizontal)
                
                // 4. JADWAL AKHIR PEKAN (Weekend Schedule)
                VStack(alignment: .leading, spacing: 15) {
                    Text("WEEKEND SCHEDULE")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    VStack(spacing: 0) {
                        ScheduleRow(session: "Practice 1", day: "Fri", time: "18:30")
                        Divider().background(Color.white.opacity(0.1))
                        ScheduleRow(session: "Practice 2", day: "Fri", time: "22:00")
                        Divider().background(Color.white.opacity(0.1))
                        ScheduleRow(session: "Practice 3", day: "Sat", time: "17:30")
                        Divider().background(Color.white.opacity(0.1))
                        ScheduleRow(session: "Qualifying", day: "Sat", time: "21:00")
                        Divider().background(Color.white.opacity(0.1))
                        ScheduleRow(session: "Race", day: "Sun", time: "20:00", isRace: true)
                    }
                    .background(Color(white: 0.15))
                    .cornerRadius(15)
                    .padding(.horizontal)
                }
                
                Spacer(minLength: 40)
            }
            .padding(.top, 10)
        }
        .background(Color(white: 0.1).ignoresSafeArea())
        .navigationTitle("Race Hub")
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.dark)
    }
}

// MARK: - Komponen Kotak Statistik
struct StatBox: View {
    let title: String
    let value: String
    let unit: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
                .textCase(.uppercase)
            
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(value)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                
                Text(unit)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(white: 0.15))
        .cornerRadius(12)
    }
}

// MARK: - Komponen Baris Jadwal
struct ScheduleRow: View {
    let session: String
    let day: String
    let time: String
    var isRace: Bool = false
    
    var body: some View {
        HStack {
            Text(session)
                .font(.subheadline)
                .fontWeight(isRace ? .black : .bold)
                .foregroundColor(isRace ? .red : .white)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text(day)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(time)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
    }
}

#Preview {
    NavigationStack {
        TrackDetailView()
    }
}