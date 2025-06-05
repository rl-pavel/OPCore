import Foundation

public extension Array {
  /// Creates sub-arrays with a specified count of elements.
  ///
  /// Example:
  /// ```
  /// let array = [1, 2, 3, 4]
  /// array.makePairs(of: 2) // [[1, 2], [2, 3], [3, 4]]
  /// ```
  func makePairs(of pairCount: Int) -> [[Element]] {
    guard pairCount > 1 && pairCount < count else { return [self] }
    
    return indices.dropLast(pairCount - 1).map { idx in
      (idx..<index(idx, offsetBy: pairCount)).map { self[$0] }
    }
  }
  
  /// Creates sub-arrays with a specified count of elements, and iterates over the sub-arrays.
  ///
  /// Example:
  /// ```
  /// [1, 2, 3, 4].forEachPair(of: 2) {
  ///   print($0) // "[1, 2]", "[2, 3]", "[3, 4]"
  /// }
  /// ```
  func forEachPair(of pairCount: Int, perform: ([Element]) throws -> Void) rethrows {
    try makePairs(of: pairCount).forEach(perform)
  }
  
  func chunked(into size: Int) -> [[Element]] {
    stride(from: 0, to: count, by: size).map {
      Array(self[$0 ..< Swift.min($0 + size, count)])
    }
  }
  
  /// Returns an array sorted using the specified comparator keypaths.
  ///
  /// Example: `restaurants.sorted(by: \.distance, \.name)`
  func sorted<each T: Comparable>(by keyPath: repeat KeyPath<Element, each T>) -> Array {
    var comparators: [KeyPathComparator<Element>] = []
    repeat comparators.append(KeyPathComparator<Element>(each keyPath))
    return sorted(using: comparators)
  }
  
  /// Sorts the array using the specified comparator keypaths.
  ///
  /// Example: `restaurants.sorted(by: \.distance, \.name)`
  mutating func sort<each T: Comparable>(by keyPath: repeat KeyPath<Element, each T>) {
    var comparators: [KeyPathComparator<Element>] = []
    repeat comparators.append(KeyPathComparator<Element>(each keyPath))
    sort(using: comparators)
  }
}
