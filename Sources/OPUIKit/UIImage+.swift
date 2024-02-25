#if canImport(UIKit)
import UIKit

public extension UIImage {
  var template: UIImage { withRenderingMode(.alwaysTemplate) }
  var original: UIImage { withRenderingMode(.alwaysOriginal) }
  
  convenience init?(symbol: String, size: CGFloat, weight: SymbolWeight = .regular) {
    let configuration = UIImage.SymbolConfiguration(pointSize: size, weight: weight)
    self.init(systemName: symbol, withConfiguration: configuration)
  }
}
#endif
