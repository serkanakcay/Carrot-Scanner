//
//  LoginViewViewModel.swift
//  Carrot
//
//  Created by serkan on 7.03.2025.
//

import Foundation
import FirebaseAuth

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var isLoading = false
    @Published var isLoggedIn = false

    init() {
        // Firebase auth state listener'ı ekleyelim
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.isLoggedIn = user != nil
            }
        }
    }

    func login() {
        guard validate() else {
            return
        }

        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    print("Login failed: \(error.localizedDescription)")
                } else {
                    print("Login successful for: \(self?.email ?? "")")
                    self?.isLoggedIn = true
                }
            }
        }
    }

    func validate() -> Bool {
        errorMessage = ""

        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Lütfen tüm alanları doldurun"
            return false
        }

        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Lütfen geçerli bir e-posta adresi girin"
            return false
        }

        return true
    }
}
