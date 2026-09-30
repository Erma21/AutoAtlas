import SwiftUI

struct MainTabView: View {
    
    // Настройка цвета нижней панели (TabBar)
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.12, alpha: 1.0)
        
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
        .tint(Theme.accent)
        .preferredColorScheme(.dark)
    }
}
