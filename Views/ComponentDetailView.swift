import SwiftUI

// MARK: - Экран детализации компонента (Модалка)
struct ComponentDetailView: View {
    let component: Component
    var zoneImageName: String = "engineBg"
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // Фоновый рисунок со стеклянной подсветкой
            GeometryReader { geo in
                Image(zoneImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .blur(radius: 30)
                    .overlay(Color.black.opacity(0.55))
                    .clipped()
            }
            .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Главная карточка с описанием
                    VStack(alignment: .leading, spacing: 10) {
                        Text(component.name)
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(.white)
                        
                        Text(component.description)
                            .font(.system(size: 15))
                            .foregroundStyle(.white.opacity(0.82))
                            .lineSpacing(5)
                    }
                    .padding(22)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .glassCard(cornerRadius: 24)
                    
                    // Частые проблемы
                    if let issues = component.commonIssues, !issues.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing: 8) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .font(.system(size: 14))
                                    .foregroundStyle(Theme.accent)
                                
                                Text("ЧАСТЫЕ ПРОБЛЕМЫ")
                                    .font(.system(size: 11, weight: .bold))
                                    .kerning(1.5)
                                    .foregroundStyle(Theme.accent)
                            }
                            
                            Text(issues)
                                .font(.system(size: 14))
                                .foregroundStyle(.white.opacity(0.85))
                                .lineSpacing(4)
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .glassCard(cornerRadius: 22)
                    }
                    
                    // Подробные материалы
                    if let articles = component.articles, !articles.isEmpty {
                        VStack(alignment: .leading, spacing: 14) {
                            Text("ПОДРОБНЫЕ МАТЕРИАЛЫ")
                                .font(.system(size: 11, weight: .bold))
                                .kerning(1.5)
                                .foregroundStyle(.white.opacity(0.5))
                                .padding(.leading, 4)
                            
                            ForEach(articles, id: \.title) { article in
                                NavigationLink(destination: ArticleDetailView(article: article, zoneImageName: zoneImageName)) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(article.buttonLabel)
                                                .font(.system(size: 11, weight: .bold))
                                                .foregroundStyle(Theme.accent)
                                            
                                            Text(article.title)
                                                .font(.system(size: 16, weight: .semibold))
                                                .foregroundStyle(.white)
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 13, weight: .bold))
                                            .foregroundStyle(.white.opacity(0.4))
                                    }
                                    .padding(18)
                                    .glassCard(cornerRadius: 18)
                                }
                                .buttonStyle(.glassTouch)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
        }
        .preferredColorScheme(.dark)
    }
}

// MARK: - Экран чтения конкретной статьи (Стеклянные карточки)
struct ArticleDetailView: View {
    let article: Article
    var zoneImageName: String = "engineBg"
    
    var body: some View {
        ZStack {
            // Фоновое атмосферное размытое фото
            GeometryReader { geo in
                Image(zoneImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .blur(radius: 35)
                    .overlay(Color.black.opacity(0.50))
                    .clipped()
            }
            .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 18) {
                    Text(article.title)
                        .font(.system(size: 26, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.bottom, 4)
                    
                    // Стеклянные карточки для каждой секции
                    ForEach(article.sections) { section in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(section.title)
                                .font(.system(size: 17, weight: .bold))
                                .foregroundStyle(Theme.accent)
                            
                            Text(section.text)
                                .font(.system(size: 15))
                                .foregroundStyle(.white.opacity(0.85))
                                .lineSpacing(5)
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .glassCard(cornerRadius: 22)
                    }
                }
                .padding(20)
            }
        }
        .preferredColorScheme(.dark)
    }
}
