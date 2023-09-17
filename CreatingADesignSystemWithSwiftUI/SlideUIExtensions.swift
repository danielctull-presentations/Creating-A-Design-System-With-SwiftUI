
import SlideUI
import SwiftUI

// MARK: - Slide Initialisers

extension Slide<Text, EmptyView, EmptyView, EmptyView> {

    init(_ header: LocalizedStringKey) {
        self.init(header: header) {}
    }
}

extension Slide where Header == Text, Footer == EmptyView, Notes == EmptyView {

    init(_ header: LocalizedStringKey, @ViewBuilder content: () -> Content) {
        self.init(header: header, content: content)
    }
}

extension Slide where Header == Text, Footer == EmptyView {

    init(
        _ header: LocalizedStringKey,
        @ViewBuilder content: () -> Content,
        @ViewBuilder notes: @escaping () -> Notes
    ) {
        self.init {
            content()
        } header: {
            Text(header)
        } footer: {
            EmptyView()
        } notes: {
            notes()
        }
    }
}

// MARK: - Bullet

struct Bullet<Content: View>: View {
    @Environment(\.scale) private var scale
    let content: Content
    var body: some View {
        HStack {
            Text("\u{2022}")
            content
        }
        .padding(4 * scale)
    }
}

extension Bullet<Text> {
    init(_ string: some StringProtocol) {
        self.init(content: Text(string))
    }
}

struct BulletedList<Content: View>: View {
    private var content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading) {
            content
        }
    }
}
