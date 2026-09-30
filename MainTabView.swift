import SwiftUI

struct MainTabView: View {
    let accent = Color(red: 0.65, green: 0.62, blue: 0.55)
    
    // Настройка цвета нижней панели (TabBar), чтобы она не прыгала и не белела
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.14, alpha: 1.0)
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Атлас", systemImage: "car.2.fill")
                }
            
            DiagnosticsView()
                .tabItem {
                    Label("Диагностика", systemImage: "waveform.path.ecg")
                }
        }
        .tint(accent)
        .preferredColorScheme(.dark) // Заставляет всю систему переключиться в темный режим
    }
}
