import OPFoundation
import SwiftUI

public extension View {
  @ViewBuilder
  func `if`<Content: View>(
    _ condition: @autoclosure Factory<Bool>,
    transform: Transform<Self, Content>) -> some View {
      if condition() {
        transform(self)
      } else {
        self
      }
    }
  
  @ViewBuilder
  func ifLet<Value, IfLetContent: View>(
    _ condition: @autoclosure Factory<Value?>,
    transform: Transform<(Self, Value), IfLetContent>) -> some View {
      if let value = condition() {
        transform((self, value))
      } else {
        self
      }
    }
  
  @ViewBuilder
  func `if`<IfContent: View, ElseContent: View>(
    _ condition: @autoclosure Factory<Bool>,
    transform: Transform<Self, IfContent>,
    else elseTransform: Transform<Self, ElseContent>) -> some View {
      if condition() {
        transform(self)
      } else {
        elseTransform(self)
      }
    }
  
  func frame(size: CGSize?, alignment: Alignment = .center) -> some View {
    frame(width: size?.width, height: size?.height, alignment: alignment)
  }
  
  func frame(
    minSize: CGSize? = nil,
    idealSize: CGSize? = nil,
    maxSize: CGSize? = nil,
    alignment: Alignment = .center
  ) -> some View {
      frame(
        minWidth: minSize?.width,
        idealWidth: idealSize?.width,
        maxWidth: maxSize?.width,
        minHeight: minSize?.height,
        idealHeight: idealSize?.height,
        maxHeight: maxSize?.height,
        alignment: alignment)
  }
  
  func overlayMask<Content: View>(_ content: Content) -> some View {
    overlay(content.mask(self))
  }
  
  /// Applies a mask going from opaque to transparent.
  func fadeMask(startPoint: UnitPoint = .top, endPoint: UnitPoint = .bottom) -> some View {
    mask(
      LinearGradient(
        colors: [.black, .clear],
        startPoint: startPoint,
        endPoint: endPoint
      )
        .edgesIgnoringSafeArea(.all)
        .allowsHitTesting(false)
    )
  }
  
  func hiddenShortcut(
    _ key: KeyEquivalent,
    modifiers: EventModifiers = [],
    title: String = "",
    action: @escaping VoidClosure) -> some View {
      background(
        Button(title, action: action)
          .keyboardShortcut(key, modifiers: modifiers)
          .hidden()
      )
  }
  
  func synchronize<Value>(
    _ binding: Binding<Value>,
    with focusState: FocusState<Value>.Binding) -> some View {
      self
        .onChange(of: binding.wrappedValue) { focusState.wrappedValue = $0 }
        .onChange(of: focusState.wrappedValue) { binding.wrappedValue = $0 }
    }
  
#if DEBUG
  /// Adds a colored overlay showing the size of the view for debugging purposes.
  func debugSizeOverlay(color: Color = .red) -> some View {
    self.overlay(
      GeometryReader { frame in
        color.opacity(0.15)
          .overlay(
            Text("w\(Int(frame.size.width)) h\(Int(frame.size.height))")
              .opacity(0.8)
              .font(.title)
              .foregroundColor(.red)
              .minimumScaleFactor(0.1)
              .shadow(color: .black, radius: 1)
              .shadow(color: .black, radius: 1)
              .shadow(color: .black, radius: 1)
          )
          .frame(size: frame.size)
      }
        .allowsHitTesting(false)
    )
  }
#endif
}
