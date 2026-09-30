import Foundation

struct ComparisonTable: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let features: [String]
    let systems: [SystemColumn]
}

struct SystemColumn: Identifiable {
    let id = UUID()
    let name: String
    let values: [String]
}
