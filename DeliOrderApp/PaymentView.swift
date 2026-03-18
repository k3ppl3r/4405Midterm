import SwiftUI

struct PaymentView: View {
    @EnvironmentObject var cart: CartStore
    @State var goToConfirmation = false

    var tax: Double { cart.total * 0.08 }
    var grandTotal: Double { cart.total + tax }

    var body: some View {
        List {
            Section("order total") {
                HStack {
                    Text("Subtotal").foregroundColor(.secondary)
                    Spacer()
                    Text("$\(String(format: "%.2f", cart.total))")
                }
                HStack {
                    Text("Tax (8%)").foregroundColor(.secondary)
                    Spacer()
                    Text("$\(String(format: "%.2f", tax))")
                }
                HStack {
                    Text("Amount Due").fontWeight(.bold)
                    Spacer()
                    Text("$\(String(format: "%.2f", grandTotal))")
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                }
            }

            Section("your items") {
                ForEach(cart.items) { item in
                    HStack {
                        Text(item.emoji)
                        Text(item.name)
                        Spacer()
                        Text("x\(item.quantity)")
                            .foregroundColor(.secondary)
                    }
                }
            }

            Section {
                NavigationLink(destination: ConfirmationView(), isActive: $goToConfirmation) {
                    EmptyView()
                }

                Button {
                    goToConfirmation = true
                } label: {
                    HStack {
                        Spacer()
                        Text("Pay Now — $\(String(format: "%.2f", grandTotal))")
                            .fontWeight(.bold)
                            .foregroundColor(grandTotal > 0 ? .white : .gray)
                        Spacer()
                    }
                }
                .listRowBackground(grandTotal > 0 ? Color.orange : Color(.systemGray5))
                .disabled(grandTotal == 0)
            }
        }
        .navigationTitle("Checkout")
    }
}