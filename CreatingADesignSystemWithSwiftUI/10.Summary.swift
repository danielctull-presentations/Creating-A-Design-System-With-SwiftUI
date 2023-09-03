
import SlideUI
import SwiftUI

struct Summary: View {

    var body: some View {
        Group {

            Slide("Summary") {
                BulletedList {
                    Bullet("Prefer providing custom styles over views")
                    Bullet("Nest styles to customise for different contexts")
                    Bullet("Create your own stylable semantic containers")
                    Bullet("Add initialisers to extend standard types")
                }
            }
        }
        .slideStyle(.content(alignment: .center))
    }
}
