import Foundation

/// This extension adds functionality for `CaseIterable` String enums to be convertible to/from Int.
public extension CaseIterable where Self: Equatable, Self: RawRepresentable,
                                    RawValue == String, AllCases.Index == Int {
  init?(intValue: Int) {
    guard intValue <= Self.allCases.endIndex && intValue >= Self.allCases.startIndex else { return nil }
    self = Self.allCases[intValue]
  }
  
  var intValue: Int {
    return Self.allCases.firstIndex(of: self)!
  }
}
