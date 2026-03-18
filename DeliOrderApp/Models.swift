import Foundation

struct CartItem: Identifiable {
    let id = UUID()
    var name: String
    var details: String
    var price: Double
    var quantity: Int
    var emoji: String
}

struct SpecialtyItem: Identifiable {
    let id = UUID()
    var name: String
    var description: String
    var price: Double
    var emoji: String
}

class CartStore: ObservableObject {
    @Published var items: [CartItem] = []

    var total: Double {
        var sum = 0.0
        for item in items {
            sum += item.price * Double(item.quantity)
        }
        return sum
    }

    func addItem(_ item: CartItem) {
        items.append(item)
    }

    func removeItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    func clearCart() {
        items = []
    }
}

let specialtyItems: [SpecialtyItem] = [
    SpecialtyItem(name: "The Club Classic", description: "Turkey, ham, bacon, lettuce, tomato, swiss on sourdough", price: 12.99, emoji: "🥪"),
    SpecialtyItem(name: "BBQ Brisket Melt", description: "Slow-cooked brisket, cheddar, pickles, BBQ sauce on brioche", price: 14.49, emoji: "🍖"),
    SpecialtyItem(name: "Veggie Garden", description: "Avocado, cucumber, roasted peppers, sprouts, hummus on wheat", price: 10.99, emoji: "🥗"),
    SpecialtyItem(name: "Spicy Italian", description: "Salami, pepperoni, provolone, banana peppers, oil & vinegar on hoagie", price: 13.49, emoji: "🌶️"),
    SpecialtyItem(name: "The BLT Supreme", description: "Extra crispy bacon, heirloom tomato, butter lettuce, mayo on white", price: 11.49, emoji: "🥓"),
    SpecialtyItem(name: "Philly Cheesesteak", description: "Shaved ribeye, sauteed onions & peppers, provolone on hoagie roll", price: 15.99, emoji: "🧀"),
    SpecialtyItem(name: "Tuna Melt", description: "House tuna salad, cheddar, tomato, toasted sourdough", price: 10.49, emoji: "🐟"),
    SpecialtyItem(name: "Buffalo Chicken Wrap", description: "Crispy chicken, buffalo sauce, ranch, shredded lettuce, tomato", price: 12.49, emoji: "🌯")
]