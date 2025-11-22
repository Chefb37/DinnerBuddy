import Foundation

final class MealPlannerViewModel: ObservableObject {
    @Published var preference = MealPreference()
    @Published private(set) var suggestedIdea: DinnerIdea
    @Published private(set) var filteredIdeas: [DinnerIdea] = []

    private let ideas: [DinnerIdea]

    init(ideas: [DinnerIdea] = MealPlannerViewModel.sampleIdeas) {
        self.ideas = ideas
        self.suggestedIdea = ideas.first ?? DinnerIdea(
            name: "Quick Pasta",
            cuisine: .italian,
            cookTime: 20,
            difficulty: .easy,
            tags: ["Pantry-friendly"],
            ingredients: ["Pasta", "Olive oil", "Garlic"],
            steps: ["Boil pasta", "Toss with oil and garlic"],
            isVegetarian: true,
            isVegan: true,
            isGlutenFree: false
        )
        refreshResults()
    }

    func refreshResults() {
        let matches = ideas.filter { preference.matches($0) }
        filteredIdeas = matches
        suggestedIdea = matches.randomElement() ?? ideas.randomElement() ?? suggestedIdea
    }

    func toggleCuisine(_ cuisine: DinnerIdea.Cuisine) {
        if preference.favoriteCuisines.contains(cuisine) {
            preference.favoriteCuisines.remove(cuisine)
        } else {
            preference.favoriteCuisines.insert(cuisine)
        }
        refreshResults()
    }
}

extension MealPlannerViewModel {
    static let sampleIdeas: [DinnerIdea] = [
        DinnerIdea(
            name: "Lemon Herb Salmon",
            cuisine: .american,
            cookTime: 25,
            difficulty: .medium,
            tags: ["Omega-3", "Sheet pan"],
            ingredients: ["Salmon fillets", "Lemon", "Garlic", "Dill", "Asparagus"],
            steps: ["Season salmon and asparagus", "Roast on sheet pan", "Finish with lemon and dill"],
            isVegetarian: false,
            isVegan: false,
            isGlutenFree: true
        ),
        DinnerIdea(
            name: "Chickpea Tikka Masala",
            cuisine: .indian,
            cookTime: 35,
            difficulty: .medium,
            tags: ["High protein", "Comfort"],
            ingredients: ["Chickpeas", "Coconut milk", "Tomato", "Garam masala", "Basmati rice"],
            steps: ["Simmer sauce", "Fold in chickpeas", "Serve over rice with herbs"],
            isVegetarian: true,
            isVegan: true,
            isGlutenFree: true
        ),
        DinnerIdea(
            name: "Zesty Shrimp Tacos",
            cuisine: .mexican,
            cookTime: 20,
            difficulty: .easy,
            tags: ["Weeknight", "Fresh"],
            ingredients: ["Shrimp", "Corn tortillas", "Cabbage", "Lime", "Chipotle mayo"],
            steps: ["Sear shrimp with spices", "Warm tortillas", "Assemble with slaw and sauce"],
            isVegetarian: false,
            isVegan: false,
            isGlutenFree: true
        ),
        DinnerIdea(
            name: "Creamy Tomato Rigatoni",
            cuisine: .italian,
            cookTime: 30,
            difficulty: .easy,
            tags: ["Pantry", "Comfort"],
            ingredients: ["Rigatoni", "Tomato paste", "Cream", "Parmesan", "Spinach"],
            steps: ["Boil pasta", "Simmer sauce", "Toss with spinach and cheese"],
            isVegetarian: true,
            isVegan: false,
            isGlutenFree: false
        ),
        DinnerIdea(
            name: "Citrus Farro Bowl",
            cuisine: .mediterranean,
            cookTime: 28,
            difficulty: .medium,
            tags: ["Meal prep", "Nutty"],
            ingredients: ["Farro", "Roasted vegetables", "Feta", "Lemon tahini"],
            steps: ["Roast vegetables", "Cook farro", "Assemble with dressing and herbs"],
            isVegetarian: true,
            isVegan: false,
            isGlutenFree: false
        ),
        DinnerIdea(
            name: "Ginger Scallion Noodles",
            cuisine: .asianFusion,
            cookTime: 18,
            difficulty: .easy,
            tags: ["One-pot", "Budget"],
            ingredients: ["Noodles", "Ginger", "Scallions", "Soy sauce", "Sesame oil"],
            steps: ["Sizzle aromatics", "Toss noodles in sauce", "Finish with sesame seeds"],
            isVegetarian: true,
            isVegan: true,
            isGlutenFree: false
        ),
        DinnerIdea(
            name: "Charred Broccoli & Halloumi",
            cuisine: .plantForward,
            cookTime: 22,
            difficulty: .medium,
            tags: ["Low-carb", "Savory"],
            ingredients: ["Broccoli", "Halloumi", "Lemon", "Za'atar"],
            steps: ["Char broccoli", "Sear halloumi", "Finish with spices and lemon"],
            isVegetarian: true,
            isVegan: false,
            isGlutenFree: true
        )
    ]
}
