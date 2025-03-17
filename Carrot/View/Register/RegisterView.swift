import SwiftUI

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @Environment(\.dismiss) private var dismiss
    @State var viewModel = RegisterViewViewModel()
    @FocusState var isEmailFocused
    @FocusState var isPasswordFocused
    @FocusState var isFullNameFocused
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    // Üst bölüm - Logo ve başlık
                    VStack {
                        Spacer()
                        Image("FoodScanner2")
                        Spacer().frame(height: 30)
                        Image("FoodScanner")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.buttons.opacity(0.6))
                        Spacer()
                    }
                    .frame(height: geometry.size.height / 4)
                    .frame(maxWidth: .infinity)
                    .background(Color.buttons)
                    
                    // Alt bölüm - Kayıt formu
                    VStack(alignment: .leading, spacing: 17) {
                        HStack {
                            Text("Hadi Resmi Yapalım  ")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text("🎉")
                                .font(.system(size: 28))
                        }
                        .padding(.bottom, 3)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Ad Soyad")
                                .foregroundColor(.white)
                                .font(.subheadline)
                            
                            TextField("Adınızı girin", text: $viewModel.name)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(8)
                                .overlay(RoundedRectangle(cornerRadius: 8)
                                    .stroke(isFullNameFocused ? Color.buttons : Color.gray.opacity(0.5), lineWidth: 1))
                                .foregroundColor(.white)
                                .autocapitalization(.none)
                                .focused($isFullNameFocused)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("E-posta")
                                .foregroundColor(.white)
                                .font(.subheadline)
                            
                            TextField("E-posta adresinizi girin", text: $viewModel.email)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(8)
                                .overlay(RoundedRectangle(cornerRadius: 8)
                                    .stroke(isEmailFocused ? Color.buttons : Color.gray.opacity(0.5), lineWidth: 1))
                                .foregroundColor(.white)
                                .autocapitalization(.none)
                                .focused($isEmailFocused)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Şifre")
                                .foregroundColor(.white)
                                .font(.subheadline)
                            
                            HStack {
                                if isPasswordVisible {
                                    TextField("Şifrenizi girin", text: $viewModel.password)
                                } else {
                                    SecureField("Şifrenizi girin", text: $viewModel.password)
                                }
                                Button(action: {
                                    isPasswordVisible.toggle()
                                }) {
                                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            .background(Color.black)
                            .cornerRadius(8)
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(isPasswordFocused ? Color.buttons : Color.gray.opacity(0.5), lineWidth: 1))
                            .foregroundColor(.white)
                            .focused($isPasswordFocused)
                        }
                        
                        HStack {
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray.opacity(0.5))
                            
                            Text("veya")
                                .foregroundColor(.white)
                                .font(.caption)
                                .padding(.horizontal, 8)
                            
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray.opacity(0.5))
                        }
                        .padding(.vertical, 5)
                        
                        Button(action: {
                            print("Google Login")
                        }) {
                            HStack {
                                Spacer()
                                Image("Google")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                Spacer()
                            }
                            .padding()
                            .background(Color.black)
                            .cornerRadius(8)
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        }
                        
                        Button(action: {
                            viewModel.register()
                        }) {
                            Text("Kayıt Ol")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.buttons)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                        }
                        .padding(.top, 5)
                        
                        HStack {
                            Spacer()
                            Text("Don't have an account?")
                                .foregroundColor(.white)
                                .font(.subheadline)

                            NavigationLink(destination: LoginView(viewModel: login)) {
                                Text("Login")
                                    .foregroundStyle(.white)
                                    .bold()
                            }
                            Spacer()
                        }
                        .padding(.top, 10)
                    }
                    .padding(30)
                    .frame(maxWidth: .infinity)
                    .frame(height: geometry.size.height * 0.67)
                    .background(Color.black)
                    .clipShape(RoundedCorners(radius: 20, corners: [.topLeft, .topRight]))
                    .offset(y: -20)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// Üst köşeleri yuvarlatmak için özel Shape
struct RoundedCorners: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    NavigationStack {
        RegisterView()
    }
}
