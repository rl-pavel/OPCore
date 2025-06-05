import Foundation
#if os(iOS)
import CoreHaptics
import UIKit
#endif

public enum Haptics {
  public enum Native: Equatable {
    case error
    case success
    case warning
    case light
    case medium
    case heavy
    case selection
  }
  
  // MARK: - Properties
  
#if os(iOS)
  private static let notificationGenerator = UINotificationFeedbackGenerator()
  private static let lightFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
  private static let mediumFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
  private static let heavyFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
  private static let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
  
  public struct EngineNotSupported: Error { }
  private static let hapticEngine: CHHapticEngine? = {
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return nil }
    return try? CHHapticEngine()
  }()
  #endif
  
  
  // MARK: - Functions
  
  public static func generate(_ nativeStyle: Native) {
#if os(iOS)
    switch nativeStyle {
    case .error:
      notificationGenerator.notificationOccurred(.error)
      
    case .success:
      notificationGenerator.notificationOccurred(.success)
      
    case .warning:
      notificationGenerator.notificationOccurred(.warning)
      
    case .light:
      lightFeedbackGenerator.impactOccurred()
      
    case .medium:
      mediumFeedbackGenerator.impactOccurred()
      
    case .heavy:
      heavyFeedbackGenerator.impactOccurred()
      
    case .selection:
      selectionFeedbackGenerator.selectionChanged()
    }
#endif
  }
  
#if os(iOS)
  public static func generate(
    _ events: [CHHapticEvent],
    parameters: [CHHapticDynamicParameter] = []
  ) async throws {
    guard let hapticEngine else { throw EngineNotSupported() }
    let pattern = try CHHapticPattern(events: events, parameters: parameters)
    let player = try hapticEngine.makePlayer(with: pattern)
    
    try await hapticEngine.start()
    try player.start(atTime: 0)
    hapticEngine.notifyWhenPlayersFinished { _ in
      return .stopEngine
    }
  }
#endif
}

public extension Haptics {
  static func generateConfetti(for duration: TimeInterval) async throws {
#if os(iOS)
    var hapticEvents: [CHHapticEvent] = []
    var currentTime: TimeInterval = 0
    
    while currentTime < duration {
      let progress = currentTime / duration
      let bellValue = sin(progress * .pi)
      
      hapticEvents.append(
        CHHapticEvent(
          eventType: .hapticTransient,
          parameters: [
            CHHapticEventParameter(
              parameterID: .hapticIntensity,
              value: .random(in: 0.3...0.8) * Float(0.5 + bellValue * 0.5)
            ),
            CHHapticEventParameter(
              parameterID: .hapticSharpness,
              value: .random(in: 0.3...0.7) * Float(0.5 + bellValue * 0.5)
            ),
          ],
          relativeTime: currentTime
        )
      )
      currentTime += .random(in: 0.005...0.05) * (1.65 - bellValue)
    }
    try await generate(hapticEvents)
#endif
  }
}
