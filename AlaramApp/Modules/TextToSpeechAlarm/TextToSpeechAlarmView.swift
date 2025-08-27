//
//  TextToSpeechAlarmView.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 20/08/2025.
//

import SwiftUI

struct TextToSpeechAlarmView: View {
    @State private var speechName: String = ""
    @State private var speechText: String = ""
    @State private var arraySpeech = [SpeechModel]()
    @State private var isLoading = false
    @State private var alertData = AlertData()
    @State private var selectedSpeech: SpeechModel?
    
    // Dependencies
    @Binding var path: [HomeRoute]
    var supabase: SupabaseManager
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView<HomeRoute>(path: $path, title: "Text to speech alarm creation")
            
            VStack(spacing: 20) {
                
                Group {
                    SecondaryTextField(placeholder: "Name your custom speech", text: $speechName)
                    
                    PrimaryTextEditor(placeholder: "Enter your text to create tune...", text: $speechText)
                    
                    SecondaryButton(text: "Add Speech") {
                        if validateFields() {
                            self.callAddSpeech()
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Recently used speech")
                            .font(.getFont(.semiBold, size: 20))
                            .foregroundStyle(.black)
                        Spacer()
                    }
                    .frame(height: 32)
                    .background(.white)
                    .padding(.horizontal, 20)
                    
                    List {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(arraySpeech.indices, id: \.self) { index in
                                let speechData = self.arraySpeech[index]
                                getListItem(speechData: speechData)
                                    .onTapGesture {
                                        self.selectedSpeech = speechData
                                    }
                            }
                            .padding(.top, 2)
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .scrollIndicators(.hidden)
                    
                }
                
                SecondaryButton(text: "Use this speech") {
                    guard let selectedSpeech = self.selectedSpeech else { return }
                    self.path.append(.selectSpeechVoice(speechData: selectedSpeech))
                }
                .padding(.horizontal, 20)
                .opacity(selectedSpeech != nil ? 1 : 0.5)
                .disabled(selectedSpeech == nil)
            }
            .padding(.vertical, 20)
        }
        .onAppear {
            self.callGetSpeech()
        }
        .loader(isLoading: isLoading)
        .messageAlert($alertData)
        .navigationBarHidden(true)
        
    }
}

// MARK: - UI Methods
extension TextToSpeechAlarmView {
    private func getListItem(speechData: SpeechModel) -> some View {
        HStack {
            Text(speechData.description ?? "")
                .font(.getFont(.semiBold, size: 16))
            Spacer()
        }
        .padding(.all, 10)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(speechData.id == selectedSpeech?.id ? .hexE6EEFD : .hexF3F7FF) .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(speechData.id == selectedSpeech?.id ? .hex397FD6 : .clear, lineWidth: 2))
        )
        .padding(.horizontal, 20)
        .shadow(color: Color(hex: "#19196F").opacity(0.25), radius: 6.2, x: 0, y: 4)
        .padding(-1)
    }
}

// MARK: - Methods
extension TextToSpeechAlarmView {
    func validateFields() -> Bool {
        if let speechName = speechName.isValid(for: .requiredField(field: "Speech Name")) {
            alertData.show(message: speechName)
            return false
        }
        if let speechText = speechText.isValid(for: .requiredField(field: "Speech Text")) {
            alertData.show(message: speechText)
            return false
        }
        return true
    }
}

// MARK: - API Calls
extension TextToSpeechAlarmView {
    func callGetSpeech() {
        Task {
            self.isLoading = true
            let selectFilter = """
                    *,
                    user_profiles:user_id (*)
                    """
            self.arraySpeech = await supabase.fetchTable(table: .speech, select: selectFilter, filters: ["user_id": supabase.user?.id.uuidString ?? ""], as: SpeechModel.self) ?? []
            self.isLoading = false
        }
    }
    
    func callAddSpeech() {
        Task {
            isLoading = true
            let speechModel = SpeechModel(id: UUID().uuidString, userId: supabase.user?.id.uuidString ?? "", name: speechName, description: speechText, createdAt: .now)
            let error = try await supabase.insert(table: .speech, model: speechModel)
            self.isLoading = false
            if let error = error {
                alertData.show(message: error.localizedDescription)
            } else {
                speechName = ""
                speechText = ""
                self.callGetSpeech()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    TextToSpeechAlarmView(path: .constant([]), supabase: .shared)
}
