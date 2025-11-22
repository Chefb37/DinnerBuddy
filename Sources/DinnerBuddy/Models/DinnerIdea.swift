import Foundation

struct DinnerIdea: Identifiable, Hashable {
    enum Difficulty: String, CaseIterable, Codable { case easy, medium, hard }
    enum Cuisine: String, CaseIterable, Codable {
        case american = "American"
        case italian = "Italian"
        case mexican = "Mexican"
        case indian = "Indian"
        case mediterranean = "Mediterranean"
        case asianFusion = "Asian Fusion"
        case plantForward = "Plant-forward"
    }

    let id = UUID()
    let name: String
    let cuisine: Cuisine
    let cookTime: Int
    let difficulty: Difficulty
    let tags: [String]
    let ingredients: [String]
    let steps: [String]
    let isVegetarian: Bool
    let isVegan: Bool
    let isGlutenFree: Bool

    var summary: String {
        "\(cookTime)m • \(difficulty.rawValue.capitalized) • \(cuisine.rawValue)"
    }
}
