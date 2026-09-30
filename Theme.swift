import SwiftUI

// MARK: - 1. Единые цвета приложения
enum Theme {
    /// Единый акцентный цвет для всего приложения (золотисто-бежевый)
    static let accent = Color(red: 0.85, green: 0.80, blue: 0.70)
    
    /// Темный фоновый цвет карточек
    static let cardBackground = Color.black.opacity(0.35)
    
    /// Тонкая светлая рамка для стеклянного эффекта
    static let cardBorder = Color.white.opacity(0.18)
}

// MARK: - 2. Модификатор стеклянной карточки (.glassCard())
struct GlassCardModifier: ViewModifier {
    var cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(Theme.cardBackground)
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Theme.cardBorder, lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

extension View {
    /// Применяет фирменный эффект стеклянной карточки
    func glassCard(cornerRadius: CGFloat = 16) -> some View {
        self.modifier(GlassCardModifier(cornerRadius: cornerRadius))
    }
}

// MARK: - 3. Безопасный стиль нажатия кнопки (замена _onButtonGesture)
struct GlassButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .opacity(configuration.isPressed ? 0.85 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == GlassButtonStyle {
    static var glassTouch: GlassButtonStyle { GlassButtonStyle() }
}
