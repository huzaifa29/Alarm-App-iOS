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
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var selectedSpeech: SpeechModel?
    
    // Dependencies
    @Binding var path: [HomeRoute]
    var supabase: SupabaseManager
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView<HomeRoute>(path: $path, title: "Text to speech alarm creation")
            
            VStack(spacing: 20) {
                getTopView()
                
                List {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Recently used speech")
                            .font(.getFont(.semiBold, size: 20))
                            .foregroundStyle(.black)
                        
                        ForEach(arraySpeech.indices, id: \.self) { index in
                            let speechData = self.arraySpeech[index]
                            getListItem(speechData: speechData)
                                .onTapGesture {
                                    self.selectedSpeech = speechData
                                }
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                
                PrimaryButton(text: "Use this speech") {
                    guard let selectedSpeech = self.selectedSpeech else { return }
                    self.path.append(.selectSpeechVoice(speechData: selectedSpeech))
                }
                .opacity(selectedSpeech != nil ? 1 : 0.5)
                .disabled(selectedSpeech == nil)
            }
            .padding(.all, 20)
        }
        .onAppear {
            self.callGetSpeech()
        }
        .onChange(of: alertMessage) {
            showAlert = !alertMessage.isEmpty
        }
        .alert(alertMessage, isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                alertMessage = ""
            }
        }
        .loader(isLoading: isLoading)
        .navigationBarHidden(true)
        
    }
}

// MARK: - UI Methods
extension TextToSpeechAlarmView {
    private func getTopView() -> some View {
        Group {
            VStack(spacing: 8) {
                SecondaryTextField(placeholder: "Name your custom speech", text: $speechName)
                
                ZStack(alignment: .topLeading) {
                    // Placeholder
                    if speechText.isEmpty {
                        Text("Enter your text to create tune...")
                            .foregroundStyle(.customCDA9C3)
                            .font(.getFont(.medium, size: 14))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 20)
                            .zIndex(1)
                    }
                    
                    TextEditor(text: $speechText)
                        .frame(height: 150)
                        .font(.getFont(.medium, size: 14))
                        .foregroundStyle(.customCDA9C3)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 10) // ensures alignment with placeholder
                        .background(Color.clear)
                }
                .frame(height: 150)
                
            }
            
            PrimaryButton(text: "Add Speech") {
                if validateFields() {
                    self.callAddSpeech()
                }
            }
        }
    }
    
    private func getListItem(speechData: SpeechModel) -> some View {
        HStack {
            Text(speechData.description ?? "")
                .font(.getFont(.semiBold, size: 16))
            Spacer()
        }
        .padding(.all, 10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.custom9287FF.opacity(speechData.id == self.selectedSpeech?.id ? 0.2 : 0.1))
        )
    }
}

// MARK: - Methods
extension TextToSpeechAlarmView {
    func validateFields() -> Bool {
        if let speechName = speechName.isValid(for: .requiredField(field: "Speech Name")) {
            alertMessage = speechName
            return false
        }
        if let speechText = speechText.isValid(for: .requiredField(field: "Speech Text")) {
            alertMessage = speechText
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
                alertMessage = error.localizedDescription
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
