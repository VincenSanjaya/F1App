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
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // 1. HEADER: Mobil Raksasa & Latar Belakang Gradien
                ZStack(alignment: .bottom) {
                    // Latar gradien dari atas ke bawah
                    LinearGradient(
                        colors: [team.themeColor.opacity(0.5), Color(white: 0.1)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 250)
                    
                    // Logo tim besar sebagai Watermark di belakang mobil
                    Image(team.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300) // PERBESAR LOGO (dari 200 jadi 300)
                        .opacity(0.8)   // NAIKKAN OPACITY (dari 0.15 jadi 0.8)
                        .offset(y: -40)
                    
                    // Gambar Mobil
                    Image(team.carImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 10)
                        .offset(y: 20) // Menurunkan mobil sedikit agar terasa keluar dari header
                }
                
                // 2. BAGIAN PEMBALAP
                VStack(alignment: .leading, spacing: 20) {
                    Text("CURRENT DRIVERS")
                        .font(.headline)
                        .fontWeight(.black)
                        .italic()
                        .foregroundColor(.gray)
                        .padding(.horizontal, 25)
                        .padding(.top, 20)
                    
                    // Looping kartu pembalap yang sudah kita buat sebelumnya!
                    VStack(spacing: 15) {
                        ForEach(drivers) { driver in
                            DriverCardView(driver: driver)
                        }
                    }
                }
                
                Spacer(minLength: 40)
            }
        }
        .background(Color(white: 0.1).ignoresSafeArea())
        .navigationTitle(team.fullName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
