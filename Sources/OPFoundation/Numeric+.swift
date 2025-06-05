public extension BinaryFloatingPoint {
  /// Interpolates the value between 0...1 in a specified range.
  /// - Parameters:
  ///   - isDescending: `false` for ascending mapping (0→1), `true` for descending (1→0)
  ///   - range: The range when the interpolation should start and finish.
  /// - Returns: The interpolated value between 0.0 to 1.0.
  ///
  /// Examples:
  /// ```
  /// 0.interpolate(from: false, between: 50...100)   // 0
  /// 0.interpolate(from: true, between: 50...100)    // 1
  ///
  /// 70.interpolate(from: false, between: 50...100)  // 0.4
  /// 70.interpolate(from: true, between: 50...100)   // 0.6
  ///
  /// 150.interpolate(from: false, between: 50...100) // 1
  /// 150.interpolate(from: true, between: 50...100)  // 0
  /// ```
  func interpolate(from isDescending: Bool, between range: ClosedRange<Self>) -> Self {
    guard range.lowerBound != range.upperBound else {
      return self < range.lowerBound ? 0 : self == range.lowerBound ? 0.5 : 1
    }
    
    let difference = range.upperBound - range.lowerBound
    let position = ((self - range.lowerBound) / difference).clamped(0, to: 1)
    return isDescending ? 1 - position : position
  }
}


public extension FloatingPoint {
  var nonZero: Self? { isZero ? nil : self }
  var onlyZero: Self? { isZero ? self : nil }
}

public extension Int {
  var isZero: Bool { self == 0 }
  var nonZero: Self? { isZero ? nil : self }
  var onlyZero: Self? { isZero ? self : nil }
}
