//
//  RegisterViewViewModel.swift
//  Carrot
//
//  Created by serkan on 7.03.2025.
//
import Foundation
import FirebaseAuth
import FirebaseFirestore
@Observable class RegisterViewViewModel {
    var name = ""
    var email = ""
    var password = ""
    var errorMessage = ""
    
    init() {}
    
    func register() {
        guard validate() else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self, let userId = result?.user.uid,
                  error == nil else {
                DispatchQueue.main.async {
                    self?.errorMessage = error?.localizedDescription ?? "Kayıt başarısız."
                }
                return
            }
            
            self.insertUserRecord(id: userId)
        }
    }
    
    private func insertUserRecord(id: String) {
        let newUser = User(id: id, name: name, email: email, joined: Date().timeIntervalSince1970)
        let db = Firestore.firestore()
        
        db.collection("users").document(id).setData(newUser.asDictionary()) { error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Kullanıcı kaydedilirken hata oluştu: \(error.localizedDescription)"
                }
            }
        }
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Lütfen tüm alanları doldurun"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Geçerli bir e-posta adresi giriniz"
            return false
        }
        
        guard password.count >= 6 else {
            errorMessage = "Şifreniz en az 6 karakter olmalıdır"
            return false
        }
        
        return true
    }
}
