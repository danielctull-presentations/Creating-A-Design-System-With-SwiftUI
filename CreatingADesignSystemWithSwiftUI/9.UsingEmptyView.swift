
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

extension Button where Label == SwiftUI.Label<Detail<Text, Text, EmptyView>, Image> {

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

struct UsingEmptyView: View {

    var body: some View {
        Group {

            Slide("What if we don't want a caption?") {
                Button(
                    title: "Title",
                    subtitle: "Subtitle",
                    systemImage: "square.and.arrow.up",
                    action: {})
                .buttonStyle(.primary)
            }

            Slide("What if we don't want a caption?") {
                #CodePreview {
                    Button {
                    } label: {
                        Label {
                            Detail {
                                Text("Title")
                            } subtitle: {
                                Text("Subtitle")
                            } caption: {
                                EmptyView()
                            }
                        } icon: {
                            Image(systemName: "square.and.arrow.up")
                        }
                    }
                    .buttonStyle(.primary)
                }
            }

            Slide("What if we don't want a caption?") {
                Code {
                    """
                    extension Button where Label == SwiftUI.Label<Detail<Text, Text, EmptyView>, Image> {

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

            Slide("What if we don't want a caption?") {
                #CodePreview {
                    Button(
                        title: "Title",
                        subtitle: "Subtitle",
                        systemImage: "square.and.arrow.up",
                        action: {})
                    .buttonStyle(.primary)
                }
            }
        }
    }
}
