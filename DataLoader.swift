import Foundation

enum DataLoader {
    /// Загружает и декодирует JSON из главного комплекта (Bundle)
    static func loadVehicles() -> [VehicleZone] {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            print("❌ Ошибка: Файл data.json не найден в Bundle")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([VehicleZone].self, from: data)
        } catch {
            print("❌ Ошибка декодирования data.json: \(error)")
            return []
        }
    }
}
