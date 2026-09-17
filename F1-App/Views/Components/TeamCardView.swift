//
//  TeamCardView.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 15/09/26.
//

import SwiftUI

struct TeamCardView: View {
    let team: Constructor
    // Kartu ini butuh array pembalap agar bisa menampilkan 2 nama di bawah nama tim
    let drivers: [Driver]
    
    var body: some View {
        ZStack {
            // 1. Latar Belakang Gradien Warna Tim
            LinearGradient(
                colors: [team.themeColor, team.themeColor.opacity(0.6), Color(white: 0.15)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .cornerRadius(15)
            .shadow(color: team.themeColor.opacity(0.4), radius: 10, x: 0, y: 6)
            
            // Garis tepi tipis
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
            
            VStack(alignment: .leading) {
                // SISI ATAS: Nama Tim & Logo
                HStack(alignment: .top) {
                    Text(team.name)
                        .font(.system(size: 28, weight: .black))
                        .italic()
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // Logo tim transparan sebagai watermark di kanan atas
                    Image(team.id) // Pastikan nama id sama dengan logo versi penuh di folder Assets
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100) // Perbesar gambar aslinya
                        .opacity(0.7) // Opacity dinaikkan
                        .frame(width: 30, height: 30, alignment: .topTrailing) // Trik menahan ruang layout agar teks tidak ikut turun
                        .offset(x: 10, y: -5) // Geser posisinya agar pas di sudut
                }
                
                // DERETAN PEMBALAP (Foto kecil bulat dari API + Nama)
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
                                .background(Color.white.opacity(0.2)) // Backing kalau fotonya lama load
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
            
            // 2. MOBIL RAKSASA MELINTANG DI TENGAH
            GeometryReader { geometry in
                let carWidth = geometry.size.width * 0.9 // Ukuran diperkecil jadi 90% dari lebar kartu
                
                Image(team.carImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: carWidth)
                    .position(
                        x: (carWidth / 2) + 5,
                        y: geometry.size.height * 0.75
                    )
            }
        }
        .frame(height: 200) // (Sesuaikan dengan tinggi aslimu, misalnya 180 atau 200)
        .clipShape(RoundedRectangle(cornerRadius: 20)) // Potong semua yang keluar batas dengan lengkungan 20
        .padding(.horizontal, 20)
    }
}

// PREVIEW
#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        // Data Dummy untuk Preview
        let dummyTeam = Constructor(
            id: "mclaren",
            name: "McLaren",
            fullName: "McLaren F1 Team",
            themeColor: Color(hex: "FF8000"),
            flag: "🇬🇧",
            carImageName: "mclaren_car" // Pastikan kamu punya gambar bernama "mclaren_car" di Assets
        )
        
        let dummyDrivers = [
            Driver(driverNumber: 4, fullName: "Lando Norris", nameAcronym: "L. NORRIS", teamName: "McLaren", teamColour: "FF8000", headshotUrl: "https://www.formula1.com/content/dam/fom-website/drivers/L/LANNOR01_Lando_Norris/lannor01.png.transform/2col/image.png", countryCode: "GBR"),
            Driver(driverNumber: 81, fullName: "Oscar Piastri", nameAcronym: "O. PIASTRI", teamName: "McLaren", teamColour: "FF8000", headshotUrl: "https://www.formula1.com/content/dam/fom-website/drivers/O/OSCPIA01_Oscar_Piastri/oscpia01.png.transform/2col/image.png", countryCode: "AUS")
        ]
        
        TeamCardView(team: dummyTeam, drivers: dummyDrivers)
    }
}
