import SwiftUI

struct CartView: View {
    @EnvironmentObject var cart: CartStore
    @Environment(\.dismiss) var dismiss

    var tax: Double { cart.total * 0.08 }
    var grandTotal: Double { cart.total + tax }

    var body: some View {
        Group {
            if cart.items.isEmpty {
                VStack(spacing: 16) {
                    Text("🛒").font(.system(size: 60))
                    Text("your cart is empty")
                        .font(.title3)
                    Button("go add something") { dismiss() }
                        .foregroundColor(.orange)
                }
            } else {
                ZStack(alignment: .bottom) {
                    List {
                        Section("items") {
                            ForEach(cart.items) { item in
                                HStack {
                                    Text(item.emoji)
                                    VStack(alignment: .leading) {
                                        Text(item.name).fontWeight(.medium)
                                        Text(item.details)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)
                                        Text("qty: \(item.quantity)")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    Text("$\(String(format: "%.2f", item.price * Double(item.quantity)))")
                                        .foregroundColor(.orange)
                                }
                            }
                            .onDelete { cart.removeItem(at: $0) }
                        }

                        Section("total") {
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
                                Text("Total").fontWeight(.bold)
                                Spacer()
                                Text("$\(String(format: "%.2f", grandTotal))")
                                    .fontWeight(.bold)
                                    .foregroundColor(.orange)
                            }
                        }

                        Color.clear.frame(height: 90)
                            .listRowBackground(Color.clear)
                    }

                    VStack(spacing: 10) {
                        NavigationLink(destination: PaymentView()) {
                            Text("Proceed to Checkout")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 15)
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        Button("Add More Items") { dismiss() }
                            .foregroundColor(.orange)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 12)
                    .background(.ultraThinMaterial)
                }
            }
        }
        .navigationTitle("Your Cart")
    }
}