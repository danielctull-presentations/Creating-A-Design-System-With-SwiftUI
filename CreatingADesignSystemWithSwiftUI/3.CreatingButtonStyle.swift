
import SlideUI
import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {

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

                        associatedtype Body : View

                        @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body

                        typealias Configuration = ButtonStyleConfiguration
                    }
                    """
                }
            }

            Slide(header: "Creating a Button Style") {
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

            Slide(header: "Suppose we're asked to design a button…") {
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
