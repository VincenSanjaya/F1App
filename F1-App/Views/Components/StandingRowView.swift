//
//  StandingRowView.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 14/09/26.
//

import SwiftUI

struct StandingRowView: View {
    let rank: Int
    let name: String
    let subtitle: String
    let points: Int
    let teamColor: Color
    
    var body: some View {
        HStack(spacing: 14) {
            Text("\(rank)")
                .font(.title3)
                .fontWeight(.black)
                .foregroundColor(.white)
                .frame(width: 34, alignment: .leading)
            
            Rectangle()
                .fill(teamColor)
                .frame(width: 4, height: 42)
                .clipShape(Capsule())
            
            VStack(alignment: .leading, spacing: 3) {
                Text(name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                
                Text(subtitle)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.52))
                    .lineLimit(1)
            }
            
            Spacer(minLength: 12)
            
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text("\(points)")
                    .font(.title3)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                
                Text("PTS")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.white.opacity(0.48))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color.white.opacity(0.09), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
        )
    }
}

#Preview {
    ZStack {
        Color(white: 0.08).ignoresSafeArea()
        
        StandingRowView(
            rank: 4,
            name: "Charles Leclerc",
            subtitle: "Ferrari",
            points: 214,
            teamColor: .red
        )
        .padding()
    }
    .preferredColorScheme(.dark)
}
