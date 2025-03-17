//
//  PaywallHomeHeaderView.swift
//  Carrot
//
//  Created by serkan on 19.02.2025.
//

import SwiftUI
struct PaywallHomeHeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Premium ✨")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                Spacer()
                Text("7 day free trial")
                    .font(.caption)
                    .padding(.horizontal, 10)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(8)
                    .foregroundColor(.black)
            }

            HStack(alignment: .firstTextBaseline) {
                Text("$49")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                Text("/month")
                    .foregroundColor(.gray)
            }

            VStack(alignment: .leading, spacing: 8) {
                FeatureRow(text: "Unlimited product scans")
                FeatureRow(text: "Detailed nutrition analysis")
                FeatureRow(text: "Product comparisons")
            }

            Button(action: {}) {
                Text("Try Free")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.buttons)
                    .foregroundColor(.black)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal) // Genel padding yerine sadece yatay padding
        .padding(.vertical, 10) // Dikey boşluğu azalt
        .background(Color.back)
        .cornerRadius(16)
    }
}

struct FeatureRow: View {
    var text: String

    var body: some View {
        HStack {
            Image("Checks")
                .foregroundColor(.green)
            Text(text)
                .foregroundColor(.white)
                .bold()
        }
    }
}

#Preview {
    PaywallHomeHeaderView()
}
