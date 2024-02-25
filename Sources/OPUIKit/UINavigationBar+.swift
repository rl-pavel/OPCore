#if canImport(UIKit)
import UIKit

public extension UINavigationBar {
  func setTransparent(_ isTransparent: Bool) {
    setBackgroundImage(isTransparent ? UIImage() : nil, for: .default)
    shadowImage = isTransparent ? UIImage() : nil
  }
}
#endif
