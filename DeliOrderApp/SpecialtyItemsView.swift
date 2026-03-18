import SwiftUI

struct SpecialtyItemsView: View {
    @EnvironmentObject var cart: CartStore
    @State var recentlyAdded: UUID? = nil

    var body: some View {
        List(specialtyItems) { item in
            HStack(spacing: 12) {
                Text(item.emoji)
                    .font(.system(size: 36))
                    .frame(width: 50)

                VStack(alignment: .leading, spacing: 3) {
                    Text(item.name)
                        .font(.headline)
                    Text(item.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                    Text("$\(String(format: "%.2f", item.price))")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                        .padding(.top, 1)
                }

                Spacer()

                Button {
                    cart.addItem(CartItem(
                        name: item.name,
                        details: item.description,
                        price: item.price,
                        quantity: 1,
                        emoji: item.emoji
                    ))
                    recentlyAdded = item.id
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        recentlyAdded = nil
                    }
                } label: {
                    Image(systemName: recentlyAdded == item.id ? "checkmark.circle.fill" : "plus.circle.fill")
                        .font(.title2)
                        .foregroundColor(recentlyAdded == item.id ? .green : .orange)
                        .animation(.spring(response: 0.3), value: recentlyAdded)
                }
                .buttonStyle(.plain)
            }
            .padding(.vertical, 6)
        }
        .navigationTitle("Specialty Items")
    }
}