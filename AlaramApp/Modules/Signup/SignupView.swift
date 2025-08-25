//
//  SignupView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 16/07/2025.
//

import SwiftUI
import Supabase

struct SignupView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var path: [AuthRoute]
    
    @State private var name = ""
    @State private var email = ""
    @State private var language = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isLoading = false
    @State private var alertData = AlertData()
    @State private var isSignupSuccess = false
    @State private var showGoogleSignIn = false
    @State private var isPresentTabbar = false
    
    let supabase: SupabaseManager
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                getTopView()
                ScrollView {
                    getTextFields()
                        .padding(.top, 20)
                    
                    getBottomView()
                        .padding(.vertical, 20)
                }
                
                Spacer()
            }
        }
        .loader(isLoading: isLoading)
        .messageAlert($alertData)
        .sheet(isPresented: $showGoogleSignIn) {
            GoogleSignInWrapper { success, error in
                showGoogleSignIn = false
                isLoading = true
                if success {
                    Task {
                        let errorMessage = try await supabase.googleSignin(name: name, language: language, profilePictureURL: nil) ?? ""
                        isLoading = false
                        if errorMessage.isEmpty {
                            self.isPresentTabbar = true
                        } else {
                            alertData.show(message: errorMessage)
                        }
                    }
                } else {
                    alertData.show(message: error ?? "Some thing went wrong")
                }
            }
        }
        .fullScreenCover(isPresented: $isPresentTabbar) {
            TabbarView()
        }
        .ignoresSafeArea(edges: .all)
    }
}

// MARK: - UI Methods
extension SignupView {
    func getTopView() -> some View {
        Rectangle().fill(.clear)
            .overlay(
                ZStack {
                    Image(.authTopBanner)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, height: 250)
                    VStack(spacing: 15) {
                        Spacer()
                        Text("Sign Up")
                            .font(.getFont(.semiBold, size: 30))
                            .foregroundStyle(.white)
                        
                        Text("Sign Up and wake up on time and don’t be late.")
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
            PrimaryTextField(icon: "ic_person", placeholder: "Enter Name", text: $name)
            PrimaryTextField(icon: "ic_email", placeholder: "Enter Email Address", text: $email, keyboardType: .emailAddress)
            PrimaryTextField(icon: "ic_language", placeholder: "Select Language", text: $language)
            PrimaryTextField(icon: "ic_lock", placeholder: "Enter Password", text: $password, fieldType: .secure, isSecureToggleEnabled: true)
            PrimaryTextField(icon: "ic_lock", placeholder: "Confirm Password", text: $confirmPassword, fieldType: .secure, isSecureToggleEnabled: true)
        }
        .padding(.horizontal, 20)
        
    }
    
    func getBottomView() -> some View {
        VStack(spacing: 10) {
            PrimaryButton(text: "Signup") {
                if validateFields() {
                    self.callSignup()
                }
            }
            
            Text("OR")
                .font(.getFont(.bold, size: 18))
                .foregroundStyle(Color(.custom2D2D40))
                .frame(height: 28)
            
            PrimaryButton(leftIcon: "ic_google", text: "Sign Up With Google") {
                showGoogleSignIn = true
            }
            
            HStack(spacing: 2) {
                Text("Already have account?")
                    .font(.getFont(.bold, size: 16))
                    .foregroundStyle(Color(.custom2D2D40))
                
                Button {
                    self.path.removeLast()
                } label: {
                    Text("Sign In")
                        .underline()
                        .font(.getFont(.bold, size: 16))
                        .foregroundStyle(Color(.customA067D0))
                }
                
            }
        }
        .navigationBarHidden(true)
        .padding(.horizontal, 20)
    }
}

// MARK: - API Calls
extension SignupView {
    func callSignup() {
        Task {
            isLoading = true
            let error = try await supabase.signUp(email: email, password: password, name: name, language: language)
            if let errorMessage = error?.localizedDescription {
                alertData.show(message: errorMessage)
            } else {
                self.callCreateUser()
            }
        }
    }
    
    func callCreateUser() {
        Task {
            guard let userId = supabase.user?.id.uuidString else { return }
            let userModel = UserModel(id: userId, name: name, email: email, language: language, social_type: nil, last_login_at: .now, profilePictureURL: nil, createdAt: .now)
            let error = try await supabase.insert(table: .userProfiles, model: userModel)
            self.isLoading = false
            if let errorMessage = error?.localizedDescription {
                alertData.show(message: errorMessage)
            } else {
                self.isSignupSuccess = true
                alertData.show(message: "Account Created Successfully")
            }
        }
    }
}

// MARK: - Methods
extension SignupView {
    func validateFields() -> Bool {
        if let name = name.isValid(for: .requiredField(field: "Name")) {
            alertData.show(message: name)
            return false
        }
        if let emailError = email.isValid(for: .email) {
            alertData.show(message: emailError)
            return false
        }
        if let passwordError = password.isValid(for: .requiredField(field: "Password")) {
            alertData.show(message: passwordError)
            return false
        }
        if let confirmPasswordError = confirmPassword.isValid(for: .requiredField(field: "Confirm Password")) {
            alertData.show(message: confirmPasswordError)
            return false
        }
        if password != confirmPassword {
            alertData.show(message: "Password Mismatch")
            return false
        }
        return true
    }
}

#Preview {
    SignupView(path: .constant([]), supabase: .shared)
}
