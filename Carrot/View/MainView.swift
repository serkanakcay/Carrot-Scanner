//
//  MainView.swift
//  Carrot
//
//  Created by serkan on 3.10.2024.
//
import SwiftUI
struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserID.isEmpty {
            TabbarView()
        } else {
            LoginView(viewModel: LoginViewViewModel())
        }
    }
}

