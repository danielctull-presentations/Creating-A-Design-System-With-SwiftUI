
import SlideUI
import SwiftUI

struct Title: View {

    var body: some View {
        Slide(header: "Creating a Design System with SwiftUI") {
            Text("Daniel Tull")
        }
        .slideStyle(.title)
    }
}

struct ContentView: View {

    var body: some View {
        Presentation {

            Title()

//            WhatIsADesignSystem()

//            DefiningTheProblem()

//            CreatingButtonStyle()

//            LabelButtons()

            CreatingLabelStyleButton()

            // Start with a button using Label.


        }
        .slideStyle(.content(alignment: .leading))
    }
}
