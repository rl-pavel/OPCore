import SwiftUI

#if canImport(UIKit)
@_exported import UIKit
public typealias PlatformColor = UIColor
public typealias PlatformFont = UIFont
public typealias PlatformImage = UIImage
public typealias PlatformFontDescriptor = UIFontDescriptor
public typealias PlatformEdgeInsets = UIEdgeInsets

public typealias PlatformViewRepresentable = UIViewRepresentable
public typealias PlatformView = UIView
public typealias PlatformViewController = UIViewController
public typealias PlatformHostingController = UIHostingController
public typealias PlatformApplication = UIApplication
public typealias PlatformResponder = UIResponder
public typealias PlatformTextView = UITextView

#elseif canImport(AppKit)
@_exported import AppKit
public typealias PlatformColor = NSColor
public typealias PlatformFont = NSFont
public typealias PlatformImage = NSImage
public typealias PlatformFontDescriptor = NSFontDescriptor
public typealias PlatformEdgeInsets = NSEdgeInsets

public typealias PlatformViewRepresentable = NSViewRepresentable
public typealias PlatformView = NSView
public typealias PlatformViewController = NSViewController
public typealias PlatformHostingController = NSHostingController
public typealias PlatformApplication = NSApplication
public typealias PlatformResponder = NSResponder

public typealias PlatformTextView = NSTextView
#endif

public typealias PlatformFontWeight = PlatformFont.Weight
public typealias PlatformTextStyle = PlatformFont.TextStyle
public typealias PlatformFontDesign = PlatformFontDescriptor.SystemDesign

public extension PlatformResponder {
  var nextPlatformResponder: PlatformResponder? {
#if os(iOS)
    return self.next
#elseif os(macOS)
    return self.nextResponder
#endif
  }
}
