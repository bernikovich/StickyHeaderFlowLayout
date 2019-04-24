//
//  Created by Tsimur Bernikovich on 12/6/18.
//  Copyright © 2018 Tsimur Bernikovich. All rights reserved.
//

import UIKit

class CollectionViewSectionHeader: UICollectionReusableView {
    
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.addSubview(label)
        label.frame = self.bounds
        label.text = UICollectionView.elementKindSectionHeader
    }
    
}
