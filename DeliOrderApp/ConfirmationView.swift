import SwiftUI

struct ConfirmationView: View {
    @EnvironmentObject var cart: CartStore
    @State var showCheck = false

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.green)
                .scaleEffect(showCheck ? 1 : 0.3)
                .animation(.spring(response: 0.5, dampingFraction: 0.5), value: showCheck)

            VStack(spacing: 8) {
                Text("Order Successful!")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Your order has been placed.")
                    .foregroundColor(.secondary)
            }
            .opacity(showCheck ? 1 : 0)
            .animation(.easeIn.delay(0.3), value: showCheck)

            VStack(alignment: .leading, spacing: 10) {
                Label("your food is being made fresh", systemImage: "flame")
                Label("ready in about 10-15 minutes", systemImage: "clock")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            .padding(.top, 8)
            .opacity(showCheck ? 1 : 0)
            .animation(.easeIn.delay(0.5), value: showCheck)

            Spacer()

            NavigationLink(destination: HomeView()) {
                Text("Start New Order")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 32)
            }
            .simultaneousGesture(TapGesture().onEnded {
                cart.clearCart()
            })

            Spacer().frame(height: 10)
        }
        .navigationTitle("Confirmed")
        .navigationBarBackButtonHidden(true)
        .onAppear { showCheck = true }
    }
}