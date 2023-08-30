
import SlideUI
import SwiftUI

// MARK: - TitleSlideStyle

extension SlideStyle where Self == TitleSlideStyle {
    static var title: Self { Self() }
}

struct TitleSlideStyle: SlideStyle {

    func makeBody(configuration: Configuration) -> some View {
        FontMultiplier { multiplier in

            VStack(spacing: multiplier * 50) {

                configuration.header
                    .font(.system(size: multiplier * 100, weight: .light, design: .rounded))

                configuration.content
                    .font(.system(size: multiplier * 70, weight: .light, design: .rounded))
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(multiplier * 50)
        }
        .foregroundColor(.black)
        .background(.white)
    }
}

// MARK: - ContentSlideStyle

extension SlideStyle where Self == ContentSlideStyle {

    static func content(alignment: Alignment) -> Self {
        Self(alignment: alignment)
    }
}

struct ContentSlideStyle: SlideStyle {

    let alignment: Alignment

    struct SlideWrapper: View {

        let alignment: Alignment
        let configuration: SlideConfiguration
        @Environment(\.scale) var scale

        var body: some View {
            VStack {

                configuration.header
                    .font(.system(size: scale * 24, weight: .light, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.orange)

                configuration.content
                    .font(.system(size: scale * 18, weight: .light, design: .rounded))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)

                configuration.footer
                    .font(.system(size: scale * 12, weight: .light, design: .rounded))
            }
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(scale * 8)
            .codeStyle(.fitting(idealSize: scale * 14))
        }
    }

    func makeBody(configuration: Configuration) -> some View {
        Scale {
            SlideWrapper(alignment: alignment, configuration: configuration)
        }
        .foregroundColor(.black)
        .background(.white)
        .codePreviewStyle(.vertical)
    }
}

// MARK: - FittingCodeStyle

extension CodeStyle where Self == FittingCodeStyle {

    static func fitting(idealSize: CGFloat, weight: Font.Weight = .regular) -> Self {
        Self(idealSize: idealSize, weight: weight)
    }
}

struct FittingCodeStyle: CodeStyle {

    private let weight: Font.Weight
    private let sizes: [Int]

    fileprivate init(idealSize: CGFloat, weight: Font.Weight) {
        self.weight = weight
        self.sizes = (0...Int(idealSize)).reversed()
    }

    func makeBody(configuration: Configuration) -> some View {
        ViewThatFits {
            ForEach(sizes, id: \.self) { size in
                configuration.code
                    .lineSpacing(CGFloat(size) / 8)
                    .font(.system(size: CGFloat(size), weight: weight, design: .monospaced))
            }
        }
    }
}

// MARK: - FontMultiplier

struct FontMultiplier<Content: View>: View {

    let content: (CGFloat) -> Content

    var body: some View {
        GeometryReader { proxy in
            content(proxy.size.height / 1000)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Scale

fileprivate struct ScaleKey: EnvironmentKey {
    static var defaultValue: Double = 1
}

extension EnvironmentValues {
    var scale: Double {
        get { self[ScaleKey.self] }
        set { self[ScaleKey.self] = newValue }
    }
}

struct Scale<Content: View>: View {

    @ViewBuilder let content: () -> Content

    var body: some View {
        GeometryReader { proxy in
            content().environment(\.scale, proxy.size.height / 300)
        }
    }
}
