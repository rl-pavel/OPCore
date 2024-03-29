import SwiftUI

public extension AnyTransition {
  /// Convenience function, combining the `move(edge:)` and `.opacity` transitions.
  static func fade(edge: Edge) -> AnyTransition {
    return .move(edge: edge).combined(with: .opacity)
  }
}
