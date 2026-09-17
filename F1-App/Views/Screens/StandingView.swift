//
//  StandingsView.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 17/09/26.
//

import SwiftUI

struct StandingsView: View {
    // State untuk mendeteksi tab mana yang sedang dipilih (0 = Drivers, 1 = Constructors)
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // 1. Segmented Picker (Tombol Geser)
                Picker("Standings Type", selection: $selectedTab) {
                    Text("Drivers").tag(0)
                    Text("Constructors").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .padding(.vertical, 10)
                
                // 2. Daftar Klasemen
                ScrollView {
                    VStack(spacing: 12) {
                        if selectedTab == 0 {
                            DriversStandingsList()
                        } else {
                            ConstructorsStandingsList()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    .padding(.bottom, 30)
                }
            }
            .background(Color(white: 0.1).ignoresSafeArea())
            .navigationTitle("Standings")
            .preferredColorScheme(.dark)
        }
    }
}

// MARK: - Daftar Pembalap
struct DriversStandingsList: View {
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(destination: DriverDetailView()) {
                FullStandingRow(pos: 1, name: "Max VERSTAPPEN", sub: "Red Bull", pts: "393", color: .blue)
            }
            .buttonStyle(PlainButtonStyle())
            
            Divider().background(Color.white.opacity(0.1))
            
            NavigationLink(destination: DriverDetailView()) {
                FullStandingRow(pos: 2, name: "Lando NORRIS", sub: "McLaren", pts: "331", color: .orange)
            }
            .buttonStyle(PlainButtonStyle())
            
            Divider().background(Color.white.opacity(0.1))
            
            NavigationLink(destination: DriverDetailView()) {
                FullStandingRow(pos: 3, name: "Charles LECLERC", sub: "Ferrari", pts: "300", color: .red)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .background(Color(white: 0.15))
        .cornerRadius(15)
    }
}

// MARK: - Daftar Konstruktor (Tim)
struct ConstructorsStandingsList: View {
    var body: some View {
        VStack(spacing: 0) {
            // Pemanggilan TeamDetailView sekarang menggunakan format inisialisasi Constructor yang lengkap
            NavigationLink(destination: TeamDetailView(
                team: Constructor(id: "mclaren", name: "McLaren", fullName: "McLaren F1 Team", themeColor: .orange, flag: "uk_flag", carImageName: "mclaren_car"),
                drivers: [] // Array kosong sementara agar tidak error. Nantinya diisi dengan data Driver sungguhan.
            )) {
                FullStandingRow(pos: 1, name: "McLaren", sub: "Mercedes", pts: "568", color: .orange)
            }
            .buttonStyle(PlainButtonStyle())
            
            Divider().background(Color.white.opacity(0.1))
            
            NavigationLink(destination: TeamDetailView(
                team: Constructor(id: "redbull", name: "Red Bull Racing", fullName: "Oracle Red Bull Racing", themeColor: .blue, flag: "austria_flag", carImageName: "redbull_car"),
                drivers: []
            )) {
                FullStandingRow(pos: 2, name: "Red Bull Racing", sub: "Honda RBPT", pts: "544", color: .blue)
            }
            .buttonStyle(PlainButtonStyle())
            
            Divider().background(Color.white.opacity(0.1))
            
            NavigationLink(destination: TeamDetailView(
                team: Constructor(id: "ferrari", name: "Ferrari", fullName: "Scuderia Ferrari", themeColor: .red, flag: "italy_flag", carImageName: "ferrari_car"),
                drivers: []
            )) {
                FullStandingRow(pos: 3, name: "Ferrari", sub: "Ferrari", pts: "534", color: .red)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .background(Color(white: 0.15))
        .cornerRadius(15)
    }
}

// MARK: - Komponen Baris Universal
struct FullStandingRow: View {
    let pos: Int
    let name: String
    let sub: String
    let pts: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 15) {
            Text("\(pos)")
                .font(.title3)
                .fontWeight(.black)
                .foregroundColor(.white)
                .frame(width: 30)
            
            Rectangle()
                .fill(color)
                .frame(width: 4, height: 35)
                .cornerRadius(2)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(sub)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(pts)
                .font(.title3)
                .fontWeight(.black)
                .foregroundColor(.white)
            
            Text("PTS")
                .font(.caption2)
                .foregroundColor(.gray)
                .padding(.top, 4)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.white.opacity(0.001))
    }
}

#Preview {
    StandingsView()
}
