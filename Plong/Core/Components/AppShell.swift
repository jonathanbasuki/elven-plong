import SwiftUI

struct AppShell<Content: View>: View {
    @Binding var selectedPage: AppPage
    @ViewBuilder let content: Content

    var body: some View {
        HStack(spacing: 0) {
            Sidebar(selectedPage: $selectedPage)

            content
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .background(Color.white)
        }
        .background(Color.white)
        .font(.system(.body, design: .default))
        .foregroundStyle(Color.black)
    }
}

private struct Sidebar: View {
    @Binding var selectedPage: AppPage

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("PLONG")
                .font(.system(size: 13, weight: .bold))
                .padding(.bottom, 16)

            VStack(alignment: .leading, spacing: 6) {
                ForEach([AppPage.dashboard, .camera, .history]) { page in
                    SidebarItem(page: page, selectedPage: $selectedPage)
                }
            }

            Spacer()

            SidebarItem(page: .profile, selectedPage: $selectedPage, systemImage: "person.circle.fill")
        }
        .padding(.horizontal, 18)
        .padding(.top, 30)
        .padding(.bottom, 18)
        .frame(width: 180)
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .background(Color.black.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .foregroundStyle(Color.black)
        .padding(.vertical, 24)
        .padding(.horizontal, 24)
        .frame(maxHeight: .infinity, alignment: .topLeading)
    }
}

private struct SidebarItem: View {
    let page: AppPage
    @Binding var selectedPage: AppPage
    var systemImage: String?

    private var isSelected: Bool { selectedPage == page }

    var body: some View {
        Button {
            selectedPage = page
        } label: {
            HStack(spacing: 4) {
                if let systemImage {
                    Image(systemName: systemImage)
                }

                Text(page.rawValue)
            }
            .font(.system(size: 9, weight: isSelected ? .semibold : .regular))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 14)
            .padding(.vertical, 9)
            .background(isSelected ? Color.black.opacity(0.3) : Color.clear)
            .foregroundStyle(Color.black)
            .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}
