
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

struct ContentView: View {

    var body: some View {
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

            TidyingUp()

            Summary()

            End()
        }
        .slideStyle(.content(alignment: .center))
    }
}
