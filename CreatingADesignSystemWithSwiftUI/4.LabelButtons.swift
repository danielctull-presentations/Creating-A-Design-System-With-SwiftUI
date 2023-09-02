
import SlideUI
import SwiftUI

private struct PrimaryButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 60))
            .padding(32)
            .background(.blue, in: RoundedRectangle(cornerRadius: 16))
            .foregroundColor(.white)
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: Self { Self() }
}

struct TextImageButton: View {

    let title: String
    let image: Image
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 100) {
                image
                Text(title)
            }
        }
    }
}

private struct PrimaryButtonLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 100) {
            configuration.icon
            configuration.title
        }
    }
}

struct LabelButtons: View {

    var body: some View {
        Group {

            Slide(header: "And also text with images") {
                #CodePreview {
                    Button("Text",
                           systemImage: "square.and.arrow.up",
                           action: {})
                    .buttonStyle(.primary)
                }
            }

            Slide(header: "\"It'd be great if we could increase the spacing\"") {}

            Slide(header: "Create a view to wrap Button??") {
                Code {
                    """
                    struct TextImageButton: View {

                        let title: String
                        let image: Image
                        let action: () -> Void

                        var body: some View {
                            Button {
                                action()
                            } label: {
                                HStack(spacing: 100) {
                                    image
                                    Text(title)
                                }
                            }
                        }
                    }
                    """
                }
            }

            Slide(header: "Create a view to wrap Button??") {
                #CodePreview {
                    TextImageButton(
                        title: "Text",
                        image: Image(systemName: "square.and.arrow.up"),
                        action: {})
                    .buttonStyle(.primary)
                }
            }

            Slide(header: "What is this Button initialiser?") {
                #Code {
                    Button("Text",
                           systemImage: "square.and.arrow.up",
                           action: {})
                }
            }

            Slide(header: "Button uses the Label type") {
                Code {
                    """
                    extension Button where Label == SwiftUI.Label<Text, Image> {

                        public init(
                            _ titleKey: LocalizedStringKey,
                            systemImage: String,
                            action: @escaping () -> Void
                        )
                    }
                    """
                }
            }

            Slide(header: "What is a Label?") {
                Code {
                    """
                    public struct Label<Title: View, Icon: View>: View {

                        public init(
                            @ViewBuilder title: () -> Title,
                            @ViewBuilder icon: () -> Icon
                        )

                        public typealias Body = some View
                        @MainActor public var body: some View { get }
                    }
                    """
                }
            }

            Slide(header: "What is a Label?") {
                #CodePreview {
                    Label {
                        Text("Text")
                    } icon: {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }

            Slide(header: "Label has a short initialiser for Text and Image") {
                Code {
                    """
                    extension Label where Title == Text, Icon == Image {
                        public init(_ titleKey: LocalizedStringKey, systemImage name: String)
                    }
                    """
                }
            }

            Slide(header: "Label has a short initialiser for Text and Image") {
                #CodePreview {
                    Label("Text", systemImage: "square.and.arrow.up")
                }
            }
        }
        .slideStyle(.content(alignment: .center))
    }
}
