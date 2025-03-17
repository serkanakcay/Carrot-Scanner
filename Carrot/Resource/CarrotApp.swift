//
//  CarrotApp.swift
//  Carrot
//
//  Created by serkan on 11.09.2024.
//

import SwiftUI
import FirebaseCore
@main
struct CarrotApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    @State private var isPresented = true

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}

struct ContentView: View {
    @State private var isPresented = true
    
    var body: some View {
        Group {
            if isPresented {
                LaunchView()
                    .preferredColorScheme(.dark)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) {
                            isPresented = false
                        }
                    }
            } else {
                OnboardingView()
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut, value: isPresented)
    }
}
