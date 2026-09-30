import Foundation

typealias ArticleSection = Section

// MARK: - Секция внутри статьи
struct Section: Identifiable, Codable, Equatable {
    let id: String
    let title: String
    let text: String
}

// MARK: - Подробная статья
struct Article: Identifiable, Codable, Equatable {
    let id: String
    let buttonLabel: String
    let title: String
    let sections: [Section]
}

// MARK: - Компонент/деталь автомобиля
struct Component: Identifiable, Codable, Equatable {
    let id: String
    let name: String
    let description: String
    let commonIssues: String?
    let articles: [Article]?
}

// MARK: - Зона автомобиля (Двигатель, Ходовая и т.д.)
struct VehicleZone: Identifiable, Codable, Equatable {
    let id: String
    let name: String
    let icon: String? // Вернули иконку (SF Symbol)
    let imageName: String
    let components: [Component]
}
