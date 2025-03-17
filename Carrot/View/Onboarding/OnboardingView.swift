//
//  OverviewView.swift
//  Carrot
//
//  Created by serkan on 18.02.2025.
//


import SwiftUI

struct OnboardingView: View {
    @AppStorage("isWelcomeSheetShowing") var isWelcomeSheetShowing = true
    
    var body: some View {
        if isWelcomeSheetShowing {
            WelcomeView(isWelcomeSheetShowing: $isWelcomeSheetShowing)
        } else {
            LoginView(viewModel: LoginViewViewModel()) 
        }
    }
}

#Preview {
    OnboardingView()
}

struct PageInfo: Identifiable {
    let id = UUID()
    let label: String
    let text: String
    let image: String
}

let pages = [
    PageInfo(label: "Discover Food", text: "Find the ideal foods tailored specifically to your preferences.", image: "onboarding1"),
    PageInfo(label: "Save Favorites", text: "Save and access your favorite food items anytime, anywhere.", image: "onboarding2"),
    PageInfo(label: "Rate & Review", text: "Your experiences can inspire others to make better choices share them!", image: "onboarding3")
]

struct WelcomeView: View {
    @Binding var isWelcomeSheetShowing: Bool
    @State private var currentPage = 0

    var body: some View {
        NavigationStack {
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(pages.indices, id: \.self) { index in
                        VStack {
                            Image(pages[index].image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 300)
                            
                            VStack(alignment: .leading) {
                                Text(pages[index].label)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                
                                Text(pages[index].text)
                                    .font(.callout)
                                
                                Button(action: {
                                    if currentPage < pages.count - 1 {
                                        withAnimation {
                                            currentPage += 1
                                        }
                                    } else {
                                        isWelcomeSheetShowing = false
                                    }
                                }) {
                                    Text(currentPage == pages.count - 1 ? "Get Started" : "Next")
                                        .bold()
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.buttons)
                                        .foregroundColor(.black)
                                        .cornerRadius(10)
                                }
                            }
                            .padding()
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(.page)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if currentPage > 0 {
                        Button(action: {
                            withAnimation {
                                currentPage -= 1
                            }
                        }) {
                            HStack {
                                Image(systemName: "chevron.left")
                            }
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Skip") {
                        isWelcomeSheetShowing = false
                    }
                }
            }
            .navigationTitle("Food Scanner")
            .bold()
            .navigationBarTitleDisplayMode(.inline)
            .font(.subheadline)
            .foregroundStyle(.white)
        }
    }
}
