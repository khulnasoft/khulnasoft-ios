//
//  KhulnaSoftMaskViewModifier.swift
//  KhulnaSoft
//
//  Created by Yiannis Josephides on 09/10/2024.
//

#if os(iOS) && canImport(SwiftUI)

    import SwiftUI

    public extension View {
        func khulnaSoftMask(_ isEnabled: Bool = true) -> some View {
            modifier(KhulnaSoftMaskViewModifier(enabled: isEnabled))
        }
    }

    private struct KhulnaSoftMaskViewTagger: UIViewRepresentable {
        func makeUIView(context _: Context) -> KhulnaSoftMaskViewTaggerView {
            KhulnaSoftMaskViewTaggerView()
        }

        func updateUIView(_: KhulnaSoftMaskViewTaggerView, context _: Context) {
            // nothing
        }
    }

    private struct KhulnaSoftMaskViewModifier: ViewModifier {
        let enabled: Bool

        func body(content: Content) -> some View {
            content.background(viewTagger)
        }

        @ViewBuilder
        private var viewTagger: some View {
            if enabled {
                KhulnaSoftMaskViewTagger()
            }
        }
    }

    private class KhulnaSoftMaskViewTaggerView: UIView {
        private weak var maskedView: UIView?
        override func layoutSubviews() {
            super.layoutSubviews()
            // ### Why grandparent view?
            //
            // Because of SwiftUI-to-UIKit view bridging:
            //     OriginalView (SwiftUI) <- we tag here
            //       L KhulnaSoftMaskViewTagger (ViewRepresentable)
            //           L KhulnaSoftMaskViewTaggerView (UIView) <- we are here
            maskedView = superview?.superview
            superview?.superview?.khulnaSoftNoCapture = true
        }

        override func removeFromSuperview() {
            super.removeFromSuperview()
            maskedView?.khulnaSoftNoCapture = false
            maskedView = nil
        }
    }

    extension UIView {
        var khulnaSoftNoCapture: Bool {
            get { objc_getAssociatedObject(self, &AssociatedKeys.phNoCapture) as? Bool ?? false }
            set { objc_setAssociatedObject(self, &AssociatedKeys.phNoCapture, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
        }
    }
#endif
