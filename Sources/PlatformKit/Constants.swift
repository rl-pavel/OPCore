
public extension CGFloat {
#if os(iOS)
  static var pixel: CGFloat { 1.0 / UIScreen.main.scale }
#elseif os(macOS)
  static var pixel: CGFloat { 1.0 / (NSScreen.main?.backingScaleFactor ?? 0) }
#elseif os(tvOS)
  static var pixel: CGFloat { 1.0 / UIScreen.main.scale }
#elseif os(watchOS)
  static var pixel: CGFloat { 1.0 / WKInterfaceDevice.current().screenScale }
#endif
}
