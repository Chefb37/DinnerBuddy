import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: MealPlannerViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("DinnerBuddy")
                        .font(.largeTitle).bold()
                    Text("Tell us what you feel like, and we will suggest a dinner plan with ingredients and steps.")
                        .foregroundStyle(.secondary)

                    PreferenceChipsView(preference: $viewModel.preference, cuisineTapped: viewModel.toggleCuisine)

                    suggestionSection
                    Divider().padding(.vertical, 8)
                    listSection
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
            .onChange(of: viewModel.preference) { _, _ in viewModel.refreshResults() }
        }
    }

    private var suggestionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Tonight's pick", systemImage: "sparkles")
                .font(.headline)
            IdeaCardView(idea: viewModel.suggestedIdea)
                .shadow(radius: 4, y: 2)
        }
    }

    private var listSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Label("More ideas", systemImage: "fork.knife")
                    .font(.headline)
                Spacer()
                Text("\(viewModel.filteredIdeas.count) matches")
                    .foregroundStyle(.secondary)
            }

            LazyVStack(spacing: 12) {
                ForEach(viewModel.filteredIdeas) { idea in
                    IdeaCardView(idea: idea, compact: true)
                }
            }
        }
    }
}

#Preview {
    ContentView(viewModel: MealPlannerViewModel())
}
