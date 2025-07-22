//
//  SigninView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 16/07/2025.
//

import SwiftUI

struct SigninView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var path = [AuthRoute]()
    @State private var isPresentTabbar = false
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    let supabase: SupabaseManager
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                
                VStack(spacing: 0) {
                    getTopView()
                    getTextFields()
                        .padding(.top, 20)
                    getBottomView()
                        .padding(.vertical, 20)
                    
                    Spacer()
                }
                
                if isLoading {
                    LoaderView()
                }
            }
            .onChange(of: alertMessage) {
                if !alertMessage.isEmpty {
                    showAlert =  true
                } else {
                    showAlert = false
                }
            }
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    alertMessage = ""
                }
            }
            .fullScreenCover(isPresented: $isPresentTabbar) {
                TabbarView()
            }
            .ignoresSafeArea(edges: .all)
            .navigationBarHidden(true)
            .navigationDestination(for: AuthRoute.self, destination: { route in
                switch route {
                case .forgotPassword:
                    ForgotPasswordView(path: $path, supabase: .shared)
                    
                case .signup:
                    SignupView(path: $path, supabase: .shared)
                }
            })
        }
        
    }
}

// MARK: - UI Methods
extension SigninView {
    func getTopView() -> some View {
        Rectangle().fill(.clear)
            .overlay(
                ZStack {
                    Image(.authTopBanner)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, height: 250)
                    VStack(spacing: 15) {
                        Spacer()
                        Text("Sign In")
                            .font(.getFont(.semiBold, size: 30))
                            .foregroundStyle(.white)
                        
                        Text("Sign In and wake up on time and don’t be late.")
                            .font(.getFont(.bold, size: 14))
                            .foregroundStyle(.white)
                    }
                    .padding(.bottom, 32)
                }
            )
            .frame(height: 250)
    }
    
    func getTextFields() -> some View {
        VStack(spacing: 20) {
            PrimaryTextField(icon: "ic_email", placeholder: "Enter Email Address", text: $email, keyboardType: .emailAddress)
            PrimaryTextField(icon: "ic_lock", placeholder: "Enter Password", text: $password, fieldType: .secure, isSecureToggleEnabled: true)
            Button {
                self.path.append(.forgotPassword)
            } label: {
                HStack {
                    Spacer()
                    Text("Forgot Password?")
                        .font(.getFont(.bold, size: 16))
                        .foregroundStyle(Color(.custom2D2D40))
                        .frame(height: 26)
                    
                }
            }
            
        }
        .padding(.horizontal, 20)
        
    }
    
    func getBottomView() -> some View {
        VStack(spacing: 10) {
            PrimaryButton(text: "Sign In") {
                if validateFields() {
                    self.callSignIn()
                }
            }
            
            Text("OR")
                .font(.getFont(.bold, size: 18))
                .foregroundStyle(Color(.custom2D2D40))
                .frame(height: 28)
            
            PrimaryButton(leftIcon: "ic_google", text: "Sign In With Google") {
                Task {
                    await supabase.signInWithGoogle()
                }
            }
            
            Spacer()
            
            HStack(spacing: 2) {
                Text("Don’t have account?")
                    .font(.getFont(.bold, size: 16))
                    .foregroundStyle(Color(.custom2D2D40))
                
                Button {
                    self.path.append(.signup)
                } label: {
                    Text("Sign Up")
                        .underline()
                        .font(.getFont(.bold, size: 16))
                        .foregroundStyle(Color(.customA067D0))
                }
                
            }
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - API Calls
extension SigninView {
    func callSignIn() {
        Task {
            isLoading = true
            let success = await supabase.signIn(email: email, password: password)
            isPresentTabbar = success
            if let errorMessage = supabase.errorMessage {
                alertMessage = errorMessage
            }
            isLoading = false
        }
        
    }
}

// MARK: - Methods
extension SigninView {
    func validateFields() -> Bool {
        if let emailError = email.isValid(for: .email) {
            alertMessage = emailError
            return false
        }
        if let passwordError = password.isValid(for: .requiredField(field: "Password")) {
            alertMessage = passwordError
            return false
        }
        return true
    }
}

#Preview {
    SigninView(supabase: .shared)
}
