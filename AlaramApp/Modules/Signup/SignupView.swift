//
//  SignupView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 16/07/2025.
//

import SwiftUI

struct SignupView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var language = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
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
                        
                        Text("Sign Up and weak up on time and don’t be late.")
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
            PrimaryButton(text: "Signup")
            
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
                    print("Sign in tapped")
                } label: {
                    Text("Sign In")
                        .underline()
                        .font(.getFont(.bold, size: 16))
                        .foregroundStyle(Color(.customA067D0))
                }

            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    SignupView()
}
