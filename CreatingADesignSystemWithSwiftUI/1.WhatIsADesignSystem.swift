
import SlideUI
import SwiftUI

struct WhatIsADesignSystem: View {

    var body: some View {
        Group {
            Slide(header: "What is a Design System") {
                BulletedList {
                    Bullet("A Toolkit")
                    Bullet("Common resources")
                    Bullet("Common resources")
                }
            }

            Slide(header: "S") {}
        }
    }
}

struct Bullet<Content: View>: View {
    let content: Content
    var body: some View {
        HStack {
            Text("\u{2022}")
            content
        }
    }
}

extension Bullet<Text> {
    init(_ string: some StringProtocol) {
        self.init(content: Text(string))
    }
}

struct BulletedList<Content: View>: View {
    private var content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading) {
            content
        }
    }
}
