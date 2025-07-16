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
    
    var body: some View {
        VStack(spacing: 0) {
            getTopView()
            
            VStack(spacing: 20) {
                PrimaryTextField(icon: "ic_email", placeholder: "Enter verified Email Address", text: $email)
                PrimaryButton(text: "Send")
            }
            .padding(.all, 20)
            
            Spacer()
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: .all)
        
    }
}

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

#Preview {
    ForgotPasswordView(path: .constant([]))
}
