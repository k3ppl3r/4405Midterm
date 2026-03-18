import SwiftUI

struct HomeView: View {
    @EnvironmentObject var cart: CartStore

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.18, green: 0.22, blue: 0.19)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    VStack(spacing: 8) {
                        Text("🥪")
                            .font(.system(size: 60))
                        Text("Stack & Slice Deli")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                        Text("fresh made to order")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.6))
                    }
                    .padding(.top, 60)
                    .padding(.bottom, 44)

                    VStack(spacing: 14) {
                        NavigationLink(destination: BuildYourOwnView()) {
                            MenuCard(emoji: "🛠️", title: "Build Your Own", subtitle: "make it exactly how you want")
                        }
                        NavigationLink(destination: SpecialtyItemsView()) {
                            MenuCard(emoji: "⭐", title: "Specialty Items", subtitle: "chef's picks, ready to order")
                        }
                        NavigationLink(destination: CartView()) {
                            MenuCard(
                                emoji: "🛒",
                                title: "View Cart",
                                subtitle: cart.items.isEmpty ? "nothing in here yet" : "\(cart.items.count) items — $\(String(format: "%.2f", cart.total))"
                            )
                        }
                    }
                    .padding(.horizontal, 20)

                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct MenuCard: View {
    var emoji: String
    var title: String
    var subtitle: String

    var body: some View {
        HStack(spacing: 16) {
            Text(emoji)
                .font(.system(size: 30))
                .frame(width: 50)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.55))
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.white.opacity(0.3))
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 16)
        .background(Color.white.opacity(0.08))
        .cornerRadius(14)
    }
}