//
//  OpenF1Service.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 14/09/26.
//

import Foundation

class OpenF1Service {
    // Membuat pattern Singleton agar mesin ini bisa dipanggil dari mana saja
    static let shared = OpenF1Service()
    
    // Alamat utama dari OpenF1 API
    private let baseURL = "https://api.openf1.org/v1"
    
    // Fungsi untuk menarik data pembalap
    func fetchDrivers() async throws -> [Driver] {
        // 1. Pastikan URL-nya valid
        guard let url = URL(string: "\(baseURL)/drivers?session_key=latest") else {
            throw URLError(.badURL)
        }
        
        // 2. Lakukan request ke server secara asinkron (background)
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // 3. Cek apakah server merespons dengan kode 200 (OK)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        // 4. Terjemahkan data JSON dari server ke dalam struct Driver kita
        let decoder = JSONDecoder()
        let drivers = try decoder.decode([Driver].self, from: data)
        
        // 5. Kembalikan datanya!
        return drivers
    }
}
