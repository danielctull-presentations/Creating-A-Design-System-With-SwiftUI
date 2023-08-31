
import SlideUI
import SwiftUI

private struct VeritcalTextButton: View {

    let title: String
    let subtitle: String
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                Text(title)
                    .font(.system(size: 60))
                Text(subtitle)
                    .font(.system(size: 45))
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

struct NewButtonLayout: View {

    var body: some View {
        Group {

            Slide {
                Code {
                    """
                    struct VeritcalTextButton: View {

                        let title: String
                        let subtitle: String
                        let action: () -> Void

                        var body: some View {
                            Button {
                                action()
                            } label: {
                                VStack {
                                    Text(title)
                                        .font(.system(size: 60))
                                    Text(subtitle)
                                        .font(.system(size: 45))
                                }
                            }
                        }
                    }
                    """
                }
            }

            Slide {
                #CodePreview {
                    VeritcalTextButton(
                        title: "Title",
                        subtitle: "Subtitle",
                        action: {})
                    .buttonStyle(.primary)
                }
            }

            Slide {
                Text("What if different button styles want to style the title and subtitle differently?")
                    .multilineTextAlignment(.center)
            }
        }
        .slideStyle(.content(alignment: .center))
    }
}
