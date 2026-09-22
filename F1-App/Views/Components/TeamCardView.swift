//
//  TeamCardView.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 15/09/26.
//

import SwiftUI

struct TeamCardView: View {
    let team: Constructor
    let drivers: [Driver]
    
    var body: some View {
        let safeColor = team.themeColor ?? Color.gray
        
        ZStack {
            // 1. Latar Belakang Gradien Warna Tim
            LinearGradient(
                colors: [safeColor, safeColor.opacity(0.6), Color(white: 0.15)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .cornerRadius(15)
            .shadow(color: safeColor.opacity(0.4), radius: 10, x: 0, y: 6)
            
            // Garis tepi tipis
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
            
            VStack(alignment: .leading) {
                // SISI ATAS: Nama Tim & Logo
                HStack(alignment: .top) {
                    Text(team.name ?? "Unknown Team")
                        .font(.system(size: 28, weight: .black))
                        .italic()
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // Logo tim transparan sebagai watermark di kanan atas
                    // PERBAIKAN 1: Tambahkan ?? "" agar Xcode tidak protes soal tipe data Optional
                    Image(team.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .opacity(0.7)
                        .frame(width: 30, height: 30, alignment: .topTrailing)
                        .offset(x: 10, y: -5)
                }
                
                // DERETAN PEMBALAP
                HStack(spacing: 20) {
                    ForEach(drivers) { driver in
                        HStack(spacing: 6) {
                            if let urlString = driver.headshotUrl, let url = URL(string: urlString) {
                                AsyncImage(url: url) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } else {
                                        Color.gray.opacity(0.5)
                                    }
                                }
                                .frame(width: 25, height: 25)
                                .background(Color.white.opacity(0.2))
                                .clipShape(Circle())
                            }
                            
                            // Nama Pembalap
                            Text(driver.nameAcronym ?? driver.fullName ?? "")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.white.opacity(0.9))
                        }
                    }
                }
                .padding(.top, 2)
                
                Spacer()
            }
            .padding(20)
            
            // 2. MOBIL RAKSASA
            GeometryReader { geometry in
                let carWidth = geometry.size.width * 0.9
                
                Image(team.carImageName ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: carWidth)
                    .position(
                        x: (carWidth / 2) + 5,
                        y: geometry.size.height * 0.75
                    )
            }
        }
        .frame(height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 20)
    }
}

// PREVIEW
#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        let dummyTeam = Constructor(
            id: "mclaren",
            name: "McLaren",
            fullName: "McLaren F1 Team",
            themeColor: Color(hex: "FF8000"),
            // PERBAIKAN 2: carImageName ditaruh SEBELUM flag
            carImageName: "mclaren_car",
            flag: "🇬🇧"
        )
        
        let dummyDrivers = [
            Driver(driverNumber: 4, fullName: "Lando Norris", nameAcronym: "L. NORRIS", teamName: "McLaren", teamColour: "FF8000", headshotUrl: "https://www.formula1.com/content/dam/fom-website/drivers/L/LANNOR01_Lando_Norris/lannor01.png.transform/2col/image.png", countryCode: "GBR"),
            Driver(driverNumber: 81, fullName: "Oscar Piastri", nameAcronym: "O. PIASTRI", teamName: "McLaren", teamColour: "FF8000", headshotUrl: "https://www.formula1.com/content/dam/fom-website/drivers/O/OSCPIA01_Oscar_Piastri/oscpia01.png.transform/2col/image.png", countryCode: "AUS")
        ]
        
        TeamCardView(team: dummyTeam, drivers: dummyDrivers)
    }
}
