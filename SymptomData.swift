import Foundation

struct Symptom: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var icon: String
    var probableComponentNames: [String]
    var advice: String
}

let sampleSymptoms = [
    Symptom(
        title: "Металлический свист при торможении",
        description: "Высокий писк или свист со стороны колёс, который появляется при нажатии на педаль тормоза.",
        icon: "speaker.wave.3.fill",
        probableComponentNames: ["Тормозные колодки", "Тормозной диск"],
        advice: "Сработал механический индикатор износа («писку»). Скорее всего, износились тормозные колодки, их нужно срочно заменить."
    ),
    Symptom(
        title: "Щелчки при повороте ключа зажигания",
        description: "Двигатель не крутится, под капотом слышны частые или одиночные металлические щелчки.",
        icon: "bolt.fill",
        probableComponentNames: ["Аккумулятор", "Стартер"],
        advice: "Втягивающее реле стартера срабатывает, но аккумулятору не хватает напряжения, чтобы провернуть маховик. Проверь заряд АКБ или клеммы."
    ),
    Symptom(
        title: "Глухой стук на кочках и неровностях",
        description: "При проезде лежачих полицейских или ям слышен отчётливый глухой стук.",
        icon: "car.side.fill",
        probableComponentNames: ["Амортизатор"],
        advice: "Проверь состояние амортизаторов на предмет подтеков масла и износ втулок/стоек стабилизатора."
    )
]
