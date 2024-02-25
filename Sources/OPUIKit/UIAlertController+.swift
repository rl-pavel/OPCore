#if canImport(UIKit)
import OPFoundation
import UIKit

extension UIAlertController {
  struct Confirmation {
    var title: String
    var isDestructive: Bool = false
    var handler: VoidClosure
  }
  
  static func makeAlert(
    title: String?,
    message: String? = nil,
    style: UIAlertController.Style = .alert,
    confirmation: Confirmation? = nil,
    cancel: String) -> UIAlertController {
      update(UIAlertController(title: title, message: message, preferredStyle: style)) { alert in
        if let confirmation = confirmation {
          alert.addAction(
            UIAlertAction(title: confirmation.title, style: confirmation.isDestructive ? .destructive : .default) { _ in
              confirmation.handler()
            }
          )
        }
        
        alert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: nil))
      }
    }
}
#endif
