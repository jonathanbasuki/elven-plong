import SwiftUI

enum AppPage: String, CaseIterable, Identifiable {
    case dashboard = "Overview"
    case camera = "Camera View"
    case history = "History"
    case profile = "Profile"

    var id: String { rawValue }

    @ViewBuilder
    var content: some View {
        switch self {
        case .dashboard:
            DashboardView()
        case .camera:
            CameraView()
        case .history:
            HistoryView()
        case .profile:
            ProfileView()
        }
    }
}
