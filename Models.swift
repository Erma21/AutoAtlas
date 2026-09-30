import Foundation

// MARK: - Модели данных

struct VehicleZone: Identifiable, Equatable {
    var id: UUID
    var name: String
    var icon: String
    var imageName: String
    var components: [Component]

    // Инициализатор с дефолтным UUID
    init(id: UUID = UUID(), name: String, icon: String, imageName: String, components: [Component]) {
        self.id = id
        self.name = name
        self.icon = icon
        self.imageName = imageName
        self.components = components
    }

    static func == (lhs: VehicleZone, rhs: VehicleZone) -> Bool {
        lhs.id == rhs.id
    }
}

struct Component: Identifiable, Equatable {
    var id: UUID
    var name: String
    var description: String
    var commonIssues: String?
    var articles: [Article]?

    // Инициализатор с дефолтным UUID
    init(id: UUID = UUID(), name: String, description: String, commonIssues: String? = nil, articles: [Article]? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.commonIssues = commonIssues
        self.articles = articles
    }

    static func == (lhs: Component, rhs: Component) -> Bool {
        lhs.id == rhs.id
    }
}

struct Article: Equatable {
    var title: String
    var buttonLabel: String
    var sections: [ArticleSection]

    // 1. Стандартный порядок: title -> buttonLabel -> sections
    init(title: String, buttonLabel: String = "Подробный разбор", sections: [ArticleSection]) {
        self.title = title
        self.buttonLabel = buttonLabel
        self.sections = sections
    }

    // 2. Обратный порядок: buttonLabel -> title -> sections (убирает ошибку!)
    init(buttonLabel: String = "Подробный разбор", title: String, sections: [ArticleSection]) {
        self.title = title
        self.buttonLabel = buttonLabel
        self.sections = sections
    }
}

struct ArticleSection: Identifiable, Equatable {
    var id = UUID()
    var title: String
    var text: String
}
