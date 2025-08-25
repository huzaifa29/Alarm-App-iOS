//
//  ForgotPasswordView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 16/07/2025.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Binding var path: [AuthRoute]
    
    @State private var email = ""
    @State private var isLoading = false
    @State private var alertData = AlertData()
    @State private var isResetPasswordSuccess = false
    
    let supabase: SupabaseManager
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                getTopView()
                
                VStack(spacing: 20) {
                    PrimaryTextField(icon: "ic_email", placeholder: "Enter verified Email Address", text: $email, keyboardType: .emailAddress)
                    PrimaryButton(text: "Send") {
                        if validateFields() {
                            self.callResetPassword()
                        }
                    }
                }
                .padding(.all, 20)
                
                Spacer()
            }
        }
        .loader(isLoading: isLoading)
        .messageAlert($alertData)
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: .all)
        
    }
}

// MARK: - UI Methods
extension ForgotPasswordView {
    func getTopView() -> some View {
        Rectangle().fill(.clear)
            .overlay(
                ZStack {
                    Image(.authTopBanner)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, height: 250)
                    VStack(spacing: 15) {
                        Spacer()
                        Text("Forgot Password")
                            .font(.getFont(.semiBold, size: 30))
                            .foregroundStyle(.white)
                        
                        Text("Enter your verified email we sent you a reset password link")
                            .font(.getFont(.bold, size: 14))
                            .foregroundStyle(.white)
                    }
                    .padding(.bottom, 32)
                }
            )
            .frame(height: 250)
    }
}

// MARK: - API Calls
extension ForgotPasswordView {
    func callResetPassword() {
        Task {
            isLoading = true
            let success = await supabase.resetPassword(email: email)
            isResetPasswordSuccess = success
            if let errorMessage = supabase.errorMessage {
                alertData.show(message: errorMessage)
            } else {
                alertData.show(message: "Reset Password Link Sent")
            }
            isLoading = false
        }
        
    }
}

// MARK: - Methods
extension ForgotPasswordView {
    func validateFields() -> Bool {
        if let emailError = email.isValid(for: .email) {
            alertData.show(message: emailError)
            return false
        }
        return true
    }
}

#Preview {
    ForgotPasswordView(path: .constant([]), supabase: .shared)
}
