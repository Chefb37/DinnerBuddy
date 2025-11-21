import SwiftUI

struct PreferenceChipsView: View {
    @Binding var preference: MealPreference
    var cuisineTapped: (DinnerIdea.Cuisine) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Preferences")
                .font(.headline)

            HStack(spacing: 12) {
                ToggleChip(title: "Quick meals", isOn: $preference.preferQuick)
                ToggleChip(title: "Vegetarian", isOn: $preference.vegetarianOnly)
            }

            HStack(spacing: 12) {
                ToggleChip(title: "Vegan", isOn: $preference.veganOnly)
                ToggleChip(title: "Gluten-free", isOn: $preference.glutenFreeOnly)
            }

            Text("Favorite cuisines")
                .font(.subheadline).bold()
            FlexibleCuisineGrid(preference: $preference, tapAction: cuisineTapped)
        }
    }
}

struct ToggleChip: View {
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        Button(action: { isOn.toggle() }) {
            HStack {
                Image(systemName: isOn ? "checkmark.circle.fill" : "circle")
                Text(title)
            }
            .font(.subheadline.weight(.semibold))
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(isOn ? Color.accentColor.opacity(0.15) : Color(.systemGray6), in: Capsule())
            .foregroundStyle(isOn ? Color.accentColor : Color.primary)
        }
        .buttonStyle(.plain)
    }
}

struct FlexibleCuisineGrid: View {
    @Binding var preference: MealPreference
    var tapAction: (DinnerIdea.Cuisine) -> Void

    private let columns = [GridItem(.adaptive(minimum: 120), spacing: 12)]

    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
            ForEach(DinnerIdea.Cuisine.allCases, id: \.self) { cuisine in
                Button(action: { tapAction(cuisine) }) {
                    HStack {
                        Text(cuisine.rawValue)
                        Spacer()
                        if preference.favoriteCuisines.contains(cuisine) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.accentColor)
                        }
                    }
                    .font(.subheadline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(cuisineBackground(for: cuisine), in: RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func cuisineBackground(for cuisine: DinnerIdea.Cuisine) -> Color {
        preference.favoriteCuisines.contains(cuisine)
            ? Color.accentColor.opacity(0.15)
            : Color(.systemGray6)
    }
}

#Preview {
    PreferenceChipsView(preference: .constant(MealPreference()), cuisineTapped: { _ in })
        .padding()
}
