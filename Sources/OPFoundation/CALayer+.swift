import QuartzCore
import PlatformKit

public extension CACornerMask {
  static var topLeft: CACornerMask { .layerMinXMinYCorner }
  static var topRight: CACornerMask { .layerMaxXMinYCorner }
  static var bottomLeft: CACornerMask { .layerMinXMaxYCorner }
  static var bottomRight: CACornerMask { .layerMaxXMaxYCorner }
  static var all: CACornerMask { [topLeft, topRight, bottomLeft, bottomRight] }
}

public extension CALayer {
  /// Rounds the specified corners.
  func roundCorners(_ corners: CACornerMask, radius: CGFloat, cornerCurve: CALayerCornerCurve = .continuous) {
    cornerRadius = radius
    maskedCorners = corners
    self.cornerCurve = cornerCurve
    masksToBounds = true
  }
  
  /// Draws a border with the specified width and color.
  func drawBorder(width: CGFloat, color: PlatformColor) {
    borderWidth = width
    borderColor = color.cgColor
  }
  
  /// Adds a `CATransition` animation to the layer.
  @discardableResult
  func transition(
    _ type: CATransitionType,
    away subtype: CATransitionSubtype?,
    for duration: TimeInterval = 0.3,
    timingFunction: CAMediaTimingFunctionName = .easeInEaseOut,
    forKey key: String = "transition",
    completion: VoidClosure? = nil) -> CATransition {
      let transition = CATransition()
      transition.duration = duration
      transition.type = type
      transition.subtype = subtype
      transition.timingFunction = CAMediaTimingFunction(name: timingFunction)
      
      add(transition, forKey: key)
      DispatchQueue.main.asyncAfter(deadline: .now() + duration) { completion?() }
      
      return transition
    }
}
