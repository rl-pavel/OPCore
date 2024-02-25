#if canImport(UIKit)
import UIKit

public extension UICollectionView {
  func registerCell<Cell: UICollectionViewCell>(_ viewType: Cell.Type) {
    let identifier = String(describing: viewType)
    register(viewType, forCellWithReuseIdentifier: identifier)
  }
  
  func registerSupplementView<View: UICollectionReusableView>(_ viewClass: View.Type, kind: String) {
    let identifier = String(describing: viewClass)
    register(viewClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
  }
  
  func dequeueCell<Cell: UICollectionViewCell>(_ cellType: Cell.Type, for indexPath: IndexPath) -> Cell? {
    let identifier = String(describing: cellType)
    return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell
  }
  
  func dequeueSupplementView<View: UICollectionReusableView>(
    _ viewClass: View.Type,
    kind: String,
    for indexPath: IndexPath) -> View? {
      let identifier = String(describing: viewClass)
      return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as? View
    }
  
  func scrollToSupplementaryElement(ofKind kind: String, section: Int, animated: Bool = true) {
    let sectionIndexPath = IndexPath(item: 0, section: section)
    guard let elementAttributes = layoutAttributesForSupplementaryElement(ofKind: kind, at: sectionIndexPath) else {
      return
    }
    
    setContentOffset(elementAttributes.frame.origin, animated: animated)
  }
}

public extension IndexPath {
  static let zero = IndexPath(item: 0, section: 0)
}
#endif
