import Foundation

/// `OptionalType`, which `Optional` conforms to, can be used for conditional conformance of any optionals
public protocol OptionalType: ExpressibleByNilLiteral {
  associatedtype Wrapped
  var optional: Wrapped? { get set }
}
extension Optional: OptionalType {
  public var optional: Wrapped? {
    get { return self }
    mutating set { self = newValue }
  }
  
  public struct NilError: Error { }
  public func get() throws -> Wrapped {
    guard let self else { throw NilError() }
    return self
  }
}
extension OptionalType {
    public var isNil: Bool { optional == nil }
    public var isNotNil: Bool { optional != nil }
}

public extension Optional where Wrapped: Collection {
  var isNilOrEmpty: Bool {
    return self?.isEmpty ?? true
  }
}

/// Operator useful for printing/logging optional values with a default string fallback
/// Usage: `print(someOptional?.someNonStringValue ??? "default string")`
infix operator ???: NilCoalescingPrecedence
public func ???<T>(optional: T?, defaultValue: @autoclosure Factory<String>) -> String {
  return optional.map(String.init(describing:)) ?? defaultValue()
}


// MARK: - Optional Comparable Operators

infix operator >? : NilCoalescingPrecedence
infix operator >=? : NilCoalescingPrecedence
infix operator <? : NilCoalescingPrecedence
infix operator <=? : NilCoalescingPrecedence
infix operator !=? : NilCoalescingPrecedence
infix operator ==? : NilCoalescingPrecedence

public extension Optional where Wrapped: Comparable {
  /// Unwraps both sides, returning `false` if either is `nil`, then performs the comparison check.
  static func >? (lhs: Wrapped?, rhs: Wrapped?) -> Bool {
    guard let lhs = lhs, let rhs = rhs else {
      return false
    }
    
    return lhs > rhs
  }
  
  /// Unwraps both sides, returning `false` if either is `nil`, then performs the comparison check.
  static func >=? (lhs: Wrapped?, rhs: Wrapped?) -> Bool {
    guard let lhs = lhs, let rhs = rhs else {
      return false
    }
    
    return lhs >= rhs
  }
  
  /// Unwraps both sides, returning `false` if either is `nil`, then performs the comparison check.
  static func <? (lhs: Wrapped?, rhs: Wrapped?) -> Bool {
    guard let lhs = lhs, let rhs = rhs else {
      return false
    }
    
    return lhs < rhs
  }
  
  /// Unwraps both sides, returning `false` if either is `nil`, then performs the comparison check.
  static func <=? (lhs: Wrapped?, rhs: Wrapped?) -> Bool {
    guard let lhs = lhs, let rhs = rhs else {
      return false
    }
    
    return lhs <= rhs
  }
}

public extension Optional where Wrapped: Equatable {
  /// Unwraps both sides, returning `false` if either is `nil`, then performs the equation check.
  static func !=? (lhs: Wrapped?, rhs: Wrapped?) -> Bool {
    guard let lhs = lhs, let rhs = rhs else {
      return false
    }
    
    return lhs != rhs
  }
  
  /// Unwraps both sides, returning `false` if either is `nil`, then performs the equation check.
  static func ==? (lhs: Wrapped?, rhs: Wrapped?) -> Bool {
    guard let lhs = lhs, let rhs = rhs else {
      return false
    }
    
    return lhs == rhs
  }
}
