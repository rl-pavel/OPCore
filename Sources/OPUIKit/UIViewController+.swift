#if canImport(UIKit)
import UIKit

public extension UIViewController {
  func addController(_ child: UIViewController, to containerView: UIView? = nil) {
    addChild(child)
    (containerView ?? view).addSubview(child.view)
    child.didMove(toParent: self)
  }
  
  func removeController() {
    guard parent != nil else {
      return
    }
    
    willMove(toParent: nil)
    view.removeFromSuperview()
    removeFromParent()
  }
  
  func hideBackButtonTitle() {
    navigationItem.backButtonDisplayMode = .minimal
  }
}
#endif
