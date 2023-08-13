
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
    static var content: Self { Self() }
}

struct ContentSlideStyle: SlideStyle {

    func makeBody(configuration: Configuration) -> some View {
        FontMultiplier { multiplier in

            VStack {
                
                configuration.header
                    .font(.system(size: multiplier * 80, weight: .light, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.orange)

                configuration.content
                    .font(.system(size: multiplier * 70, weight: .light, design: .rounded))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                configuration.footer
                    .font(.system(size: multiplier * 30, weight: .light, design: .rounded))
            }
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(multiplier * 50)
            .codeStyle(.monospace(size: multiplier * 35, weight: .light))
        }
        .foregroundColor(.black)
        .background(.white)
        .codePreviewStyle(.vertical)
    }
}

// MARK: - MonospaceCodeStyle

extension CodeStyle where Self == MonospaceCodeStyle {

    static func monospace(size: CGFloat, weight: Font.Weight = .regular) -> Self {
        Self(size: size, weight: weight)
    }
}

struct MonospaceCodeStyle: CodeStyle {

    fileprivate let size: CGFloat
    fileprivate let weight: Font.Weight

    func makeBody(configuration: Configuration) -> some View {
        configuration.code
            .lineSpacing(size / 10)
            .font(.system(size: size, weight: .regular, design: .monospaced))
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
