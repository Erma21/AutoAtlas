import SwiftUI

struct DiagnosticsView: View {
    @State private var selectedSymptom: Symptom? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("СИМПТОМЫ И НЕИСПРАВНОСТИ")
                            .font(.system(size: 12, weight: .bold))
                            .kerning(1.2)
                            .foregroundStyle(Theme.accent)
                            .padding(.top, 10)
                        
                        ForEach(sampleSymptoms) { symptom in
                            Button {
                                selectedSymptom = symptom
                            } label: {
                                HStack(spacing: 16) {
                                    Image(systemName: symptom.icon)
                                        .font(.system(size: 20))
                                        .foregroundStyle(Theme.accent)
                                        .frame(width: 44, height: 44)
                                        .background(Color.white.opacity(0.08))
                                        .clipShape(Circle())
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(symptom.title)
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundStyle(.white)
                                            .multilineTextAlignment(.leading)
                                        
                                        Text(symptom.description)
                                            .font(.system(size: 13))
                                            .foregroundStyle(.white.opacity(0.6))
                                            .lineLimit(2)
                                            .multilineTextAlignment(.leading)
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 12))
                                        .foregroundStyle(.white.opacity(0.3))
                                }
                                .padding(16)
                                .glassCard(cornerRadius: 16)
                            }
                            .buttonStyle(.glassTouch)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            .navigationTitle("Диагностика")
            .toolbarBackground(Color.black, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .sheet(item: $selectedSymptom) { symptom in
                SymptomDetailSheet(symptom: symptom)
            }
        }
    }
}

// Всплывающее окно с деталями симптома
struct SymptomDetailSheet: View {
    let symptom: Symptom
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Image(systemName: symptom.icon)
                        .font(.system(size: 24))
                        .foregroundStyle(Theme.accent)
                    Text(symptom.title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.white)
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 22))
                            .foregroundStyle(.white.opacity(0.3))
                    }
                    .buttonStyle(.glassTouch)
                }
                .padding(.top, 20)
                
                Text(symptom.description)
                    .foregroundStyle(.white.opacity(0.8))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("ЧТО ДЕЛАТЬ")
                        .font(.system(size: 11, weight: .bold))
                        .kerning(1)
                        .foregroundStyle(Theme.accent)
                    
                    Text(symptom.advice)
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                        .padding(14)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .glassCard(cornerRadius: 12)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("ВОЗМОЖНЫЕ ПРИЧИНЫ")
                        .font(.system(size: 11, weight: .bold))
                        .kerning(1)
                        .foregroundStyle(Theme.accent)
                    
                    ForEach(symptom.probableComponentNames, id: \.self) { componentName in
                        HStack {
                            Image(systemName: "wrench.and.screwdriver.fill")
                                .foregroundStyle(Theme.accent)
                            Text(componentName)
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        .padding(12)
                        .glassCard(cornerRadius: 10)
                    }
                }
                
                Spacer()
            }
            .padding(24)
        }
        .preferredColorScheme(.dark)
        .presentationDetents([.medium, .large])
    }
}
