
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
            .codeHighlighting(.xcodeClassic)
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

extension CodeHighlighting where Self == XcodeClassicCodeHighlighting {
    static var xcodeClassic: Self { Self() }
}

struct XcodeClassicCodeHighlighting: CodeHighlighting {

    func color(for token: Token) -> Color {
        switch token.classification {
        case .attribute: Color(red: 0.505801, green: 0.371396, blue: 0.012096, opacity: 1)
        case .character: Color(red: 0.11, green: 0, blue: 0.81, opacity: 1)
        case .comment: Color(red: 0, green: 0.456, blue: 0, opacity: 1)
        case .commentDoc: Color(red: 0, green: 0.456, blue: 0, opacity: 1)
        case .commentDocKeyword: Color(red: 0.008, green: 0.239, blue: 0.063, opacity: 1)
        case .declarationOther: Color(red: 0.0588235, green: 0.407843, blue: 0.627451, opacity: 1)
        case .declarationType: Color(red: 0.0431373, green: 0.309804, blue: 0.47451, opacity: 1)
        case .identifierClass: Color(red: 0.109812, green: 0.272761, blue: 0.288691, opacity: 1)
        case .identifierClassSystem: Color(red: 0.224543, green: 0, blue: 0.628029, opacity: 1)
        case .identifierConstant: Color(red: 0.194184, green: 0.429349, blue: 0.454553, opacity: 1)
        case .identifierConstantSystem: Color(red: 0.421903, green: 0.212783, blue: 0.663785, opacity: 1)
        case .identifierFunction: Color(red: 0.194184, green: 0.429349, blue: 0.454553, opacity: 1)
        case .identifierFunctionSystem: Color(red: 0.421903, green: 0.212783, blue: 0.663785, opacity: 1)
        case .identifierMacro: Color(red: 0.391471, green: 0.220311, blue: 0.124457, opacity: 1)
        case .identifierMacroSystem: Color(red: 0.391471, green: 0.220311, blue: 0.124457, opacity: 1)
        case .identifierType: Color(red: 0.109812, green: 0.272761, blue: 0.288691, opacity: 1)
        case .identifierTypeSystem: Color(red: 0.224543, green: 0, blue: 0.628029, opacity: 1)
        case .identifierVariable: Color(red: 0.194184, green: 0.429349, blue: 0.454553, opacity: 1)
        case .identifierVariableSystem: Color(red: 0.421903, green: 0.212783, blue: 0.663785, opacity: 1)
        case .keyword: Color(red: 0.607592, green: 0.137526, blue: 0.576284, opacity: 1)
        case .mark: Color(red: 0.14902, green: 0.458824, blue: 0.027451, opacity: 1)
        case .markupCode: Color(red: 0.665, green: 0.052, blue: 0.569, opacity: 1)
        case .number: Color(red: 0.11, green: 0, blue: 0.81, opacity: 1)
        case .plain: Color(red: 0, green: 0, blue: 0, opacity: 0.85)
        case .preprocessor: Color(red: 0.391471, green: 0.220311, blue: 0.124457, opacity: 1)
        case .regex: Color(red: 0.77, green: 0.102, blue: 0.086, opacity: 1)
        case .regexCapturename: Color(red: 0.194184, green: 0.429349, blue: 0.454553, opacity: 1)
        case .regexCharname: Color(red: 0.421903, green: 0.212783, blue: 0.663785, opacity: 1)
        case .regexNumber: Color(red: 0.11, green: 0, blue: 0.81, opacity: 1)
        case .regexOther: Color(red: 0, green: 0, blue: 0, opacity: 0.85)
        case .string: Color(red: 0.77, green: 0.102, blue: 0.086, opacity: 1)
        case .url: Color(red: 0.055, green: 0.055, blue: 1, opacity: 1)
        default: Color(red: 0, green: 0, blue: 0, opacity: 0.85)
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
