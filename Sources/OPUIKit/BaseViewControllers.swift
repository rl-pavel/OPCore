#if canImport(UIKit)
import OPFoundation
import SwiftUI

/// UIHostingController subclass for hosting SwiftUI views.
open class Host<Content: View>: UIHostingController<Content> {
  init(backgroundColor: UIColor = .clear, @ViewBuilder content: Factory<Content>) {
    super.init(rootView: content())
    view.backgroundColor = backgroundColor
  }
  
  init(_ content: Content, backgroundColor: UIColor = .clear) {
    super.init(rootView: content)
    view.backgroundColor = backgroundColor
  }
  
  @available(*, unavailable)
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

open class ViewController: UIViewController {
  public override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
  }
  
  /// Dismisses the controller.
  @objc func dismissTapped() {
    dismiss(animated: true, completion: nil)
  }
  
  /// Pops the view controller in the navigation stack.
  @objc func backTapped() {
    navigationController?.popViewController(animated: true)
  }
}
#endif


// TODO: Is this needed anymore?

//private extension Host {
//  /// 🧙‍♀️ source: https://steipete.com/posts/disabling-keyboard-avoidance-in-swiftui-uihostingcontroller/
//  func setUpKeyboardIgnorance() {
//    guard let viewClass = object_getClass(view) else { return }
//
//    let viewSubclassName = String(cString: class_getName(viewClass)).appending("_IgnoresKeyboard")
//    if let viewSubclass = NSClassFromString(viewSubclassName) {
//      object_setClass(view, viewSubclass)
//    } else {
//      guard let viewClassNameUtf8 = (viewSubclassName as NSString).utf8String else { return }
//      guard let viewSubclass = objc_allocateClassPair(viewClass, viewClassNameUtf8, 0) else { return }
//
//      if let method = class_getInstanceMethod(viewClass, NSSelectorFromString("keyboardWillShowWithNotification:")) {
//        let keyboardWillShow: @convention(block) (AnyObject, AnyObject) -> Void = { _, _ in }
//        class_addMethod(
//          viewSubclass,
//          NSSelectorFromString("keyboardWillShowWithNotification:"),
//          imp_implementationWithBlock(keyboardWillShow),
//          method_getTypeEncoding(method)
//        )
//      }
//      objc_registerClassPair(viewSubclass)
//      object_setClass(view, viewSubclass)
//    }
//  }
//}
