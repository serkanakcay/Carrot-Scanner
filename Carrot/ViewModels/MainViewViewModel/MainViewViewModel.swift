//
//  MainViewViewModel.swift
//  Carrot
//
//  Created by serkan on 7.03.2025.
import FirebaseAuth
import SwiftUI

class MainViewViewModel: ObservableObject {
    @Published var currentUserID: String = ""
    @Published var isSignedIn: Bool = false
    static let shared = MainViewViewModel() // Singleton örneği
    
    init() {
        setupAuthListener()
    }
    
    func setupAuthListener() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserID = user?.uid ?? ""
                self?.isSignedIn = user != nil
                print("Auth State Changed in MainViewViewModel: User \(user != nil ? "logged in" : "logged out")")
            }
        }
    }
}
