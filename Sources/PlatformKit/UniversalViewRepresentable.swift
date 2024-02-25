import SwiftUI

public protocol UniversalViewRepresentable: PlatformViewRepresentable {
  associatedtype ViewType: PlatformView
  func makeUniversalView(context: Context) -> ViewType
  func updateUniversalView(_ view: ViewType, context: Context)
}

#if canImport(UIKit)
import UIKit

public extension UniversalViewRepresentable where UIViewType == ViewType {
  func makeUIView(context: Context) -> ViewType {
    makeUniversalView(context: context)
  }
  
  func updateUIView(_ view: ViewType, context: Context) {
    updateUniversalView(view, context: context)
  }
}
#elseif canImport(AppKit)
import AppKit

public extension UniversalViewRepresentable where NSViewType == ViewType {
  func makeNSView(context: Context) -> ViewType {
    makeUniversalView(context: context)
  }
  
  func updateNSView(_ view: ViewType, context: Context) {
    updateUniversalView(view, context: context)
  }
}
#endif
