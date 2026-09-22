//
//  StandingView.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 17/09/26.
//

import SwiftUI

typealias StandingsView = StandingView

struct StandingView: View {
    @State private var selectedCategory: StandingCategory = .drivers
    
    private var currentItems: [StandingItem] {
        switch selectedCategory {
        case .drivers:
            return StandingMockData.drivers
        case .constructors:
            return StandingMockData.constructors
        }
    }
    
    private var podiumItems: [StandingItem] {
        Array(currentItems.prefix(3))
    }
    
    private var listItems: [StandingItem] {
        Array(currentItems.dropFirst(3))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(white: 0.08).ignoresSafeArea()
                
                VStack(spacing: 18) {
                    standingSegmentedControl
                    
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 24) {
                            standingSectionTitle("Podium")
                            
                            PodiumView(items: podiumItems)
                            
                            standingSectionTitle("List")
                            
                            VStack(spacing: 10) {
                                ForEach(listItems) { item in
                                    StandingRowView(
                                        rank: item.rank,
                                        name: item.name,
                                        subtitle: item.subtitle,
                                        points: item.points,
                                        teamColor: item.teamColor
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 4)
                        .padding(.bottom, 30)
                    }
                }
                .padding(.top, 12)
            }
            .navigationTitle("Standings")
        }
        .preferredColorScheme(.dark)
    }
    
    private var standingSegmentedControl: some View {
        HStack(spacing: 6) {
            ForEach(StandingCategory.allCases) { category in
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.85)) {
                        selectedCategory = category
                    }
                } label: {
                    Text(category.title)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(selectedCategory == category ? .black : .white.opacity(0.72))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 11)
                        .background {
                            if selectedCategory == category {
                                Capsule()
                                    .fill(Color.white)
                            }
                        }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(4)
        .background(Color.white.opacity(0.12), in: Capsule())
        .overlay(
            Capsule()
                .stroke(Color.white.opacity(0.12), lineWidth: 1)
        )
        .padding(.horizontal, 20)
    }
    
    private func standingSectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.headline)
            .fontWeight(.black)
            .foregroundColor(.white)
            .textCase(.uppercase)
    }
}

private enum StandingCategory: CaseIterable, Identifiable {
    case drivers
    case constructors
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .drivers:
            return "Drivers"
        case .constructors:
            return "Constructors"
        }
    }
}

private struct PodiumView: View {
    let items: [StandingItem]
    
    private var orderedItems: [StandingItem] {
        guard items.count >= 3 else { return items }
        return [items[1], items[0], items[2]]
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            ForEach(orderedItems) { item in
                PodiumCard(item: item)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

private struct PodiumCard: View {
    let item: StandingItem
    
    private var isWinner: Bool {
        item.rank == 1
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Text("#\(item.rank)")
                .font(isWinner ? .title2 : .headline)
                .fontWeight(.black)
                .foregroundColor(.white)
                .frame(width: isWinner ? 54 : 44, height: isWinner ? 54 : 44)
                .background(item.teamColor, in: Circle())
                .shadow(color: item.teamColor.opacity(0.45), radius: 14, y: 8)
            
            VStack(spacing: 6) {
                Text(item.name)
                    .font(isWinner ? .headline : .subheadline)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.78)
                
                Text(item.subtitle)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.62))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                
                HStack(alignment: .firstTextBaseline, spacing: 3) {
                    Text("\(item.points)")
                        .font(isWinner ? .title2 : .title3)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    
                    Text("PTS")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.white.opacity(0.55))
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, isWinner ? 18 : 14)
        .frame(minHeight: isWinner ? 190 : 160)
        .background(
            LinearGradient(
                colors: [
                    item.teamColor.opacity(isWinner ? 0.42 : 0.28),
                    Color.white.opacity(0.09)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ),
            in: RoundedRectangle(cornerRadius: 18, style: .continuous)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(item.teamColor.opacity(0.65), lineWidth: isWinner ? 1.5 : 1)
        )
        .offset(y: isWinner ? -18 : 0)
    }
}

private struct StandingItem: Identifiable {
    let id = UUID()
    let rank: Int
    let name: String
    let subtitle: String
    let points: Int
    let teamColor: Color
    let driver: Driver?
    let constructor: Constructor?
}

private enum StandingMockData {
    static let drivers: [StandingItem] = [
        driver(rank: 1, points: 279, color: .orange, driverNumber: 4, fullName: "Lando Norris", acronym: "NOR", teamName: "McLaren", countryCode: "GBR"),
        driver(rank: 2, points: 255, color: .blue, driverNumber: 1, fullName: "Max Verstappen", acronym: "VER", teamName: "Red Bull Racing", countryCode: "NED"),
        driver(rank: 3, points: 237, color: .orange, driverNumber: 81, fullName: "Oscar Piastri", acronym: "PIA", teamName: "McLaren", countryCode: "AUS"),
        driver(rank: 4, points: 214, color: .red, driverNumber: 16, fullName: "Charles Leclerc", acronym: "LEC", teamName: "Ferrari", countryCode: "MON"),
        driver(rank: 5, points: 198, color: .red, driverNumber: 44, fullName: "Lewis Hamilton", acronym: "HAM", teamName: "Ferrari", countryCode: "GBR"),
        driver(rank: 6, points: 173, color: .teal, driverNumber: 63, fullName: "George Russell", acronym: "RUS", teamName: "Mercedes", countryCode: "GBR"),
        driver(rank: 7, points: 151, color: .teal, driverNumber: 12, fullName: "Kimi Antonelli", acronym: "ANT", teamName: "Mercedes", countryCode: "ITA"),
        driver(rank: 8, points: 116, color: .blue, driverNumber: 22, fullName: "Yuki Tsunoda", acronym: "TSU", teamName: "Red Bull Racing", countryCode: "JPN")
    ]
    
    static let constructors: [StandingItem] = [
        constructor(rank: 1, points: 516, id: "mclaren", name: "McLaren", fullName: "McLaren F1 Team", color: .orange),
        constructor(rank: 2, points: 412, id: "ferrari", name: "Ferrari", fullName: "Scuderia Ferrari HP", color: .red),
        constructor(rank: 3, points: 324, id: "mercedes", name: "Mercedes", fullName: "Mercedes-AMG Petronas", color: .teal),
        constructor(rank: 4, points: 301, id: "redbull", name: "Red Bull Racing", fullName: "Oracle Red Bull Racing", color: .blue),
        constructor(rank: 5, points: 89, id: "williams", name: "Williams", fullName: "Atlassian Williams Racing", color: .cyan),
        constructor(rank: 6, points: 72, id: "astonmartin", name: "Aston Martin", fullName: "Aston Martin Aramco", color: .green),
        constructor(rank: 7, points: 58, id: "haas", name: "Haas", fullName: "MoneyGram Haas F1 Team", color: .gray),
        constructor(rank: 8, points: 44, id: "racingbulls", name: "Racing Bulls", fullName: "Visa Cash App Racing Bulls", color: .indigo)
    ]
    
    private static func driver(rank: Int, points: Int, color: Color, driverNumber: Int, fullName: String, acronym: String, teamName: String, countryCode: String) -> StandingItem {
        let driver = Driver(
            driverNumber: driverNumber,
            fullName: fullName,
            nameAcronym: acronym,
            teamName: teamName,
            countryCode: countryCode
        )
        
        return StandingItem(
            rank: rank,
            name: fullName,
            subtitle: teamName,
            points: points,
            teamColor: color,
            driver: driver,
            constructor: nil
        )
    }
    
    private static func constructor(rank: Int, points: Int, id: String, name: String, fullName: String, color: Color) -> StandingItem {
        let constructor = Constructor(
            id: id,
            name: name,
            fullName: fullName,
            themeColor: color,
            logoImageName: id,
            carImageName: "\(id)_car"
        )
        
        return StandingItem(
            rank: rank,
            name: name,
            subtitle: fullName,
            points: points,
            teamColor: color,
            driver: nil,
            constructor: constructor
        )
    }
}

#Preview {
    StandingView()
}
