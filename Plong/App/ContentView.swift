import SwiftUI

struct ContentView: View {
    @State private var selectedPage: AppPage = .dashboard

    var body: some View {
        AppShell(selectedPage: $selectedPage) {
            selectedPage.content
        }
        .frame(minWidth: 540, minHeight: 460)
    }
}

#Preview {
    ContentView()
}
