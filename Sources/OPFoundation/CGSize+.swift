import CoreGraphics

public extension CGSize {
    /// Creates a `CGSize` with the equal width and height.
    init(_ square: CGFloat) {
        self.init(width: square, height: square)
    }

    /// A `CGSize` with `.infinity` width and height. Useful for SwiftUI `frame` modifiers.
    static let infinity: CGSize = .init(CGFloat.infinity)
}

/// These extensions allow `CGSize` to be expressible by integer literals
/// to more easily create square sizes.
///
/// Example: `Color.red.frame(size: 50)`
extension CGSize: @retroactive ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        let size = CGFloat(value)
        self.init(size)
    }
}

public extension CGSize {
  // MARK: - Addition (+CGSize, +CGFloat, +=inout)
  
  static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
    CGSize(
      width: lhs.width + rhs.width,
      height: lhs.height + rhs.height
    )
  }
  static func + (lhs: CGSize, rhs: CGFloat) -> CGSize {
    CGSize(
      width: lhs.width + rhs,
      height: lhs.height + rhs
    )
  }
  static func += (lhs: inout CGSize, rhs: CGSize) {
    lhs.width += rhs.width
    lhs.height += rhs.height
  }
  
  
  // MARK: - Subtraction (-CGSize, -CGFloat, -=inout, negative)
  
  static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
    CGSize(
      width: lhs.width - rhs.width,
      height: lhs.height - rhs.height
    )
  }
  static func - (lhs: CGSize, rhs: CGFloat) -> CGSize {
    CGSize(
      width: lhs.width - rhs,
      height: lhs.height - rhs
    )
  }
  static func -= (lhs: inout CGSize, rhs: CGSize) {
    lhs.width -= rhs.width
    lhs.height -= rhs.height
  }
  static prefix func - (size: CGSize) -> CGSize {
    .init(width: -size.width, height: -size.height)
  }
  
  
  // MARK: - Multiplication (*CGSize, *CGFloat, *=inout)
  
  static func * (lhs: CGSize, rhs: CGSize) -> CGSize {
    CGSize(
      width: lhs.width * rhs.width,
      height: lhs.height * rhs.height
    )
  }
  static func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
    CGSize(
      width: lhs.width * rhs,
      height: lhs.height * rhs
    )
  }
  static func *= (lhs: inout CGSize, rhs: CGSize) {
    lhs.width *= rhs.width
    lhs.height *= rhs.height
  }
  
  
  // MARK: - Division (/CGSize, /CGFloat, /=inout)
  
  static func / (lhs: CGSize, rhs: CGSize) -> CGSize {
    CGSize(
      width: lhs.width / rhs.width,
      height: lhs.height / rhs.height
    )
  }
  static func / (lhs: CGSize, rhs: CGFloat) -> CGSize {
    CGSize(
      width: lhs.width / rhs,
      height: lhs.height / rhs
    )
  }
  static func /= (lhs: inout CGSize, rhs: CGSize) {
    lhs.width /= rhs.width
    lhs.height /= rhs.height
  }
  
  
  // MARK: - Other
  
  var min: CGFloat { Swift.min(width, height) }
  var minSquare: CGSize { .init(min) }
  
  var max: CGFloat { Swift.max(width, height) }
  var maxSquare: CGSize { .init(max) }

  var nonZero: CGSize? { self == .zero ? nil : self }
  var zeroOnly: CGSize? { self == .zero ? self : nil }
}
