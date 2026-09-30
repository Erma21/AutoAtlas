import SwiftUI

// MARK: - ГЛАВНЫЙ ЭКРАН ПРИЛОЖЕНИЯ
struct ContentView: View {
    @State private var selectedZone: VehicleZone? = nil
    @State private var selectedComponent: Component? = nil
    
    // Новые стейты для поиска и навигации
    @State private var searchText: String = ""
    @State private var showComparisons = false
    
    let bg = Color(red: 0.05, green: 0.05, blue: 0.07)
    let accent = Color(red: 0.85, green: 0.80, blue: 0.70)
    
    // ВЫЧИСЛЯЕМАЯ ЛОГИКА ПОИСКА (Ищет по названиям, описаниям и тексту статей)
    var searchResults: [Component] {
        if searchText.isEmpty { return [] }
        let query = searchText.lowercased()
        
        return allZones.flatMap { $0.components }.filter { comp in
            let matchesName = comp.name.lowercased().contains(query)
            let matchesDesc = comp.description.lowercased().contains(query)
            let matchesIssues = (comp.commonIssues ?? "").lowercased().contains(query)
            
            let matchesArticles = comp.articles?.contains { article in
                article.title.lowercased().contains(query) ||
                article.sections.contains { $0.text.lowercased().contains(query) }
            } ?? false
            
            return matchesName || matchesDesc || matchesIssues || matchesArticles
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                bg.ignoresSafeArea()
                
                Circle()
                    .fill(accent.opacity(0.08))
                    .blur(radius: 120)
                    .frame(width: 320, height: 320)
                    .offset(y: -150)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 28) {
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text("ATLAS AUTO")
                                .font(.system(size: 11, weight: .bold))
                                .kerning(3)
                                .foregroundStyle(accent)
                            
                            Text("Интерактивный\nсправочник")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundStyle(.white)
                        }
                        .padding(.top, 16)
                        
                        // MARK: - ПОИСКОВАЯ СТРОКА
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.gray)
                            TextField("Поиск (например: свечи, тормоза)", text: $searchText)
                                .foregroundStyle(.white)
                                .tint(accent)
                            
                            if !searchText.isEmpty {
                                Button(action: {
                                    withAnimation { searchText = "" }
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                        .padding(14)
                        .background(Color.white.opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.white.opacity(0.1), lineWidth: 1)
                        )
                        
                        // MARK: - ЛОГИКА ОТОБРАЖЕНИЯ (Поиск vs Главный экран)
                        if !searchText.isEmpty {
                            // РЕЗУЛЬТАТЫ ПОИСКА
                            VStack(alignment: .leading, spacing: 16) {
                                Text("НАЙДЕНО: \(searchResults.count)")
                                    .font(.system(size: 11, weight: .bold))
                                    .kerning(1.5)
                                    .foregroundStyle(.white.opacity(0.4))
                                
                                if searchResults.isEmpty {
                                    Text("По запросу «\(searchText)» ничего не найдено.")
                                        .foregroundStyle(.gray)
                                        .padding(.top, 20)
                                } else {
                                    ForEach(searchResults) { component in
                                        InteractiveComponentRow(component: component, accent: accent) {
                                            selectedComponent = component
                                        }
                                    }
                                }
                            }
                        } else {
                            // ГЛАВНЫЙ ЭКРАН (Сравнения + Сетка)
                            
                            // Кнопка перехода к таблицам сравнения
                            NavigationLink(destination: ComparisonsListView(accent: accent)) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Сравнение систем")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundStyle(.white)
                                        Text("Бензин vs Дизель, Типы приводов")
                                            .font(.system(size: 12))
                                            .foregroundStyle(.white.opacity(0.6))
                                    }
                                    Spacer()
                                    Image(systemName: "tablecells")
                                        .font(.title2)
                                        .foregroundStyle(accent)
                                }
                                .padding(16)
                                .background(LinearGradient(colors: [Color.white.opacity(0.1), Color.white.opacity(0.05)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white.opacity(0.15), lineWidth: 1))
                            }
                            
                            VStack(alignment: .leading, spacing: 16) {
                                Text("ВЫБЕРИТЕ РАЗДЕЛ")
                                    .font(.system(size: 11, weight: .bold))
                                    .kerning(1.5)
                                    .foregroundStyle(.white.opacity(0.4))
                                
                                LazyVGrid(columns: [GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14)], spacing: 14) {
                                    ForEach(allZones) { zone in
                                        PremiumZoneCard(zone: zone, accent: accent) {
                                            openZoneMenu(zone)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 120)
                }
                
                // Затемнение фона при открытии шторки
                if selectedZone != nil {
                    Color.black.opacity(0.65)
                        .ignoresSafeArea()
                        .onTapGesture { closeZoneMenu() }
                        .transition(.opacity)
                }
                
                // Выдвижная шторка зоны
                if let zone = selectedZone {
                    VStack(alignment: .leading, spacing: 18) {
                        HStack {
                            HStack(spacing: 12) {
                                Image(systemName: zone.icon).font(.system(size: 20, weight: .semibold)).foregroundStyle(accent)
                                Text(zone.name).font(.system(size: 22, weight: .bold)).foregroundStyle(.white)
                            }
                            Spacer()
                            Button { closeZoneMenu() } label: {
                                Image(systemName: "xmark.circle.fill").font(.system(size: 26)).foregroundStyle(.white.opacity(0.4))
                            }
                        }
                        
                        Divider().background(.white.opacity(0.15))
                        
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 10) {
                                ForEach(zone.components) { component in
                                    InteractiveComponentRow(component: component, accent: accent) {
                                        selectedComponent = component
                                    }
                                }
                                Color.clear.frame(height: 100)
                            }
                            .padding(.vertical, 2)
                        }
                        .frame(maxHeight: 350)
                        .mask(LinearGradient(stops: [.init(color: .black, location: 0.0), .init(color: .black, location: 0.92), .init(color: .clear, location: 1.0)], startPoint: .top, endPoint: .bottom))
                    }
                    .padding(24)
                    .background(
                        ZStack {
                            Image(zone.imageName).resizable().scaledToFill().blur(radius: 20)
                            Rectangle().fill(.ultraThinMaterial)
                            LinearGradient(colors: [Color.black.opacity(0.65), Color.black.opacity(0.88)], startPoint: .top, endPoint: .bottom)
                        }.clipped()
                    )
                    .clipShape(RoundedCornerShape(radius: 32, corners: [.topLeft, .topRight]))
                    .overlay(RoundedCornerShape(radius: 32, corners: [.topLeft, .topRight]).stroke(.white.opacity(0.18), lineWidth: 1))
                    .shadow(color: .black.opacity(0.7), radius: 30, x: 0, y: -10)
                    .transition(.move(edge: .bottom))
                }
            }
            .animation(.easeInOut(duration: 0.28), value: selectedZone)
            .animation(.easeInOut, value: searchText)
            .sheet(item: $selectedComponent) { component in
                NavigationStack {
                    ComponentDetailView(
                        component: component,
                        zoneImageName: getZoneImageName(for: component)
                    )
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Закрыть") { selectedComponent = nil }
                                .foregroundStyle(accent)
                                .font(.system(size: 15, weight: .semibold))
                        }
                    }
                }
            }
        }
    }
    
    private func getZoneImageName(for component: Component) -> String {
        allZones.first(where: { $0.components.contains(component) })?.imageName ?? "engineBg"
    }
    
    private func openZoneMenu(_ zone: VehicleZone) {
        withAnimation { selectedZone = zone }
    }
    
    private func closeZoneMenu() {
        withAnimation { selectedZone = nil }
    }
}

// MARK: - ЭКРАН СПИСКА СРАВНЕНИЙ
struct ComparisonsListView: View {
    let accent: Color
    let bg = Color(red: 0.05, green: 0.05, blue: 0.07)
    
    var body: some View {
        ZStack {
            bg.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 16) {
                    // Убедитесь, что массив systemComparisons объявлен в вашем проекте
                    ForEach(systemComparisons) { table in
                        NavigationLink(destination: ComparisonTableView(table: table)) {
                            HStack {
                                Image(systemName: table.icon)
                                    .font(.title2)
                                    .foregroundStyle(accent)
                                    .frame(width: 40)
                                Text(table.title)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundStyle(.white)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.gray)
                            }
                            .padding(20)
                            .background(Color.white.opacity(0.05))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                    }
                }
                .padding(20)
            }
        }
        .navigationTitle("Сравнения")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(bg, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

// MARK: - КАРТОЧКА ЗОНЫ
struct PremiumZoneCard: View {
    let zone: VehicleZone
    let accent: Color
    let action: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: action) {
            GeometryReader { geo in
                ZStack(alignment: .topLeading) {
                    Image(zone.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .brightness(isPressed ? -0.12 : 0)
                        .clipped()
                    
                    LinearGradient(
                        colors: [
                            .black.opacity(0.15),
                            .black.opacity(0.45),
                            .black.opacity(isPressed ? 0.95 : 0.85)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Image(systemName: zone.icon)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(accent)
                            .frame(width: 38, height: 38)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(.white.opacity(0.15), lineWidth: 1))
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text(zone.name)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                            
                            Text("\(zone.components.count) элементов")
                                .font(.system(size: 12))
                                .foregroundStyle(.white.opacity(0.6))
                        }
                    }
                    .padding(14)
                }
            }
        }
        .frame(height: 175)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(.white.opacity(isPressed ? 0.3 : 0.12), lineWidth: 1)
        )
        .scaleEffect(isPressed ? 0.96 : 1.0)
        .shadow(color: .black.opacity(0.35), radius: 8, x: 0, y: 4)
        .buttonStyle(PlainButtonStyle())
        ._onButtonGesture { pressing in
            withAnimation(.easeInOut(duration: 0.12)) {
                isPressed = pressing
            }
        } perform: {
            action()
        }
    }
}

// MARK: - ЭЛЕМЕНТ СПИСКА В ШТОРКЕ
struct InteractiveComponentRow: View {
    let component: Component
    let accent: Color
    let action: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(component.name)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.white)
                
                Spacer()
                
                Image(systemName: "arrow.up.right")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(accent)
            }
            .padding(18)
            .background(isPressed ? Color.white.opacity(0.12) : Color.white.opacity(0.06))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(.white.opacity(isPressed ? 0.25 : 0.08), lineWidth: 1)
            )
            .scaleEffect(isPressed ? 0.98 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        ._onButtonGesture { pressing in
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = pressing
            }
        } perform: {
            action()
        }
    }
}

// MARK: - КАСТОМНАЯ ФОРМА С СКРУГЛЕНИЕМ УГЛОВ
struct RoundedCornerShape: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    ContentView()
}
