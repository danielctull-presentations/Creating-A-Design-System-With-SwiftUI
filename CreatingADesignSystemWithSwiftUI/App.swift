
import SlideUI
import SwiftUI

struct Title: View {
    var body: some View {
        Slide("Creating a Design System with SwiftUI") {
            Text("Daniel Tull")
        }
        .slideStyle(.title)
    }
}

struct End: View {
    var body: some View {
        Slide("Daniel Tull") {
            Text("danieltull.co.uk")
        }
        .slideStyle(.title)
    }
}

@main
struct CreatingADesignSystemWithSwiftUIApp: App {
    var body: some Scene {
        Presentation {

            Title()

            WhatIsADesignSystem()

            DefiningTheProblem()

            CreatingButtonStyle()

            LabelButtons()

            CreatingLabelStyleButton()

            NewButtonLayout()

            CreatingDetail()

            CreatingButtonDetail()

            UsingEmptyView()

            Summary()

            End()
        }
        .slideStyle(.content(alignment: .center))
    }
}
