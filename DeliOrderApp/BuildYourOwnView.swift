import SwiftUI

struct BuildYourOwnView: View {
    @EnvironmentObject var cart: CartStore

    @State var bread = "Sourdough"
    @State var protein = "Turkey"
    @State var lettuce = false
    @State var tomato = false
    @State var onion = false
    @State var avocado = false
    @State var jalapeno = false
    @State var bacon = false
    @State var quantity = 1
    @State var justAdded = false

    let breads = ["Sourdough", "Wheat", "White", "Hoagie Roll", "Brioche", "Rye"]
    let proteins = ["Turkey", "Ham", "Chicken", "Roast Beef", "Veggie", "Tuna Salad"]

    var extraCost: Double {
        var extra = 0.0
        if avocado { extra += 1.50 }
        if bacon { extra += 1.25 }
        return extra
    }

    var unitPrice: Double { 8.99 + extraCost }
    var totalPrice: Double { unitPrice * Double(quantity) }

    var toppingsText: String {
        var list: [String] = []
        if lettuce { list.append("Lettuce") }
        if tomato { list.append("Tomato") }
        if onion { list.append("Onion") }
        if avocado { list.append("Avocado") }
        if jalapeno { list.append("Jalapeño") }
        if bacon { list.append("Bacon") }
        if list.isEmpty { return "none" }
        return list.joined(separator: ", ")
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                Section("pick your bread & protein") {
                    Picker("Bread", selection: $bread) {
                        ForEach(breads, id: \.self) { Text($0) }
                    }
                    Picker("Protein", selection: $protein) {
                        ForEach(proteins, id: \.self) { Text($0) }
                    }
                }

                Section("toppings") {
                    Toggle("Lettuce", isOn: $lettuce)
                    Toggle("Tomato", isOn: $tomato)
                    Toggle("Red Onion", isOn: $onion)
                    Toggle("Avocado (+$1.50)", isOn: $avocado)
                    Toggle("Jalapeño", isOn: $jalapeno)
                    Toggle("Bacon (+$1.25)", isOn: $bacon)
                }

                Section("quantity") {
                    Stepper("Quantity: \(quantity)", value: $quantity, in: 1...20)
                }

                Section("your order") {
                    HStack {
                        Text("Bread")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(bread)
                    }
                    HStack {
                        Text("Protein")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(protein)
                    }
                    HStack {
                        Text("Toppings")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(toppingsText)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Total")
                            .fontWeight(.semibold)
                        Spacer()
                        Text("$\(String(format: "%.2f", totalPrice))")
                            .fontWeight(.semibold)
                            .foregroundColor(.orange)
                    }
                }

                // padding so the button doesnt cover the last row
                Color.clear.frame(height: 70)
                    .listRowBackground(Color.clear)
            }

            VStack(spacing: 0) {
                if justAdded {
                    Text("added to cart ✓")
                        .font(.footnote)
                        .foregroundColor(.green)
                        .padding(.bottom, 6)
                        .transition(.opacity)
                }

                Button {
                    let item = CartItem(
                        name: "Custom Sandwich",
                        details: "\(bread), \(protein), \(toppingsText)",
                        price: unitPrice,
                        quantity: quantity,
                        emoji: "🥪"
                    )
                    cart.addItem(item)
                    withAnimation { justAdded = true }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation { justAdded = false }
                    }
                } label: {
                    Text("Add to Cart — $\(String(format: "%.2f", totalPrice))")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                }
            }
            .padding(.bottom, 10)
        }
        .navigationTitle("Build Your Own")
    }
}