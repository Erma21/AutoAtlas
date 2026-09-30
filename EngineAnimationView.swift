import SwiftUI
import Combine

struct EngineAnimationView: View {
    @State var pistonUp = true
    let timer = Timer.publish(every: 0.6, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Работа поршня и коленвала")
                .font(.system(size: 17, weight: .semibold))
            
            ZStack {
                // Цилиндр (просто рамка)
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 2)
                    .frame(width: 80, height: 160)
                
                // Поршень
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.orange)
                    .frame(width: 70, height: 40)
                    .offset(y: pistonUp ? -50 : 30)
                    .animation(.easeInOut(duration: 0.6), value: pistonUp)
                
                // Коленвал (кружок под цилиндром)
                Circle()
                    .stroke(Color.blue, lineWidth: 3)
                    .frame(width: 60, height: 60)
                    .offset(y: 130)
                    .rotationEffect(.degrees(pistonUp ? 0 : 180))
                    .animation(.easeInOut(duration: 0.6), value: pistonUp)
            }
            .frame(height: 220)
            
            Text(pistonUp ? "Такт сжатия / рабочий ход" : "Такт впуска / выпуска")
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
        }
        .onReceive(timer) { _ in
            pistonUp.toggle()
        }
    }
}
