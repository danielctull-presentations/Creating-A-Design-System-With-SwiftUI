
import SlideUI
import SwiftUI

struct Summary: View {

    var body: some View {
        Group {

            Slide(header: "Summary") {
                BulletedList {
                    Bullet("Use ButtonStyle to style buttons")
                    Bullet("Use LabelStyle to style icon & text in buttons")
                    Bullet("Create your own stylable containers to use in buttons")

                }
            }
        }
        .slideStyle(.content(alignment: .center))
    }
}
