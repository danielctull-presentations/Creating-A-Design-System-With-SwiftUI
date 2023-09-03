
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

// MARK: - Summary

struct Summary: View {

    var body: some View {
        Group {

            Slide("One style, much content!") {
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

            Slide("Summary") {
                BulletedList {
                    Bullet("Prefer providing custom styles over views")
                    Bullet("Nest styles to customise for different contexts")
                    Bullet("Create your own stylable semantic containers")
                    Bullet("Add initialisers to extend standard types")
                }
            }
        }
        .slideStyle(.content(alignment: .center))
    }
}
