import Foundation

// MARK: - Модель таблицы сравнения
struct ComparisonTable: Identifiable, Codable, Equatable {
    let id: String
    let title: String
    let icon: String
    let features: [String]
    let systems: [SystemColumn]
}

// MARK: - Модель колонки системы (например, Бензин / Дизель)
struct SystemColumn: Identifiable, Codable, Equatable {
    let id: String
    let name: String
    let values: [String]
}
