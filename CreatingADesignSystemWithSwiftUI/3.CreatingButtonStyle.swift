
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

struct CreatingButtonStyle: View {

    var body: some View {
        Group {

            Slide(header: "ButtonStyle") {
                Code {
                    """
                    public protocol ButtonStyle {

                        associatedtype Body: View
                        typealias Configuration = ButtonStyleConfiguration

                        @ViewBuilder func makeBody(configuration: Configuration) -> Body
                    }
                    """
                }
            }

            Slide(header: "Creating a primary button style") {
                #Code {
                    struct PrimaryButtonStyle: ButtonStyle {

                        func makeBody(configuration: Configuration) -> some View {

                            configuration.label
                                .font(.system(size: 60))
                                .padding(32)
                                .background(.blue, in: RoundedRectangle(cornerRadius: 16))
                                .foregroundColor(.white)
                        }
                    }
                }
            }

            Slide(header: "Using the primary button style") {
                #CodePreview {
                    Button("Press me", action: {})
                        .buttonStyle(PrimaryButtonStyle())
                }
            }

            Slide(header: "Ah, but what about discoverability?") {
                Code {
                    """
                    extension ButtonStyle where Self == PrimaryButtonStyle {
                        static var primary: Self { Self() }
                    }
                    """
                }
            }

            Slide(header: "Ah, but what about discoverability?") {
                #CodePreview {
                    Button("Press me", action: {})
                        .buttonStyle(.primary)
                }
            }

            Slide(header: "We get image handling for nothing!") {
                #CodePreview {
                    Button {
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .buttonStyle(.primary)
                }
            }
        }
        .slideStyle(.content(alignment: .center))
    }
}
