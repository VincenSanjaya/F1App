import SwiftUI

struct RaceDetailView: View {
    let race: Race
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // ==========================================
                // 1. BANNER SIRKUIT
                // ==========================================
                ZStack {
                    // Latar Belakang Gelap Khas F1
                    Color(white: 0.1).ignoresSafeArea()
                    
                    VStack {
                        // Teks Info Balapan
                        VStack(spacing: 5) {
                            Text("ROUND \(race.roundNumber)")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                            
                            Text(race.grandPrixName)
                                .font(.title)
                                .fontWeight(.black)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            
                            Text(race.circuitName)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 40)
                        
                        // Gambar Sirkuit dari Assets
                        Image(race.circuitImageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 250)
                            .padding()
                            // Efek neon/glow tipis pada sirkuit
                            .shadow(color: .red.opacity(0.3), radius: 15, x: 0, y: 0)
                    }
                }
                .frame(height: 400)
                
                // ==========================================
                // 2. JADWAL / SESI (Contoh Tampilan)
                // ==========================================
                VStack(alignment: .leading, spacing: 15) {
                    Text("WEEKEND SCHEDULE")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    VStack(spacing: 0) {
                        SessionRow(session: "Practice 1", time: "Fri, 18:00")
                        Divider().background(Color.white.opacity(0.1))
                        SessionRow(session: "Qualifying", time: "Sat, 21:00")
                        Divider().background(Color.white.opacity(0.1))
                        SessionRow(session: "Race", time: "Sun, 20:00")
                    }
                    .background(Color(white: 0.15))
                    .cornerRadius(15)
                    .padding(.horizontal)
                }
                
                Spacer(minLength: 40)
            }
        }
        .background(Color.black.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.dark)
        .ignoresSafeArea(edges: .top)
    }
}

// Komponen untuk baris jadwal
struct SessionRow: View {
    let session: String
    let time: String
    
    var body: some View {
        HStack {
            Text(session)
                .font(.subheadline)
                .foregroundColor(.white)
            
            Spacer()
            
            Text(time)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.red)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
    }
}

#Preview {
    NavigationStack {
        RaceDetailView(
            race: Race(
                roundNumber: 1,
                countryName: "Bahrain",
                grandPrixName: "Bahrain Grand Prix",
                circuitName: "Bahrain International Circuit",
                circuitImageName: "bahrain_circuit", // Ganti dengan nama file sirkuit di Assets
                date: "29 Feb - 02 Mar"
            )
        )
    }
}