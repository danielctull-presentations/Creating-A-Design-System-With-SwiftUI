
import SlideUI
import SwiftUI

private struct Detail<Title: View, Subtitle: View>: View {

    private let title: Title
    private let subtitle: Subtitle

    init(
        @ViewBuilder title: () -> Title,
        @ViewBuilder subtitle: () -> Subtitle
    ) {
        self.title = title()
        self.subtitle = subtitle()
    }

    var body: some View {
        VStack {
            title
            subtitle
        }
    }
}

struct CreatingDetail: View {

    var body: some View {
        Group {

            Slide {
                Code {
                    """
                    struct Detail<Title: View, Subtitle: View>: View {

                        private let title: Title
                        private let subtitle: Subtitle

                        init(
                            @ViewBuilder title: () -> Title,
                            @ViewBuilder subtitle: () -> Subtitle
                        ) {
                            self.title = title()
                            self.subtitle = subtitle()
                        }

                        var body: some View {
                            VStack {
                                title
                                subtitle
                            }
                        }
                    }
                    """
                }
            }
        }
        .slideStyle(.content(alignment: .center))
    }
}
