
import SlideUI
import SwiftUI

private struct PrimaryButtonLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 100) {
            configuration.icon
            configuration.title
        }
    }
}

private struct PrimaryButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 60))
            .padding(32)
            .background(.blue, in: RoundedRectangle(cornerRadius: 16))
            .foregroundColor(.white)
            .labelStyle(PrimaryButtonLabelStyle())
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: Self { Self() }
}

struct CreatingLabelStyleButton: View {

    var body: some View {
        Group {

            Slide {
                Code {
                    """
                    public protocol LabelStyle {

                        associatedtype Body: View
                        typealias Configuration = LabelStyleConfiguration

                        @ViewBuilder func makeBody(configuration: Configuration) -> Body
                    }
                    """
                }
            }

            Slide {
                Code {
                    """
                    struct PrimaryButtonLabelStyle: LabelStyle {

                        func makeBody(configuration: Configuration) -> some View {
                            HStack(spacing: 100) {
                                configuration.icon
                                configuration.title
                            }
                        }
                    }
                    """
                }
            }

            Slide {
                Code {
                    """
                    private struct PrimaryButtonStyle: ButtonStyle {

                        func makeBody(configuration: Configuration) -> some View {
                            configuration.label
                                .font(.system(size: 60))
                                .padding(32)
                                .background(.blue, in: RoundedRectangle(cornerRadius: 16))
                                .foregroundColor(.white)
                                .labelStyle(PrimaryButtonLabelStyle())
                        }
                    }

                    extension ButtonStyle where Self == PrimaryButtonStyle {
                        static var primary: Self { Self() }
                    }
                    """
                }
            }

            Slide {
                #CodePreview {
                    Button(
                        "Text",
                        systemImage: "square.and.arrow.up",
                        action: {})
                    .buttonStyle(.primary)
                }
            }
        }
        .slideStyle(.content(alignment: .center))
    }
}
