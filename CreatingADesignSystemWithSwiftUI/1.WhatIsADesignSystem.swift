
import SlideUI
import SwiftUI

struct WhatIsADesignSystem: View {

    var body: some View {
        Group {
            Slide("What is a Design System?") {
                BulletedList {
                    Bullet("Process")
                    Bullet("Documentation")
                    Bullet("Common resources")
                    Bullet("Functional libraries")
                }
            }
        }
    }
}
