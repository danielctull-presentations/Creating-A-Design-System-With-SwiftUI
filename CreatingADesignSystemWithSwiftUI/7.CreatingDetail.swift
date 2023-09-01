
import SlideUI
import SwiftUI

struct Detail<Title: View, Subtitle: View, Caption: View>: View {

    @Environment(\.detailStyle) private var style
    private let title: Title
    private let subtitle: Subtitle
    private let caption: Caption

    init(
        @ViewBuilder title: () -> Title,
        @ViewBuilder subtitle: () -> Subtitle,
        @ViewBuilder caption: () -> Caption
    ) {
        self.title = title()
        self.subtitle = subtitle()
        self.caption = caption()
    }

    public var body: some View {
        let configuration = DetailStyleConfiguration(
            title: title,
            subtitle: subtitle,
            caption: caption)
        AnyView(style.resolve(configuration: configuration))
    }
}

struct DetailStyleConfiguration {

    struct Title: View {
        let body: AnyView
    }

    struct Subtitle: View {
        let body: AnyView
    }

    struct Caption: View {
        let body: AnyView
    }

    let title: Title
    let subtitle: Subtitle
    let caption: Caption

    fileprivate init(title: some View, subtitle: some View, caption: some View) {
        self.title = Title(body: AnyView(title))
        self.subtitle = Subtitle(body: AnyView(subtitle))
        self.caption = Caption(body: AnyView(caption))
    }
}

protocol DetailStyle: DynamicProperty {

    typealias Configuration = DetailStyleConfiguration
    associatedtype Body : View

    @ViewBuilder func makeBody(configuration: Configuration) -> Body
}

struct DetailStyleKey: EnvironmentKey {
    static var defaultValue: any DetailStyle = PlainDetailStyle()
}

struct PlainDetailStyle: DetailStyle {

    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.title
                .font(.system(size: 60, weight: .bold))
            configuration.subtitle
                .font(.system(size: 45))
            configuration.caption
                .font(.system(size: 30, weight: .light))
        }
    }
}

extension EnvironmentValues {

    fileprivate var detailStyle: any DetailStyle {
        get { self[DetailStyleKey.self] }
        set { self[DetailStyleKey.self] = newValue }
    }
}

extension View {

    func detailStyle(_ style: some DetailStyle) -> some View {
        environment(\.detailStyle, style)
    }
}

extension DetailStyle {

    fileprivate func resolve(configuration: Configuration) -> some View {
        ResolvedDetailStyle(style: self, configuration: configuration)
    }
}

private struct ResolvedDetailStyle<Style: DetailStyle>: View {

    let style: Style
    let configuration: Style.Configuration

    var body: some View {
        style.makeBody(configuration: configuration)
    }
}

struct CreatingDetail: View {

    var body: some View {
        Group {

            Slide(header: "Creating a semantic container") {
                #Code {
                    struct Detail<Title: View, Subtitle: View, Caption: View>: View {

                        private let title: Title
                        private let subtitle: Subtitle
                        private let caption: Caption

                        init(
                            @ViewBuilder title: () -> Title,
                            @ViewBuilder subtitle: () -> Subtitle,
                            @ViewBuilder caption: () -> Caption
                        ) {
                            self.title = title()
                            self.subtitle = subtitle()
                            self.caption = caption()
                        }

                        var body: some View {
                            VStack {
                                title
                                subtitle
                                caption
                            }
                        }
                    }
                }
            }

            Slide(header: "Styling the semantic container") {
                Code {
                    """
                    protocol DetailStyle: DynamicProperty {

                        typealias Configuration = DetailStyleConfiguration
                        associatedtype Body : View

                        @ViewBuilder func makeBody(configuration: Configuration) -> Body
                    }
                    """
                }
            }

            Slide(header: "What's in a configuration?") {
                #Code {
                    struct DetailStyleConfiguration {

                        struct Title: View {
                            let body: AnyView
                        }

                        struct Subtitle: View {
                            let body: AnyView
                        }

                        struct Caption: View {
                            let body: AnyView
                        }

                        let title: Title
                        let subtitle: Subtitle
                        let caption: Caption

                        fileprivate init(title: some View, subtitle: some View, caption: some View) {
                            self.title = Title(body: AnyView(title))
                            self.subtitle = Subtitle(body: AnyView(subtitle))
                            self.caption = Caption(body: AnyView(caption))
                        }
                    }
                }
            }

            Slide(header: "Setting the style in the environment") {
                Code {
                    #"""
                    struct DetailStyleKey: EnvironmentKey {
                        static var defaultValue: any DetailStyle = PlainDetailStyle()
                    }

                    extension EnvironmentValues {

                        fileprivate var detailStyle: any DetailStyle {
                            get { self[DetailStyleKey.self] }
                            set { self[DetailStyleKey.self] = newValue }
                        }
                    }

                    extension View {

                        func detailStyle(_ style: some DetailStyle) -> some View {
                            environment(\.detailStyle, style)
                        }
                    }
                    """#
                }
            }

            Slide(header: "Providing a default style") {
                #Code {
                    struct PlainDetailStyle: DetailStyle {

                        func makeBody(configuration: Configuration) -> some View {
                            VStack {
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

            Slide(header: "Resolving the style") {
                Code {
                    """
                    extension DetailStyle {

                        fileprivate func resolve(configuration: Configuration) -> some View {
                            ResolvedDetailStyle(style: self, configuration: configuration)
                        }
                    }

                    private struct ResolvedDetailStyle<Style: DetailStyle>: View {

                        let style: Style
                        let configuration: Style.Configuration

                        var body: some View {
                            style.makeBody(configuration: configuration)
                        }
                    }
                    """
                }
            }

            Slide(header: "Using the style in the Detail view") {
                #Code {
                    struct Detail<Title: View, Subtitle: View, Caption: View>: View {

                        @Environment(\.detailStyle) private var style
                        private let title: Title
                        private let subtitle: Subtitle
                        private let caption: Caption

                        init(
                            @ViewBuilder title: () -> Title,
                            @ViewBuilder subtitle: () -> Subtitle,
                            @ViewBuilder caption: () -> Caption
                        ) {
                            self.title = title()
                            self.subtitle = subtitle()
                            self.caption = caption()
                        }

                        public var body: some View {
                            let configuration = DetailStyleConfiguration(
                                title: title,
                                subtitle: subtitle,
                                caption: caption)
                            AnyView(style.resolve(configuration: configuration))
                        }
                    }
                }
            }

            Slide(header: "") {
                #CodePreview {
                    Detail {
                        Text("Heading")
                    } subtitle: {
                        Text("Sub heading")
                    } caption: {
                        Text("Caption")
                    }
                }
            }
        }
    }
}
