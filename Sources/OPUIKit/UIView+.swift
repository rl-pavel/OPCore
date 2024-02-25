#if canImport(UIKit)
import OPFoundation
import UIKit

public extension UIView {
  func layoutIfNeeded(
    animatedWithDuration duration: TimeInterval,
    delay: TimeInterval = 0,
    options: UIView.AnimationOptions = [],
    extraAnimations: VoidClosure? = nil,
    completion: VoidClosure? = nil) {
      UIView.animate(withDuration: duration, delay: delay, options: options) { [weak self] in
        extraAnimations?()
        self?.layoutIfNeeded()
      } completion: { _ in
        completion?()
      }
    }
  
  /// Calls either `fadeIn` and `fadeOut`, depending on the passed value.
  func setFaded(outIf isFadedOut: Bool, duration: TimeInterval = 0.3) {
    isFadedOut ? fadeOut(for: duration) : fadeIn(for: duration)
  }
  
  func fadeIn(for duration: TimeInterval = 0.3, completion: VoidClosure? = nil) {
    isHidden = false
    
    UIView.animate(withDuration: duration) { [weak self] in
      self?.alpha = 1
    } completion: { _ in
      completion?()
    }
  }
  
  func fadeOut(for duration: TimeInterval = 0.3, completion: VoidClosure? = nil) {
    guard duration != 0 else {
      isHidden = true
      completion?()
      return
    }
    
    UIView.animate(withDuration: duration) { [weak self] in
      self?.alpha = 0
    } completion: { [weak self] _ in
      self?.isHidden = true
      completion?()
    }
  }
  
  @discardableResult
  func transition(
    _ type: CATransitionType,
    _ subtype: CATransitionSubtype,
    withDuration duration: TimeInterval = 0.3,
    timingFunction: CAMediaTimingFunctionName = .easeInEaseOut,
    forKey key: String = "transition") -> CATransition {
    let transition = CATransition()
    transition.duration = duration
    transition.type = type
    transition.subtype = subtype
    transition.timingFunction = CAMediaTimingFunction(name: timingFunction)
    
    layer.add(transition, forKey: key)
    
    return transition
  }
  
  static var spacer: UIView {
    update(UIView()) {
      $0.isUserInteractionEnabled = false
      $0.setContentCompressionResistancePriority(.init(0), for: .horizontal)
      $0.setContentCompressionResistancePriority(.init(0), for: .vertical)
    }
  }
}
#endif
