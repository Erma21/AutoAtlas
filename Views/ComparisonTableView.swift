import SwiftUI

// MARK: - ЭКРАН ТАБЛИЦЫ СРАВНЕНИЯ СИСТЕМ
struct ComparisonTableView: View {
    let table: ComparisonTable

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            // Фоновое свечение для объема
            Circle()
                .fill(Theme.accent.opacity(0.1))
                .blur(radius: 100)
                .frame(width: 300, height: 300)
                .offset(x: 100, y: -200)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 30) {
                    
                    // Шапка
                    HStack(spacing: 12) {
                        Image(systemName: table.icon)
                            .font(.title2)
                            .foregroundStyle(Theme.accent)
                        Text(table.title)
                            .font(.title3.bold())
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // Сама скроллируемая таблица
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top, spacing: 16) {
                            
                            // ЛЕВАЯ КОЛОНКА (Названия параметров)
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Критерий")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundStyle(Theme.accent)
                                    .textCase(.uppercase)
                                    .frame(height: 50, alignment: .bottomLeading)
                                    .padding(.bottom, 16)
                                
                                ForEach(table.features, id: \.self) { feature in
                                    Text(feature)
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundStyle(.white.opacity(0.5))
                                        .frame(height: 85, alignment: .leading)
                                    
                                    // Невидимый разделитель для точного выравнивания высоты строк
                                    Divider().opacity(0)
                                }
                            }
                            .frame(width: 110)
                            
                            // КОЛОНКИ СИСТЕМ (Стеклянные карточки)
                            ForEach(table.systems) { system in
                                VStack(alignment: .center, spacing: 0) {
                                    
                                    // Заголовок системы
                                    Text(system.name)
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundStyle(.white)
                                        .multilineTextAlignment(.center)
                                        .frame(height: 50, alignment: .bottom)
                                        .padding(.bottom, 16)
                                    
                                    // Значения параметров
                                    ForEach(Array(system.values.enumerated()), id: \.offset) { index, value in
                                        Text(value)
                                            .font(.system(size: 14, weight: .regular))
                                            .foregroundStyle(.white.opacity(0.9))
                                            .multilineTextAlignment(.center)
                                            .minimumScaleFactor(0.85)
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 85)
                                        
                                        // Тонкая линия между параметрами внутри карточки
                                        if index < system.values.count - 1 {
                                            Divider().background(Color.white.opacity(0.15))
                                        }
                                    }
                                }
                                .frame(width: 160)
                                .padding(.horizontal, 12)
                                .padding(.bottom, 16)
                                .glassCard(cornerRadius: 24)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
