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
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var presentTabbar = false
    
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
                if alertMessage == "Signup Successfull" {
                    name = ""
                    email = ""
                    language = ""
                    password = ""
                    confirmPassword = ""
                    presentTabbar = true
                }
            }
        }
        .fullScreenCover(isPresented: $presentTabbar, content: {
            TabbarView()
        })
        .ignoresSafeArea(edges: .all)
    }
}

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
            PrimaryTextField(icon: "ic_email", placeholder: "Enter Email Address", text: $email)
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
            
            PrimaryButton(leftIcon: "ic_google", text: "Sign Up With Google")
            
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

extension SignupView {
    func callSignup() {
        isLoading = true
        Task {
            do {
                try await supabase.getAuth().signUp(
                    email: email,
                    password: password,
                    data: [
                        "name": .string(name),
                        "language": .string(language)
                    ]
                )
                isLoading = false
                alertMessage = "Signup Successfull"
            } catch {
                print(error)
                alertMessage = error.localizedDescription
                isLoading = false
            }
        }
        
    }
}

extension SignupView {
    func validateFields() -> Bool {
        if name.isEmpty {
            alertMessage = "Enter Name"
            return false
        }
        if email.isEmpty {
            alertMessage = "Enter Email"
            return false
        }
        if password.isEmpty {
            alertMessage = "Enter Password"
            return false
        }
        if confirmPassword.isEmpty {
            alertMessage = "Enter Password"
            return false
        }
        if password != confirmPassword {
            alertMessage = "Password Mismatch"
            return false
        }
        return true
    }
}

#Preview {
    SignupView(path: .constant([]), supabase: .shared)
}
