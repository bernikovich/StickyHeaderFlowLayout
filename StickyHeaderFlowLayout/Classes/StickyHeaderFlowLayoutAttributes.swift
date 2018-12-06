//
//  Created by Tsimur Bernikovich on 12/6/18.
//  Copyright © 2018 Tsimur Bernikovich. All rights reserved.
//

import UIKit

class StickyHeaderFlowLayoutAttributes: UICollectionViewLayoutAttributes {
  
  var progressiveness: CGFloat = 0
  
  override func copy(with zone: NSZone? = nil) -> Any {
    let copy = super.copy(with: zone)
    if let copy = copy as? StickyHeaderFlowLayoutAttributes {
      copy.progressiveness = progressiveness
    }
    return copy
  }
  
  override var zIndex: Int {
    didSet {
      // Fixes: Section header go behind cell when insert via performBatchUpdates #68
      // https://github.com/jamztang/CSStickyHeaderFlowLayout/issues/68#issuecomment-108678022
      // Reference: UICollectionView setLayout:animated: not preserving zIndex
      // http://stackoverflow.com/questions/12659301/uicollectionview-setlayoutanimated-not-preserving-zindex
      
      // originally our solution is to translate the section header above the original z position,
      // however, scroll indicator will be covered by those cells and section header if z position is >= 1
      // so instead we translate the original cell to be -1, and make sure the cell are hit test proven.
      transform3D = CATransform3DMakeTranslation(0, 0, zIndex == 1 ? -1 : 0);
    }
  }
  
}
