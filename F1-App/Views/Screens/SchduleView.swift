//
//  ScheduleView.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 17/09/26.
//

import SwiftUI

import SwiftUI

struct ScheduleView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 15) {
                    // Balapan Terdekat (Upcoming)
                    Text("UPCOMING RACES")
                        .font(.subheadline)
                        .fontWeight(.black)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                        .padding(.horizontal)
                    
                    // Round 15
                    NavigationLink(destination: TrackDetailView()) {
                        RaceCardView(
                            round: "ROUND 15",
                            date: "20-22\nOCT",
                            flag: "🇺🇸",
                            country: "United States",
                            track: "Circuit of The Americas",
                            isNextRace: true
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal)
                    
                    // Sisa Balapan Musim Ini - Round 16
                    NavigationLink(destination: TrackDetailView()) {
                        RaceCardView(
                            round: "ROUND 16",
                            date: "27-29\nOCT",
                            flag: "🇲🇽",
                            country: "Mexico",
                            track: "Autódromo Hermanos Rodríguez",
                            isNextRace: false
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal)
                    
                    // Round 17
                    NavigationLink(destination: TrackDetailView()) {
                        RaceCardView(
                            round: "ROUND 17",
                            date: "03-05\nNOV",
                            flag: "🇧🇷",
                            country: "Brazil",
                            track: "Autódromo José Carlos Pace",
                            isNextRace: false
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal)
                    
                    // Round 18
                    NavigationLink(destination: TrackDetailView()) {
                        RaceCardView(
                            round: "ROUND 18",
                            date: "16-18\nNOV",
                            flag: "🇺🇸",
                            country: "Las Vegas",
                            track: "Las Vegas Strip Circuit",
                            isNextRace: false
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal)
                    
                    Spacer(minLength: 40)
                }
            }
            .background(Color(white: 0.1).ignoresSafeArea())
            .navigationTitle("Schedule")
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ScheduleView()
}

// MARK: - Komponen Kartu Balapan
struct RaceCardView: View {
    let round: String
    let date: String
    let flag: String
    let country: String
    let track: String
    let isNextRace: Bool // Penanda untuk memberikan efek khusus pada balapan selanjutnya
    
    var body: some View {
        HStack(spacing: 15) {
            // Kolom Tanggal
            Text(date)
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
                Text(round)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(isNextRace ? .red : .gray)
                
                HStack(spacing: 6) {
                    Text(flag)
                    Text(country)
                        .font(.headline)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                }
                
                Text(track)
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
