//
//  ScheduleView.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 17/09/26.
//

import SwiftUI

struct ScheduleView: View {
    // Data dinamis (Nanti bisa diganti dari API)
    let races: [Race] = [
        Race(roundNumber: 15, countryName: "🇺🇸 United States", grandPrixName: "United States Grand Prix", circuitName: "Circuit of The Americas", circuitImageName: "cota_circuit", date: "20-22\nOCT"),
        Race(roundNumber: 16, countryName: "🇲🇽 Mexico", grandPrixName: "Mexico City Grand Prix", circuitName: "Autódromo Hermanos Rodríguez", circuitImageName: "mexico_circuit", date: "27-29\nOCT"),
        Race(roundNumber: 17, countryName: "🇧🇷 Brazil", grandPrixName: "São Paulo Grand Prix", circuitName: "Autódromo José Carlos Pace", circuitImageName: "brazil_circuit", date: "03-05\nNOV"),
        Race(roundNumber: 18, countryName: "🇺🇸 Las Vegas", grandPrixName: "Las Vegas Grand Prix", circuitName: "Las Vegas Strip Circuit", circuitImageName: "vegas_circuit", date: "16-18\nNOV")
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 15) {
                    Text("UPCOMING RACES")
                        .font(.subheadline)
                        .fontWeight(.black)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                        .padding(.horizontal)
                    
                    // Looping data otomatis, tidak perlu hardcode satu-satu
                    ForEach(Array(races.enumerated()), id: \.element.id) { index, race in
                        // Cek apakah ini balapan pertama di list (untuk efek isNextRace)
                        let isNext = index == 0
                        
                        NavigationLink(destination: RaceDetailView(race: race)) {
                            RaceCardView(race: race, isNextRace: isNext)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 40)
                }
            }
            .background(Color(white: 0.1).ignoresSafeArea())
            .navigationTitle("Schedule")
            .preferredColorScheme(.dark)
        }
    }
}

// MARK: - Komponen Kartu Balapan (Mempertahankan UI Asli Milikmu)
struct RaceCardView: View {
    let race: Race
    let isNextRace: Bool
    
    var body: some View {
        HStack(spacing: 15) {
            // Kolom Tanggal
            Text(race.date)
                .font(.headline)
                .fontWeight(.black)
                .multilineTextAlignment(.center)
                .foregroundColor(isNextRace ? .red : .white)
                .frame(width: 50)
            
            // Garis Pemisah
            Rectangle()
                .fill(Color.white.opacity(0.15))
                .frame(width: 1, height: 40)
            
            // Info Sirkuit
            VStack(alignment: .leading, spacing: 4) {
                Text("ROUND \(race.roundNumber)")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(isNextRace ? .red : .gray)
                
                Text(race.countryName)
                    .font(.headline)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                
                Text(race.circuitName)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            
            Spacer()
            
            // Ikon Panah
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(15)
        .background(Color(white: 0.15))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(isNextRace ? Color.red.opacity(0.5) : Color.white.opacity(0.1), lineWidth: isNextRace ? 2 : 1)
        )
    }
}

#Preview {
    ScheduleView()
}
