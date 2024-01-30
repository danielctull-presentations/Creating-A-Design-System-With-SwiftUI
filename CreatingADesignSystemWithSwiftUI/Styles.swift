
import SlideUI
import SwiftUI
import XcodeCodeHighlighting

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
                    .foregroundColor(.orange)

                configuration.content
                    .font(.system(size: multiplier * 70, weight: .light, design: .rounded))

                configuration.footer
                    .font(.system(size: multiplier * 50, weight: .light, design: .rounded))
                    .padding(multiplier * 50)
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
            .padding(scale * 18)
            .codeStyle(.fitting(idealSize: scale * 14))
            .codeHighlighting(.xcodeClassicLight)
        }
    }

    func makeBody(configuration: Configuration) -> some View {
        Scale {
            SlideWrapper(alignment: alignment, configuration: configuration)
        }
        .foregroundColor(.black)
        .background(.white)
        .codePreviewStyle(.nicelySpacedHorizontal)
    }
}

// MARK: - FittingCodeStyle

extension CodeStyle where Self == FittingCodeStyle {

    static func fitting(idealSize: CGFloat, weight: Font.Weight = .regular) -> Self {
        Self(idealSize: idealSize, weight: weight)
    }
}

struct FittingCodeStyle: CodeStyle {
    fileprivate let idealSize: CGFloat
    fileprivate let weight: Font.Weight

    func makeBody(configuration: Configuration) -> some View {
        ViewThatFits(range: 3...max(4, idealSize)) { size in
            configuration.code
                .lineSpacing(size / 8)
                .font(.system(size: size, weight: weight, design: .monospaced))
        }
    }
}

extension ViewThatFits {
    
    /// Provides a variant of ViewThatFits that fits the content of the largest
    /// size in the given range.
    ///
    /// - Parameters:
    ///   - range: The range of sizes to evaluate.
    ///   - content: Content for the given size.
    public init<C: View, Size: BinaryFloatingPoint>(
        range: ClosedRange<Size>,
        @ViewBuilder content: @escaping (Size) -> C
    ) where Content == ReversedRangeView<C, Size> {
        self.init {
            ReversedRangeView(range: range, content: content)
        }
    }
}

public struct ReversedRangeView<Content: View, Bound: BinaryFloatingPoint>: View {

    private let range: ClosedRange<Int>
    private let content: (Bound) -> Content

    init(range: ClosedRange<Bound>, content: @escaping (Bound) -> Content) {
        self.range = (Int(ceil(range.lowerBound))...Int(floor(range.upperBound)))
        self.content = content
    }

    public var body: some View {
        ForEach(range.reversed(), id: \.self) { size in
            content(Bound(size))
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

// MARK: - Code Preview Style


private struct NicelySpacedHorizontalCodePreviewStyle: CodePreviewStyle {

    @Environment(\.scale) private var scale

    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 0) {
            configuration.code
            Spacer(minLength: scale * 16)
            configuration.content
            Spacer()
        }
    }
}

extension CodePreviewStyle where Self == NicelySpacedHorizontalCodePreviewStyle {
    fileprivate static var nicelySpacedHorizontal: Self { Self() }
}
