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
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 0) {
                getTopView()
                getTextFields()
                    .padding(.top, 20)
                getBottomView()
                    .padding(.vertical, 20)
                
                Spacer()
            }
            .ignoresSafeArea(edges: .all)
            .navigationBarHidden(true)
            .navigationDestination(for: AuthRoute.self, destination: { route in
                switch route {
                case .forgotPassword:
                    EmptyView()
                case .signup:
                    SignupView(path: $path)
                }
            })
        }
        
    }
}

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
                        
                        Text("Sign In and weak up on time and don’t be late.")
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
            PrimaryTextField(icon: "ic_email", placeholder: "Enter Email Address", text: $email)
            PrimaryTextField(icon: "ic_lock", placeholder: "Enter Password", text: $password, fieldType: .secure, isSecureToggleEnabled: true)
            Button {
                print("Forgot Password")
            } label: {
                Text("OR")
                    .font(.getFont(.bold, size: 16))
                    .foregroundStyle(Color(.custom2D2D40))
                    .frame(height: 26)
            }
            
        }
        .padding(.horizontal, 20)
        
    }
    
    func getBottomView() -> some View {
        VStack(spacing: 10) {
            PrimaryButton(text: "Sign In")
            
            Text("OR")
                .font(.getFont(.bold, size: 18))
                .foregroundStyle(Color(.custom2D2D40))
                .frame(height: 28)
            
            PrimaryButton(leftIcon: "ic_google", text: "Sign In With Google")
            
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

#Preview {
    SigninView()
}
