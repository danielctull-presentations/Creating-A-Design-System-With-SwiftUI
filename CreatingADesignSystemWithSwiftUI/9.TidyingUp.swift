
import SlideUI
import SwiftUI

// MARK: - Button Style

private struct PrimaryButtonDetailStyle: DetailStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.title
                .font(.system(size: 60, weight: .bold))
            configuration.subtitle
                .font(.system(size: 45))
            configuration.caption
                .font(.system(size: 30, weight: .light))
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
            .detailStyle(PrimaryButtonDetailStyle())
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: Self { Self() }
}

// MARK: - Detail Button Initialiser

extension Button<Label<Detail<Text, Text, EmptyView>, Image>> {

    init(
        title: LocalizedStringKey,
        subtitle: LocalizedStringKey,
        systemImage: String,
        action: @escaping () -> Void
    ) {
        self.init(action: action) {
            Label {
                Detail {
                    Text(title)
                } subtitle: {
                    Text(subtitle)
                } caption: {
                    EmptyView()
                }
            } icon: {
                Image(systemName: systemImage)
            }

        }
    }
}

struct TidyingUp: View {

    var body: some View {
        Group {

            Slide("Making a nice Button initialiser") {
                Code {
                    """
                    extension Button<Label<Detail<Text, Text, EmptyView>, Image>> {

                        init(
                            title: LocalizedStringKey,
                            subtitle: LocalizedStringKey,
                            systemImage: String,
                            action: @escaping () -> Void
                        ) {
                            self.init(action: action) {
                                Label {
                                    Detail {
                                        Text(title)
                                    } subtitle: {
                                        Text(subtitle)
                                    } caption: {
                                        EmptyView()
                                    }
                                } icon: {
                                    Image(systemName: systemImage)
                                }

                            }
                        }
                    }
                    """
                }
            }

            Slide("Making a nice Button initialiser") {
                #CodePreview {
                    Button(
                        title: "Title",
                        subtitle: "Subtitle",
                        systemImage: "square.and.arrow.up",
                        action: {})
                    .buttonStyle(.primary)
                }
            }

            Slide("One button style, much content") {
                #CodePreview {
                    VStack {

                        Button(
                            "Title",
                            action: {})

                        Button(
                            "Title",
                            systemImage: "square.and.arrow.up",
                            action: {})

                        Button(
                            title: "Title",
                            subtitle: "Subtitle",
                            caption: "Caption",
                            action: {})

                        Button(
                            title: "Title",
                            subtitle: "Subtitle",
                            systemImage: "square.and.arrow.up",
                            action: {})
                    }
                    .buttonStyle(.primary)
                }
            }
        }
    }
}
