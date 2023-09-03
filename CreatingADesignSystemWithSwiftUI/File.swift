import SlideUI
import SwiftUI

struct Testing: View {

    var body: some View {
        Group {
            Slide("Creating a Custom Button") {
                #Code {
                    struct DetailButton<Title: View, Subtitle: View> {
                        let action: () -> Void
                        let title: Title
                        let subtitle: Subtitle
                    }
                }
            }

            Slide("Creating a Custom Button") {
                #CodePreview {
                    Text("Hello")
                        .foregroundStyle(.orange)
                }
            }

            Slide("Creating a Custom Button") {
                Code {
                    """
                    extension DetailButton: View {

                        var body: some View {
                            Button(action: action) {
                                VStack {
                                    title
                                        .font(.headline)
                                    subtitle
                                        .font(.subheadline)
                                }
                            }
                            .padding(10)
                            .background(.orange)
                        }
                    }
                    """
                }
            }

            Slide("Suppose we're asked to design another button…")

            Slide("Creating a Detail view to hold") {
                #Code {
                    struct Detail<Title: View, Subtitle: View>: View {

                        let title: Title
                        let subtitle: Subtitle

                        var body: some View {
                            VStack {
                                title
                                    .font(.headline)
                                subtitle
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }

            Slide("SwiftUI's Label") {
                Code {
                    """
                    public struct Label<Title: View, Icon: View>: View {

                        public typealias Body = some View

                        public init(
                            @ViewBuilder title: () -> Title,
                            @ViewBuilder icon: () -> Icon
                        )

                        public var body: some View { }
                    }
                    """
                }
            }

            Slide("SwiftUI's LabelStyle") {
                Code {
                    """
                    public protocol LabelStyle {

                        /// A view that represents the body of a label.
                        associatedtype Body : View

                        /// Creates a view that represents the body of a label.
                        ///
                        /// The system calls this method for each ``Label`` instance in a view
                        /// hierarchy where this style is the current label style.
                        ///
                        /// - Parameter configuration: The properties of the label.
                        @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body

                        /// The properties of a label.
                        typealias Configuration = LabelStyleConfiguration
                    }
                    """
                }
            }

            Slide {
                Text(
                    """
                    • Form and style are separate concepts in SwiftUI
                    • We can create our own form and style types
                    """
                )
            }

            Slide {

                VStack(spacing: 0) {
                    Text("Daniel Tull")
                    Text("dt@danieltull.co.uk")
                }
                Text("(Yes this presentation was made in SwiftUI.)")
            }
        }
    }
}
