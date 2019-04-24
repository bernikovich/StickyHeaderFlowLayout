//
//  Created by Tsimur Bernikovich on 12/6/18.
//  Copyright © 2018 Tsimur Bernikovich. All rights reserved.
//

import UIKit

open class StickyHeaderFlowLayout: UICollectionViewFlowLayout {
  
  open class var parallaxHeaderIdentifier: String {
    return "StickyHeaderParallexHeader"
  }
  private static let headerZIndex = 1024
  
  open var parallaxHeaderReferenceSize: CGSize = .zero
  open var parallaxHeaderMinimumReferenceSize: CGSize = .zero {
    didSet {
      invalidateLayout()
    }
  }
  
  open var parallaxHeaderAlwaysOnTop = false
  open var disableStickyHeaders = false
  open var disableStretching = false
  
  open override func prepare() {
    super.prepare()
  }
  
  open override func initialLayoutAttributesForAppearingSupplementaryElement(ofKind elementKind: String, at elementIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    let attributes = super.initialLayoutAttributesForAppearingSupplementaryElement(ofKind: elementKind, at: elementIndexPath)
    if elementKind == type(of: self).parallaxHeaderIdentifier {
      // Sticky header do not need to offset.
      return nil
    } else {
      if var frame = attributes?.frame {
        frame.origin.y = parallaxHeaderReferenceSize.height
        attributes?.frame = frame
      }
    }
    return attributes
  }
  
  open override func finalLayoutAttributesForDisappearingSupplementaryElement(ofKind elementKind: String, at elementIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    if elementKind == type(of: self).parallaxHeaderIdentifier {
      let attribute = layoutAttributesForSupplementaryView(ofKind: elementKind, at: elementIndexPath)
      if let attribute = attribute as? StickyHeaderFlowLayoutAttributes {
        updateParallaxHeaderAttribute(attribute)
      }
      return attribute
    } else {
      super.finalLayoutAttributesForDisappearingSupplementaryElement(ofKind: elementKind, at: elementIndexPath)
    }
    return nil
  }
  
  open override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    var attrubutes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
    if attrubutes == nil && elementKind == type(of: self).parallaxHeaderIdentifier {
      attrubutes = StickyHeaderFlowLayoutAttributes(forSupplementaryViewOfKind: elementKind, with: indexPath)
    }
    return attrubutes
  }
  
  open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard collectionView?.dataSource != nil else {
      return nil
    }
    
    // The rect should compensate the header size
    var adjustedRect = rect
    adjustedRect.origin.y -= self.parallaxHeaderReferenceSize.height
    
    var allItems: [UICollectionViewLayoutAttributes] = []
    // Perform a deep copy of the attributes returned from super.
    if let originalAttributes = super.layoutAttributesForElements(in: adjustedRect) {
      allItems = originalAttributes.compactMap {
        $0.copy() as? UICollectionViewLayoutAttributes
      }
    }
    
    var headers: [Int: UICollectionViewLayoutAttributes] = [:]
    var lastCells: [Int: UICollectionViewLayoutAttributes] = [:]
    var visibleParallaxHeader = false
    
    for item in allItems {
      let attributes = item
      var frame = attributes.frame
      frame.origin.y += parallaxHeaderReferenceSize.height
      attributes.frame = frame
      
      let indexPath = attributes.indexPath
      let isHeader = attributes.representedElementKind == UICollectionView.elementKindSectionHeader
      let isFooter = attributes.representedElementKind == UICollectionView.elementKindSectionFooter
      
      if isHeader {
        headers[indexPath.section] = attributes
      } else if isFooter {
        // Not implemeneted.
      } else {
        // Get the bottom most cell of that section.
        if let currentAttribute = lastCells[indexPath.section] {
          if indexPath.row > currentAttribute.indexPath.row {
            lastCells[indexPath.section] = attributes
          }
        } else {
          lastCells[indexPath.section] = attributes
        }
        
        if indexPath.item == 0 && indexPath.section == 0 {
          visibleParallaxHeader = true
        }
      }
      
      if isHeader {
        attributes.zIndex = type(of: self).headerZIndex
      } else {
        // For iOS 7.0, the cell zIndex should be above sticky section header.
        attributes.zIndex = 1
      }
    }
    
    if rect.minY <= 0 {
      visibleParallaxHeader = true
    }
    
    if parallaxHeaderAlwaysOnTop {
      visibleParallaxHeader = true
    }
    
    // Create the attributes for the Parallex header.
    if visibleParallaxHeader && parallaxHeaderReferenceSize != .zero {
      let currentAttribute = StickyHeaderFlowLayoutAttributes(forSupplementaryViewOfKind: type(of: self).parallaxHeaderIdentifier, with: IndexPath(index: 0))
      updateParallaxHeaderAttribute(currentAttribute)
      allItems.append(currentAttribute)
    }
    
    if !disableStickyHeaders {
      lastCells.forEach {
        let indexPath = $0.value.indexPath
        let indexPathKey = indexPath.section
        
        if let header = headers[indexPathKey] {
          if header.frame.size != .zero {
            updateHeaderAttributes(header, lastCellAttributes: $0.value)
          }
        } else if let header = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: indexPath.section)) {
          if header.frame.size != .zero {
            allItems.append(header)
          }
        }
      }
    }
    
    return allItems
  }
  
  open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    let attributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes
    if var frame = attributes?.frame {
      frame.origin.y += parallaxHeaderReferenceSize.height
      attributes?.frame = frame
    }
    return attributes
  }
  
  open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
  
  open override class var layoutAttributesClass: AnyClass {
    return StickyHeaderFlowLayoutAttributes.self
  }
  
  private func updateHeaderAttributes(_ attributes: UICollectionViewLayoutAttributes, lastCellAttributes: UICollectionViewLayoutAttributes) {
    guard let collectionView = collectionView else {
      return
    }
    
    let currentBounds = collectionView.bounds
    attributes.zIndex = type(of: self).headerZIndex
    attributes.isHidden = false
    
    var origin = attributes.frame.origin
    let sectionMaxY = lastCellAttributes.frame.maxY - attributes.frame.size.height
    var y = currentBounds.maxY - currentBounds.size.height + collectionView.contentInset.top
    
    if parallaxHeaderAlwaysOnTop {
      y += parallaxHeaderMinimumReferenceSize.height
    }
    
    origin.y = min(max(y, attributes.frame.origin.y), sectionMaxY)
    attributes.frame = CGRect(origin: origin, size: attributes.frame.size)
  }
  
  private func updateParallaxHeaderAttribute(_ currentAttribute: StickyHeaderFlowLayoutAttributes) {
    guard let collectionView = collectionView else {
      return
    }
    
    var frame = currentAttribute.frame
    frame.size = parallaxHeaderReferenceSize
    
    let bounds = collectionView.bounds
    let maxY = frame.maxY
    
    // Make sure the frame won't be negative values.
    var y = min(maxY - parallaxHeaderMinimumReferenceSize.height, bounds.origin.y + collectionView.contentInset.top)
    let height = max(0, -y + maxY)
    
    let maxHeight = parallaxHeaderReferenceSize.height
    let minHeight = parallaxHeaderMinimumReferenceSize.height
    let progressiveness = (height - minHeight) / (maxHeight - minHeight)
    currentAttribute.progressiveness = progressiveness
    
    // If zIndex < 0 would prevents tap from recognized right under navigation bar.
    currentAttribute.zIndex = 0
    
    // When parallaxHeaderAlwaysOnTop is enabled, we will check when we should update the y position.
    if parallaxHeaderAlwaysOnTop && height <= parallaxHeaderMinimumReferenceSize.height {
      let insetTop = collectionView.contentInset.top
      // Always stick to top but under the nav bar.
      y = collectionView.contentOffset.y + insetTop
      currentAttribute.zIndex = 2000
    }
    
    let normalizedHeight = disableStretching && height > maxHeight ? maxHeight : height
    currentAttribute.frame = CGRect(x: frame.origin.x, y: y, width: frame.size.width, height: normalizedHeight)
  }
  
}

extension StickyHeaderFlowLayoutAttributes {
  
  override internal var debugDescription: String {
    let indexPathString = "\(indexPath.section) \(indexPath.item)"
    return "<StickyHeaderFlowLayoutAttributes: \(self)> indexPath: \(indexPathString) zIndex: \(zIndex) valid: \(isValid) kind: \(representedElementKind ?? "cell")"
  }
  
  fileprivate var isValid: Bool {
    switch representedElementCategory {
    case .cell:
      if zIndex != 1 {
        return false
      }
      return true
    case .supplementaryView:
      if representedElementKind == StickyHeaderFlowLayout.parallaxHeaderIdentifier {
        return true
      } else if zIndex < 1024 {
        return false
      }
      return true
    default:
      return true
    }
  }
  
}

private extension StickyHeaderFlowLayout {
  
  func debugLayoutAttributes(_ layoutAttributes: [StickyHeaderFlowLayoutAttributes]) {
    var hasInvalid = false
    layoutAttributes.forEach {
      if !$0.isValid {
        hasInvalid = true
      }
    }
    
    if hasInvalid {
      print("StickyHeaderFlowLayout: \(layoutAttributes)")
    }
  }
  
}
