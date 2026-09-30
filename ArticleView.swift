import SwiftUI

struct ArticleView: View {
    var title: String
    var sections: [ArticleSection]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                Text(title).font(.system(size: 30, weight: .bold)).padding(.top, 12)
                
                ForEach(sections) { section in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(section.title).font(.system(size: 17, weight: .semibold))
                        Text(section.text).foregroundStyle(.secondary).lineSpacing(4)
                    }
                }
            }
            .padding(24)
        }
        .navigationTitle("Подробно")
        .navigationBarTitleDisplayMode(.inline)
    }
}
