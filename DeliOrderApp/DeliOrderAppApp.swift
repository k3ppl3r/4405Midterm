import SwiftUI

@main
struct DeliOrderAppApp: App {
    @StateObject var cart = CartStore()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(cart)
        }
    }
}