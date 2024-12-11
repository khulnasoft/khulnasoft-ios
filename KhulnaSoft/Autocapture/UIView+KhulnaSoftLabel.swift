//
//  UIView+KhulnaSoftLabel.swift
//  KhulnaSoft
//
//  Created by Yiannis Josephides on 04/12/2024.
//

#if os(iOS) || targetEnvironment(macCatalyst)
    import UIKit

    public extension UIView {
        /**
         Adds a custom label to this view for use with KhulnaSoft's auto-capture functionality.

         By setting a custom label, you can easily identify and filter interactions with this specific element in your analytics data.

         ### Usage
         ```swift
         let myView = UIView()
         myView.khulnaSoftLabel = "customLabel"
         ```
         */
        var khulnaSoftLabel: String? {
            get { objc_getAssociatedObject(self, &AssociatedKeys.phLabel) as? String }
            set { objc_setAssociatedObject(self, &AssociatedKeys.phLabel, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
        }
    }

#endif
