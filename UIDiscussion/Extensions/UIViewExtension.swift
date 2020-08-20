import UIKit

extension UIView {
    func addSubviewsForAutolayout(_ subviews: UIView...) {
        for subview in subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
            addSubview(subview)
        }
    }

    func constrainToFullSize(_ views: UIView...) {
        for view in views {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: view.topAnchor),
                bottomAnchor.constraint(equalTo: view.bottomAnchor),
                leadingAnchor.constraint(equalTo: view.leadingAnchor),
                trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        }
    }
}