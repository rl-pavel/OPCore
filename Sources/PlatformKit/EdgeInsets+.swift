public extension PlatformEdgeInsets {
  init(edges: CGFloat) {
    self = .init(top: edges, left: edges, bottom: edges, right: edges)
  }
  
  init(vertical: CGFloat = 0, horizontal: CGFloat = 0) {
    self = .init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
  }
  
  static func inset(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Self {
    return .init(top: top, left: left, bottom: bottom, right: right)
  }
  
  static func + (lhs: Self, rhs: Self) -> Self {
    var resultInsets = lhs
    resultInsets.top += rhs.top
    resultInsets.left += rhs.left
    resultInsets.right += rhs.right
    resultInsets.bottom += rhs.bottom
    return resultInsets
  }
}
