import Foundation

struct MealPreference: Equatable {
    var preferQuick: Bool = true
    var vegetarianOnly: Bool = false
    var veganOnly: Bool = false
    var glutenFreeOnly: Bool = false
    var favoriteCuisines: Set<DinnerIdea.Cuisine> = []

    func matches(_ idea: DinnerIdea) -> Bool {
        if vegetarianOnly && !idea.isVegetarian { return false }
        if veganOnly && !idea.isVegan { return false }
        if glutenFreeOnly && !idea.isGlutenFree { return false }
        if preferQuick && idea.cookTime > 35 { return false }
        if !favoriteCuisines.isEmpty && !favoriteCuisines.contains(idea.cuisine) { return false }
        return true
    }
}
