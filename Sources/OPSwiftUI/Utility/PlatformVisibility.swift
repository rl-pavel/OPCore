import SwiftUI

public struct Platform: OptionSet {
  public var rawValue: UInt8
  
  public static let iOS: Platform     = Platform(rawValue: 1 << 0)
  public static let macOS: Platform   = Platform(rawValue: 1 << 1)
  public static let tvOS: Platform    = Platform(rawValue: 1 << 2)
  public static let watchOS: Platform = Platform(rawValue: 1 << 3)
  public static let all: Platform     = [.iOS, .macOS, .tvOS, .watchOS]
  
#if os(iOS)
  public static let current: Platform = .iOS
#elseif os(macOS)
  public static let current: Platform = .macOS
#elseif os(tvOS)
  public static let current: Platform = .tvOS
#elseif os(watchOS)
  public static let current: Platform = .watchOS
#endif
  
  public init(rawValue: UInt8) {
    self.rawValue = rawValue
  }
}

public extension View {
  func visible(on platforms: Platform) -> some View {
    return modifier(PlatformVisibility(platforms))
  }
}

private struct PlatformVisibility: ViewModifier {
  private var platforms: Platform = .current
  
  init(_ platforms: Platform) {
    self.platforms = platforms
  }
  
  func body(content: Content) -> some View {
    platforms.contains(.current) ? content : nil
  }
}
