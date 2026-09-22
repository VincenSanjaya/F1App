//
//  ContentView.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 17/09/26.
//

import SwiftUI

struct ContentView: View {
    // Membaca memori perangkat: Apakah user sudah memilih tim? (Default: false)
    @AppStorage("hasSelectedTeam") private var hasSelectedTeam: Bool = false
    
    var body: some View {
        // Logika Perpindahan Layar
        if hasSelectedTeam {
            MainTabView() // Jika sudah, langsung masuk ke dalam aplikasi
        } else {
            TeamsView() // Jika belum, tampilkan halaman pilih tim
        }
    }
}

#Preview {
    ContentView()
}
