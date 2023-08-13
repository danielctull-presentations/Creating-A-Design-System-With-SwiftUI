
import SlideUI
import SwiftUI

struct PrimaryButton: View {

    let title: String
    let action: () -> Void

    var body: some View {
        Button(title, action: action)
            .buttonStyle(.plain)
            .font(.system(size: 50))
            .padding()
            .background(.blue, in: RoundedRectangle(cornerRadius: 8))
    }
}

struct Section1: View {

    var body: some View {
        Group {
            Slide(header: "Suppose we're asked to design a button…") {
                PrimaryButton(title: "Press me", action: {})
            }

            Slide(header: "Suppose 2") {}
        }
    }
}
