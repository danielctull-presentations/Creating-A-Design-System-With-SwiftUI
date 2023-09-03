
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

            Slide("ButtonStyle") {
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

            Slide("Creating a primary button style") {
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

            Slide("Using the primary button style") {
                #CodePreview {
                    Button("Press me", action: {})
                        .buttonStyle(PrimaryButtonStyle())
                }
            }

            Slide("Ah, but what about discoverability?") {
                Code {
                    """
                    extension ButtonStyle where Self == PrimaryButtonStyle {
                        static var primary: Self { Self() }
                    }
                    """
                }
            }

            Slide("Ah, but what about discoverability?") {
                #CodePreview {
                    Button("Press me", action: {})
                        .buttonStyle(.primary)
                }
            }

            Slide("We get image handling for nothing!") {
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
