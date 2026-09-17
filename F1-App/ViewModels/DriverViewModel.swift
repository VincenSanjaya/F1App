//
//  DriverViewModel.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 15/09/26.
//

import SwiftUI
import Combine

// @MainActor memastikan bahwa pembaruan UI selalu dilakukan di antrean utama (main thread)
@MainActor
class DriversViewModel: ObservableObject {
    // @Published membuat UI otomatis memperbarui diri (re-render) jika isi data ini berubah
    @Published var drivers: [Driver] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Fungsi untuk menarik data dari Service yang sudah kita buat tadi
    func loadDrivers() async {
        isLoading = true
        errorMessage = nil
        
        do {
            self.drivers = try await OpenF1Service.shared.fetchDrivers()
        } catch {
            self.errorMessage = "Gagal memuat data: \(error.localizedDescription)"
            print(self.errorMessage ?? "Error tidak diketahui")
        }
        
        isLoading = false
    }
}
