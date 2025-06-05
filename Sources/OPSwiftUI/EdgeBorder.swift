import SwiftUI

public extension View {
  @inlinable nonisolated func border<Style: ShapeStyle>(width: CGFloat, edges: [Edge], style: Style) -> some View {
    overlay(EdgeBorder(width: width, edges: edges).foregroundStyle(style))
  }
}

public struct EdgeBorder: Shape {
  var width: CGFloat
  var edges: [Edge]
  
  public init(width: CGFloat, edges: [Edge]) {
    self.width = width
    self.edges = edges
  }
  
  public func path(in rect: CGRect) -> Path {
    edges.map { edge -> Path in
      switch edge {
      case .top: return Path(CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: width))
      case .bottom: return Path(CGRect(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width))
      case .leading: return Path(CGRect(x: rect.minX, y: rect.minY, width: width, height: rect.height))
      case .trailing: return Path(CGRect(x: rect.maxX - width, y: rect.minY, width: width, height: rect.height))
      }
    }.reduce(into: Path()) { $0.addPath($1) }
  }
}
