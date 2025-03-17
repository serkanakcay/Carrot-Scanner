import SwiftUI

struct LoginView: View {
    @State private var isPasswordVisible: Bool = false
    @FocusState private var isEmailFocused
    @FocusState private var isPasswordFocused
    @ObservedObject var viewModel: LoginViewViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        // Üst yarı (Görseller)
                        VStack {
                            Spacer()
                            Image("FoodScanner2")
                            Spacer().frame(height: 30)
                            Image("FoodScanner")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.buttons.opacity(0.6))
                            Spacer()
                        }
                        .frame(height: geometry.size.height / 3)
                        .frame(maxWidth: .infinity)
                        .background(Color.buttons)
                        
                        // Alt yarı (Giriş Formu)
                        VStack(alignment: .leading, spacing: 17) {
                            HStack {
                                Text("Hello Again! ")
                                    .font(.system(size: 30, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Text("👋🏻")
                                    .font(.system(size: 28))
                            }
                            .padding(.bottom, 3)
                            
                            // Email Girişi
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Email")
                                    .foregroundColor(.white)
                                    .font(.subheadline)

                                TextField("Enter your email", text: $viewModel.email)
                                    .padding()
                                    .background(Color.black)
                                    .cornerRadius(8)
                                    .overlay(RoundedRectangle(cornerRadius: 8)
                                        .stroke(isEmailFocused ? Color.buttons : Color.gray.opacity(0.5), lineWidth: 1))
                                    .foregroundColor(.white)
                                    .autocapitalization(.none)
                                    .focused($isEmailFocused)
                            }
                            
                            // Şifre Girişi
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Password")
                                    .foregroundColor(.white)
                                    .font(.subheadline)

                                HStack {
                                    if isPasswordVisible {
                                        TextField("Enter your password", text: $viewModel.password)
                                    } else {
                                        SecureField("Enter your password", text: $viewModel.password)
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
                            
                            // Alternatif Giriş (Google)
                            HStack {
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.gray.opacity(0.5))

                                Text("or")
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

                            // Giriş Yap Butonu
                            Button(action: {
                                viewModel.login()
                            }) {
                                Text("Log In")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.buttons)
                                    .foregroundColor(.black)
                                    .cornerRadius(8)
                            }
                            .padding(.top, 5)

                            // Kayıt Ol Linki
                            HStack {
                                Spacer()
                                Text("Don't have an account?")
                                    .foregroundColor(.white)
                                    .font(.subheadline)

                                NavigationLink(destination: RegisterView()) {
                                    Text("Sign up")
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
                        .clipShape(RoundedCorner(radius: 20, corners: [.topLeft, .topRight])) // Üst köşeleri yuvarlat
                        .offset(y: -20) // Slight offset to avoid cut-off
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct RoundedCorner: Shape {
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
    LoginView(viewModel: LoginViewViewModel())
}
