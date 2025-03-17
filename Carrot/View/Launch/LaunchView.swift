//
//  LaunchView.swift
//  Carrot
//
//  Created by serkan on 6.03.2025.
//

import SwiftUI

struct LaunchView: View {
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Image("launch")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 250, maxHeight: 250)
                    .scaleEffect(scale)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                            scale = 1.1
                        }
                    }
                
                Text("Carrot Scanner")
                    .foregroundColor(.white)
                    .bold()
                    .font(.title)
            }
        }
    }
}
#Preview {
    LaunchView()
}
