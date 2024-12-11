//
//  View+KhulnaSoftLabel.swift
//  KhulnaSoft
//
//  Created by Yiannis Josephides on 04/12/2024.
//

#if os(iOS) || targetEnvironment(macCatalyst)
    import SwiftUI

    public extension View {
        /**
         Adds a custom label to this view for use with KhulnaSoft's auto-capture functionality.

         By setting a custom label, you can easily identify and filter interactions with this specific element in your analytics data.

         ### Usage
         ```swift
         struct ContentView: View {
            var body: some View {
                Button("Login") {
                    ...
                }
                .khulnaSoftLabel("loginButton")
              }
         }
         ```

         - Parameter label: A custom label that uniquely identifies the element for analytics purposes.
         */
        func khulnaSoftLabel(_ label: String?) -> some View {
            modifier(KhulnaSoftLabelTaggerViewModifier(label: label))
        }
    }

    private struct KhulnaSoftLabelTaggerViewModifier: ViewModifier {
        let label: String?

        func body(content: Content) -> some View {
            content
                .background(viewTagger)
        }

        @ViewBuilder
        private var viewTagger: some View {
            if let label {
                KhulnaSoftLabelViewTagger(label: label)
            }
        }
    }

    private struct KhulnaSoftLabelViewTagger: UIViewRepresentable {
        let label: String

        func makeUIView(context _: Context) -> KhulnaSoftLabelTaggerView {
            KhulnaSoftLabelTaggerView(label: label)
        }

        func updateUIView(_: KhulnaSoftLabelTaggerView, context _: Context) {
            // nothing
        }
    }

    private class KhulnaSoftLabelTaggerView: UIView {
        private let label: String
        weak var taggedView: UIView?

        init(label: String) {
            self.label = label
            super.init(frame: .zero)
        }

        @available(*, unavailable)
        required init?(coder _: NSCoder) {
            label = ""
            super.init(frame: .zero)
        }

        override func layoutSubviews() {
            super.didMoveToWindow()

            // try to find a "taggable" cousin view in hierarchy
            //
            // ### Why cousin view?
            //
            // Because of SwiftUI-to-UIKit view bridging:
            //
            //     OriginalView (SwiftUI)
            //       L SwiftUITextFieldRepresentable (ViewRepresentable)
            //           L UITextField (UIControl) <- we tag here
            //       L KhulnaSoftLabelViewTagger (ViewRepresentable)
            //           L KhulnaSoftLabelTaggerView (UIView) <- we are here
            //
            if let view = findCousinView(of: KhulnaSoftSwiftUITaggable.self) {
                taggedView = view
                view.khulnaSoftLabel = label
            } else {
                // just tag grandparent view
                //
                // ### Why grandparent view?
                //
                // Because of SwiftUI-to-UIKit view bridging:
                //     OriginalView (SwiftUI) <- we tag here
                //       L KhulnaSoftLabelViewTagger (ViewRepresentable)
                //           L KhulnaSoftLabelTaggerView (UIView) <- we are here
                //
                taggedView = superview?.superview
                superview?.superview?.khulnaSoftLabel = label
            }
        }

        override func removeFromSuperview() {
            super.removeFromSuperview()
            // remove custom label when removed from hierarchy
            taggedView?.khulnaSoftLabel = nil
            taggedView = nil
        }

        private func findCousinView<T>(of _: T.Type) -> T? {
            for sibling in superview?.siblings() ?? [] {
                if let match = sibling.child(of: T.self) {
                    return match
                }
            }
            return nil
        }
    }

    // MARK: - Helpers

    private extension UIView {
        func siblings() -> [UIView] {
            superview?.subviews.reduce(into: []) { result, current in
                if current !== self { result.append(current) }
            } ?? []
        }

        func child<T>(of type: T.Type) -> T? {
            for child in subviews {
                if let curT = child as? T ?? child.child(of: type) {
                    return curT
                }
            }
            return nil
        }
    }

    protocol KhulnaSoftSwiftUITaggable: UIView { /**/ }

    extension UIControl: KhulnaSoftSwiftUITaggable { /**/ }
    extension UIPickerView: KhulnaSoftSwiftUITaggable { /**/ }
    extension UITextView: KhulnaSoftSwiftUITaggable { /**/ }
    extension UICollectionView: KhulnaSoftSwiftUITaggable { /**/ }
    extension UITableView: KhulnaSoftSwiftUITaggable { /**/ }

#endif
