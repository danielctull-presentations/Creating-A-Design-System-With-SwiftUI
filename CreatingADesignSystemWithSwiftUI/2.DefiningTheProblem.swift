
import SlideUI
import SwiftUI

private struct PrimaryButton: View {

    let title: String
    let action: () -> Void

    var body: some View {
        Button(title, action: action)
            .buttonStyle(.plain)
            .font(.system(size: 60))
            .padding(32)
            .background(.blue, in: RoundedRectangle(cornerRadius: 16))
            .foregroundColor(.white)
    }
}

private struct PrimaryImageButton: View {

    let image: Image
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            image
        }
        .buttonStyle(.plain)
        .font(.system(size: 60))
        .padding(32)
        .background(.blue, in: RoundedRectangle(cornerRadius: 16))
        .foregroundColor(.white)
    }
}

struct DefiningTheProblem: View {

    var body: some View {
        Group {

            Slide(header: "Suppose we're asked to make a button…") {
                PrimaryButton(title: "Press me", action: {})
            }

            Slide(header: "Suppose we're asked to make a button…") {
                #Code {
                    struct PrimaryButton: View {

                        let title: String
                        let action: () -> Void

                        var body: some View {
                            Button(title, action: action)
                                .font(.system(size: 60))
                                .padding(32)
                                .background(.blue, in: RoundedRectangle(cornerRadius: 16))
                                .foregroundColor(.white)
                        }
                    }
                }
            }

            Slide(header: "Suppose we're asked to make a button…") {
                #CodePreview {
                    PrimaryButton(title: "Press me", action: {})
                }
            }

            Slide(header: "\"Oh! Of course we need to support images…\"") {
                #Code {
                    struct PrimaryImageButton: View {

                        let image: Image
                        let action: () -> Void

                        var body: some View {
                            Button {
                                action()
                            } label: {
                                image
                            }
                            .font(.system(size: 60))
                            .padding(32)
                            .background(.blue, in: RoundedRectangle(cornerRadius: 16))
                            .foregroundColor(.white)
                        }
                    }
                }
            }

            Slide(header: "\"Oh! Of course we need to support images…\"") {
                #CodePreview {
                    PrimaryImageButton(image: Image(systemName: "square.and.arrow.up"), action: {})
                }
            }

            Slide(header: "What are the problems here?") {
                BulletedList {
                    Bullet("Multiple places to change for a single style change")
                    Bullet("Isn't general for any type of content")
                    Bullet("Buttons aren't easily discoverable")
                }
            }
        }
        .slideStyle(.content(alignment: .center))
    }
}
