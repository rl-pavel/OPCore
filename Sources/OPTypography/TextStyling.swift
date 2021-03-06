import OPFoundation
import SwiftUI

/// Defines a text style for any `FontType`. A text style combines the `TypeStyle` (matching
/// Apple's dynamic type styles), a `Font.WeightType` for the given font, `lineHeight` and `tracking`.
///
/// This struct is intended to be used for creating `static` properties with the various font styles as extensions.
/// Example:
/// ```
/// extension TextStyle {
///   static var headline: TextStyle<CustomFont> {
///     .init(style: .headline, weight: .heavy, lineHeight: 0, tracking: 0)
///   }
/// }
/// ```
public struct TextStyle<Font: FontType> {
  private let fontType: Font

  public var font: SwiftUI.Font { fontType.font }
  public var platformFont: PlatformFont { fontType.platformFont }
  
  public var lineHeight: CGFloat
  public var tracking: CGFloat

  public init(style: TypeStyle, weight: Font.WeightType, lineHeight: CGFloat, tracking: CGFloat) {
    self.fontType = .init(style: style, weight: weight)
    self.lineHeight = lineHeight / 100
    self.tracking = tracking
  }
}


// MARK: - UIKit Styling

#if canImport(UIKit)
import UIKit

public extension UILabel {
  func applyStyle() {
    numberOfLines = 0
    lineBreakMode = .byWordWrapping
    adjustsFontForContentSizeCategory = true
  }
  
  /// ⚠️ This extension will not apply the tracking/line spacing, using `NSAttributedString` is required.
  func applyStyle<Font: FontType>(
    _ style: TextStyle<Font>,
    color: UIColor,
    alignment: NSTextAlignment = .left) {
      applyStyle()
      font = style.platformFont
      textColor = color
      textAlignment = alignment
    }
}

public extension UIButton {
  func applyStyle() {
    titleLabel?.numberOfLines = 0
    titleLabel?.lineBreakMode = .byWordWrapping
    titleLabel?.adjustsFontForContentSizeCategory = true
  }
  
  /// ⚠️ This extension will not apply the tracking/line spacing, using `NSAttributedString` is required.
  func applyStyle<Font: FontType>(
    _ style: TextStyle<Font>,
    color: UIColor,
    alignment: NSTextAlignment = .left) {
      applyStyle()
      setTitleColor(color, for: .normal)
      titleLabel?.font = style.platformFont
      titleLabel?.textAlignment = alignment
    }
}

public extension UITextField {
  func applyStyle() {
    adjustsFontForContentSizeCategory = true
  }
  
  func applyStyle<Font: FontType>(
    _ style: TextStyle<Font>,
    color: UIColor,
    alignment: NSTextAlignment = .left) {
      applyStyle()
      font = style.platformFont
      textColor = color
      textAlignment = alignment
      defaultTextAttributes = .attributes(for: style, color: color, alignment: alignment)
      typingAttributes = .attributes(for: style, color: color, alignment: alignment)
    }
}

public extension UITextView {
  func applyStyle() {
    textContainer.lineBreakMode = .byWordWrapping
    isScrollEnabled = false
    backgroundColor = .clear
    adjustsFontForContentSizeCategory = true
  }
  
  func applyStyle<Font: FontType>(
    _ style: TextStyle<Font>,
    color: UIColor,
    alignment: NSTextAlignment = .left) {
      applyStyle()
      font = style.platformFont
      textColor = color
      textAlignment = alignment
      typingAttributes = .attributes(for: style, color: color, alignment: alignment)
    }
}

#elseif canImport(AppKit)
// MARK: - AppKit Styling
import AppKit

public extension NSTextView {
  func applyStyle() {
    isRichText = false
    allowsUndo = true
  }
  
  func applyStyle<Font: FontType>(
    _ style: TextStyle<Font>,
    color: NSColor,
    alignment: NSTextAlignment = .left) {
      applyStyle()
      font = style.platformFont
      textColor = color
      self.alignment = alignment
      typingAttributes = .attributes(for: style, color: color, alignment: alignment)
    }
}
#endif


// MARK: - SwiftUI Styling

public extension Text {
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>) -> some View {
    return self
      .font(style.font)
      .tracking(style.tracking)
      .lineSpacing(style.lineHeight)
  }
  
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>, color: Color) -> some View {
    return applyStyle(style)
      .foregroundColor(color)
  }
  
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>, alignment: TextAlignment) -> some View {
    return applyStyle(style)
      .multilineTextAlignment(alignment)
  }
  
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>, color: Color, alignment: TextAlignment) -> some View {
    return applyStyle(style, color: color)
      .multilineTextAlignment(alignment)
  }
}

public extension TextField {
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>) -> some View {
    Group {
      if #available(macOS 13.0, iOS 16.0, *) {
        self
          .font(style.font)
          .tracking(style.tracking)
          .lineSpacing(style.lineHeight)
      } else {
        self
          .font(style.font)
          .lineSpacing(style.lineHeight)
      }
    }
  }
  
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>, color: Color) -> some View {
    return applyStyle(style)
      .foregroundColor(color)
  }
  
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>, alignment: TextAlignment) -> some View {
    return applyStyle(style)
      .multilineTextAlignment(alignment)
  }
  
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>, color: Color, alignment: TextAlignment) -> some View {
    return applyStyle(style, color: color)
      .multilineTextAlignment(alignment)
  }
}

public extension TextEditor {
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>) -> some View {
    Group {
      if #available(macOS 13.0, iOS 16.0, *) {
        self
          .font(style.font)
          .tracking(style.tracking)
          .lineSpacing(style.lineHeight)
      } else {
        self
          .font(style.font)
          .lineSpacing(style.lineHeight)
      }
    }
  }
  
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>, color: Color) -> some View {
    return applyStyle(style)
      .foregroundColor(color)
  }
  
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>, alignment: TextAlignment) -> some View {
    return applyStyle(style)
      .multilineTextAlignment(alignment)
  }
  
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>, color: Color, alignment: TextAlignment) -> some View {
    return applyStyle(style, color: color)
      .multilineTextAlignment(alignment)
  }
}

public extension View {
  /// ⚠️ This extension will not apply `tracking` and `lineHeight`, consider using `Text.applyStyle` directly.
  @_disfavoredOverload
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>) -> some View {
    return self.font(style.font)
  }
  
  /// ⚠️ This extension will not apply `tracking` and `lineHeight`, consider using `Text.applyStyle` directly.
  @_disfavoredOverload
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>, color: Color) -> some View {
    return applyStyle(style)
      .foregroundColor(color)
  }
  
  /// ⚠️ This extension will not apply `tracking` and `lineHeight`, consider using `Text.applyStyle` directly.
  @_disfavoredOverload
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>, alignment: TextAlignment) -> some View {
    return applyStyle(style)
      .multilineTextAlignment(alignment)
  }
  
  /// ⚠️ This extension will not apply `tracking` and `lineHeight`, consider using `Text.applyStyle` directly.
  @_disfavoredOverload
  func applyStyle<Font: FontType>(
    _ style: TextStyle<Font>,
    color: Color,
    alignment: TextAlignment) -> some View {
      return applyStyle(style, color: color)
        .multilineTextAlignment(alignment)
    }
}


// MARK: - NSAttributedString Styling

public extension Dictionary where Key == NSAttributedString.Key, Value: Any {
  static func attributes<Font: FontType>(for style: TextStyle<Font>) -> [NSAttributedString.Key: Any] {
    [
      .font: style.platformFont,
      .tracking: style.tracking,
      .paragraphStyle: NSMutableParagraphStyle(style: style)
    ]
  }
  
  static func attributes<Font: FontType>(
    for style: TextStyle<Font>,
    color: PlatformColor) -> [NSAttributedString.Key: Any] {
      attributes(for: style)
        .merging([.foregroundColor: color]) { _, new in new }
    }
  
  static func attributes<Font: FontType>(
    for style: TextStyle<Font>,
    alignment: NSTextAlignment) -> [NSAttributedString.Key: Any] {
      attributes(for: style)
        .merging([.paragraphStyle: NSMutableParagraphStyle(style: style, alignment: alignment)])  { _, new in new }
    }
  
  static func attributes<Font: FontType>(
    for style: TextStyle<Font>,
    color: PlatformColor,
    alignment: NSTextAlignment) -> [NSAttributedString.Key: Any] {
      attributes(for: style, alignment: alignment)
        .merging([.foregroundColor: color]) { _, new in new }
    }
}

public extension NSAttributedString {
  convenience init(_ string: String) {
    self.init(string: string)
  }
  
  convenience init<Font: FontType>(_ string: String, style: TextStyle<Font>) {
    self.init(string: string, attributes: .attributes(for: style))
  }

  convenience init<Font: FontType>(_ string: String, style: TextStyle<Font>, color: PlatformColor) {
    self.init(string: string, attributes: .attributes(for: style, color: color))
  }
  
  convenience init<Font: FontType>(_ string: String, style: TextStyle<Font>, alignment: NSTextAlignment) {
    self.init(string: string, attributes: .attributes(for: style, alignment: alignment))
  }
  
  convenience init<Font: FontType>(
    _ string: String,
    style: TextStyle<Font>,
    color: PlatformColor,
    alignment: NSTextAlignment) {
      self.init(string: string, attributes: .attributes(for: style, color: color, alignment: alignment))
  }
}

public extension NSMutableAttributedString {
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>, to range: NSRange? = nil) {
    addAttributes(
      .attributes(for: style),
      range: range ?? NSRange(location: 0, length: string.count)
    )
  }
  
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>, color: PlatformColor, to range: NSRange? = nil) {
    addAttributes(
      .attributes(for: style, color: color),
      range: range ?? NSRange(location: 0, length: string.count)
    )
  }
  
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>, alignment: NSTextAlignment, to range: NSRange? = nil) {
    addAttributes(
      .attributes(for: style, alignment: alignment),
      range: range ?? NSRange(location: 0, length: string.count)
    )
  }
  
  func applyStyle<Font: FontType>(
    _ style: TextStyle<Font>,
    color: PlatformColor,
    alignment: NSTextAlignment,
    to range: NSRange? = nil) {
      addAttributes(
        .attributes(for: style, color: color, alignment: alignment),
        range: range ?? NSRange(location: 0, length: string.count)
      )
  }
}


// MARK: - Helpers

extension NSMutableParagraphStyle {
  convenience init<Font: FontType>(style: TextStyle<Font>) {
    self.init()
    self.lineSpacing = style.lineHeight
  }
  
  convenience init<Font: FontType>(style: TextStyle<Font>, alignment: NSTextAlignment) {
    self.init()
    
    self.lineSpacing = style.lineHeight
    self.alignment = alignment
  }
}
