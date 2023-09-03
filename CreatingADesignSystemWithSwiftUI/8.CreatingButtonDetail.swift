
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

extension Button where Label == Detail<Text, Text, Text> {

    init(
        title: LocalizedStringKey,
        subtitle: LocalizedStringKey,
        caption: LocalizedStringKey,
        action: @escaping () -> Void
    ) {
        self.init(action: action) {
            Detail {
                Text(title)
            } subtitle: {
                Text(subtitle)
            } caption: {
                Text(caption)
            }
        }
    }
}

extension Button where Label == SwiftUI.Label<Detail<Text, Text, Text>, Image> {

    init(
        title: LocalizedStringKey,
        subtitle: LocalizedStringKey,
        caption: LocalizedStringKey,
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
                    Text(caption)
                }
            } icon: {
                Image(systemName: systemImage)
            }

        }
    }
}

struct CreatingButtonDetail: View {

    var body: some View {
        Group {

            Slide("Style Detail inside PrimaryButtonStyle") {
                #Code {
                    struct PrimaryButtonDetailStyle: DetailStyle {

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
                }
            }

            Slide("Style Detail inside PrimaryButtonStyle") {
                #Code {
                    struct PrimaryButtonStyle: ButtonStyle {

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
                }
            }

            Slide("Button with the detail style") {
                #CodePreview {
                    Button {
                    } label: {
                        Detail {
                            Text("Title")
                        } subtitle: {
                            Text("Subtitle")
                        } caption: {
                            Text("Caption")
                        }
                    }
                    .buttonStyle(.primary)
                }
            }

            Slide("Create a Button convenience initialiser") {
                Code {
                    """
                    extension Button where Label == Detail<Text, Text, Text> {

                        init(
                            title: LocalizedStringKey,
                            subtitle: LocalizedStringKey,
                            caption: LocalizedStringKey,
                            action: @escaping () -> Void
                        ) {
                            self.init(action: action) {
                                Detail {
                                    Text(title)
                                } subtitle: {
                                    Text(subtitle)
                                } caption: {
                                    Text(caption)
                                }
                            }
                        }
                    }
                    """
                }
            }

            Slide("Create a Button convenience initialiser") {
                #CodePreview {
                    Button(
                        title: "Title",
                        subtitle: "Subtitle",
                        caption: "Caption",
                        action: {})
                    .buttonStyle(.primary)
                }
            }

            Slide("Styles nest!") {
                #CodePreview {
                    Button {
                    } label: {
                        Label {
                            Detail {
                                Text("Title")
                            } subtitle: {
                                Text("Subtitle")
                            } caption: {
                                Text("Caption")
                            }
                        } icon: {
                            Image(systemName: "square.and.arrow.up")
                        }
                    }
                    .buttonStyle(.primary)
                }
            }

            Slide("Nested Button convenience initialiser") {
                Code {
                    """
                    extension Button where Label == SwiftUI.Label<Detail<Text, Text, Text>, Image> {

                        init(
                            title: LocalizedStringKey,
                            subtitle: LocalizedStringKey,
                            caption: LocalizedStringKey,
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
                                        Text(caption)
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

            Slide("Nested Button convenience initialiser") {
                #CodePreview {
                    Button(
                        title: "Title",
                        subtitle: "Subtitle",
                        caption: "Caption",
                        systemImage: "square.and.arrow.up",
                        action: {})
                    .buttonStyle(.primary)
                }
            }
        }
    }
}
