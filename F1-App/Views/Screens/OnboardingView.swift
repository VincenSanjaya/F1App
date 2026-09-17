//
//  OnboardingView.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 17/09/26.
//

import SwiftUI

struct OnboardingView: View {
    // Menyimpan tim yang sedang dipilih
    @State private var selectedTeam: String? = nil
    
    // Membaca memori perangkat: Apakah user sudah memilih tim?
    @AppStorage("hasSelectedTeam") private var hasSelectedTeam: Bool = false
    
    // Data statis untuk daftar tim dan warnanya
    let teams = [
        ("Red Bull Racing", Color.blue),
        ("McLaren", Color.orange),
        ("Ferrari", Color.red),
        ("Mercedes", Color.teal),
        ("Aston Martin", Color.green),
        ("Alpine", Color.pink)
    ]
    
    // Pengaturan Grid: 2 kolom yang fleksibel
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            
            // 1. HEADER TITLE
            VStack(spacing: 8) {
                Text("CHOOSE YOUR")
                    .font(.headline)
                    .foregroundColor(.gray)
                Text("FAVORITE TEAM")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(.white)
            }
            .padding(.top, 40)
            
            // 2. GRID PILIHAN TIM
            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(teams, id: \.0) { team in
                        TeamSelectionCard(
                            name: team.0,
                            teamColor: team.1,
                            isSelected: selectedTeam == team.0
                        )
                        .onTapGesture {
                            // Memberikan animasi memantul saat dipilih
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                selectedTeam = team.0
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
            
            // 3. TOMBOL CONTINUE
            Button(action: {
                // Mengubah status memori menjadi true saat ditekan
                // Ini akan otomatis memicu ContentView untuk pindah ke MainTabView
                withAnimation {
                    hasSelectedTeam = true
                }
            }) {
                Text("CONTINUE")
                    .font(.headline)
                    .fontWeight(.black)
                    .foregroundColor(selectedTeam == nil ? .gray : .white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(selectedTeam == nil ? Color(white: 0.2) : Color.red)
                    .cornerRadius(15)
            }
            .disabled(selectedTeam == nil) // Tombol mati kalau belum ada yang dipilih
            .padding(.horizontal)
            .padding(.bottom, 30)
        }
        .background(Color(white: 0.1).ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}

// MARK: - Komponen Kartu Pilihan Tim
struct TeamSelectionCard: View {
    let name: String
    let teamColor: Color
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 15) {
            // Placeholder untuk Logo Tim (Bisa diganti Image nanti)
            Circle()
                .fill(teamColor.opacity(isSelected ? 0.4 : 0.1))
                .frame(width: 70, height: 70)
                .overlay(
                    Circle().stroke(teamColor, lineWidth: 2)
                )
            
            Text(name)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity)
        // Warna background berubah terang jika dipilih
        .background(Color(white: isSelected ? 0.25 : 0.15))
        .cornerRadius(15)
        // Garis tepi (border) menyesuaikan warna tim jika dipilih
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(isSelected ? teamColor : Color.white.opacity(0.1), lineWidth: isSelected ? 3 : 1)
        )
        // Efek membesar (zoom) sedikit saat dipilih
        .scaleEffect(isSelected ? 1.05 : 1.0)
    }
}

#Preview {
    OnboardingView()
}
