import SwiftUI

struct IdeaCardView: View {
    let idea: DinnerIdea
    var compact: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(idea.name)
                        .font(.title3).bold()
                    Text(idea.summary)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 6) {
                    difficultyBadge
                    dietTags
                }
            }

            if !compact {
                tagGrid
                ingredientsSection
                stepsSection
            }
        }
        .padding()
        .background(.white, in: RoundedRectangle(cornerRadius: 16))
    }

    private var difficultyBadge: some View {
        Text(idea.difficulty.rawValue.capitalized)
            .font(.caption.weight(.medium))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Color.accentColor.opacity(0.12), in: Capsule())
    }

    private var dietTags: some View {
        HStack(spacing: 6) {
            if idea.isVegetarian { tag("Vegetarian", color: .green.opacity(0.2), textColor: .green) }
            if idea.isVegan { tag("Vegan", color: .mint.opacity(0.2), textColor: .mint) }
            if idea.isGlutenFree { tag("Gluten-free", color: .orange.opacity(0.2), textColor: .orange) }
        }
    }

    private var tagGrid: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(idea.tags, id: \.self) { tagText in
                    tag(tagText, color: Color(.systemGray6), textColor: .secondary)
                }
            }
        }
    }

    private var ingredientsSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Ingredients")
                .font(.subheadline).bold()
            Text(idea.ingredients.joined(separator: ", "))
                .foregroundStyle(.secondary)
        }
    }

    private var stepsSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Steps")
                .font(.subheadline).bold()
            ForEach(Array(idea.steps.enumerated()), id: \.offset) { index, step in
                HStack(alignment: .top, spacing: 6) {
                    Circle().frame(width: 6, height: 6)
                        .foregroundStyle(.secondary)
                        .padding(.top, 6)
                    Text(step)
                        .foregroundStyle(.secondary)
                }
                if index != idea.steps.count - 1 {
                    Divider()
                }
            }
        }
    }

    private func tag(_ text: String, color: Color, textColor: Color) -> some View {
        Text(text)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(color, in: Capsule())
            .foregroundStyle(textColor)
    }
}

#Preview {
    IdeaCardView(idea: MealPlannerViewModel.sampleIdeas.first!)
        .padding()
        .background(Color(.systemGroupedBackground))
}
