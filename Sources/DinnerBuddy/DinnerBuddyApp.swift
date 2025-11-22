import SwiftUI

@main
struct DinnerBuddyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: MealPlannerViewModel())
        }
    }
}
