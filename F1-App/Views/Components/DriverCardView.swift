//
//  DriverCardView.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 14/09/26.
//

import SwiftUI

struct DriverCardView: View {
    let driver: Driver
    
    var body: some View {
        ZStack {
            // Latar Belakang Gradien Warna Tim
            let teamColor = Color(hex: driver.teamColour ?? "333333")
            
            LinearGradient(
                colors: [teamColor.opacity(0.9), teamColor.opacity(0.3), Color(white: 0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .cornerRadius(20)
            .shadow(color: teamColor.opacity(0.4), radius: 15, x: 0, y: 8)
            
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
            
            HStack(spacing: 0) {
                // SISI KIRI: Teks & Bendera
                VStack(alignment: .leading) {
                    
                    // Nama & Tim
                    VStack(alignment: .leading, spacing: -2) {
                        let names = driver.fullName?.components(separatedBy: " ") ?? ["Unknown"]
                        
                        // Nama Depan: Font tebal dan miring
                        Text(names.first ?? "")
                            .font(.system(size: 18, weight: .heavy))
                            .italic()
                            .foregroundColor(.white.opacity(0.9))
                        
                        // Nama Belakang: Sangat tebal, miring, anti terpotong
                        Text(names.dropFirst().joined(separator: " "))
                            .font(.system(size: 28, weight: .black))
                            .italic()
                            .foregroundColor(.white)
                            .lineLimit(1) // Paksa 1 baris
                            .minimumScaleFactor(0.5) // Jika terlalu panjang, otomatis mengecil maksimal sampai 50% dari ukuran asli
                        
                        // Nama Tim: Uppercase (huruf besar semua) untuk kesan mekanis
                        Text(driver.teamName?.uppercased() ?? "UNKNOWN TEAM")
                            .font(.system(size: 13, weight: .bold))
                            .italic()
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.top, 4)
                    }
                    
                    Spacer()
                    
                    // Nomor Mobil: Hapus .rounded, ganti ke super tebal (Black)
                    Text("\(driver.driverNumber ?? 0)")
                        .font(.system(size: 60, weight: .black))
                        .italic()
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // Bendera Negara
                    if let countryCode = driver.countryCode {
                        Text(getFlagEmoji(countryCode: countryCode))
                            .font(.system(size: 28))
                            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                    }
                }
                .padding(.vertical, 25)
                .padding(.leading, 20)
                
                Spacer(minLength: 10) // Jarak aman antara teks dan foto
                
                // SISI KANAN: Foto Pembalap
                if let urlString = driver.headshotUrl, let url = URL(string: urlString) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView().tint(.white)
                        case .success(let image):
                            VStack{
                                Spacer(minLength: 0)
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 185)
                            }
                        case .failure:
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                                .foregroundColor(.white.opacity(0.3))
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .padding(.trailing, 10)
                }
            }
        }
        .frame(height: 240)
        .clipped()
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
    
    func getFlagEmoji(countryCode: String) -> String {
        let flags: [String: String] = [
            "GBR": "🇬🇧", "NLD": "🇳🇱", "MEX": "🇲🇽", "ESP": "🇪🇸",
            "MCO": "🇲🇨", "FRA": "🇫🇷", "AUS": "🇦🇺", "JPN": "🇯🇵",
            "CAN": "🇨🇦", "USA": "🇺🇸", "FIN": "🇫🇮", "CHN": "🇨🇳",
            "DNK": "🇩🇰", "DEU": "🇩🇪", "THA": "🇹🇭", "ITA": "🇮🇹",
            "NZL": "🇳🇿", "ARG": "🇦🇷", "BRA": "🇧🇷"
        ]
        return flags[countryCode.uppercased()] ?? "🏁"
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        VStack {
            DriverCardView(driver: Driver(
                driverNumber: 4,
                fullName: "Lando Norris",
                nameAcronym: "NOR",
                teamName: "McLaren",
                teamColour: "FF8000",
                headshotUrl: "https://www.formula1.com/content/dam/fom-website/drivers/L/LANNOR01_Lando_Norris/lannor01.png.transform/2col/image.png",
                countryCode: "GBR"
            ))
            
            DriverCardView(driver: Driver(
                driverNumber: 1,
                fullName: "Max Verstappen",
                nameAcronym: "VER",
                teamName: "Red Bull Racing",
                teamColour: "3671C6",
                headshotUrl: "https://www.formula1.com/content/dam/fom-website/drivers/M/MAXVER01_Max_Verstappen/maxver01.png.transform/2col/image.png",
                countryCode: "NLD"
            ))
        }
    }
}
