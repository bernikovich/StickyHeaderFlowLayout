//
//  CollectionParallaxHeader.swift
//  StickyHeaderFlowLayout
//
//  Created by Tsimur Bernikovich on 12/6/18.
//  Copyright © 2018 Tsimur Bernikovich. All rights reserved.
//

import UIKit

class CollectionParallaxHeader: UICollectionReusableView {
  
  private var imageView : UIImageView?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .lightGray
    self.clipsToBounds = true
    
    let bounds = CGRect(x: 0, y: 0, width: frame.maxX, height: frame.maxY)
    let imageView = UIImageView(frame: bounds)
    imageView.contentMode = .scaleAspectFill
    imageView.image = UIImage(named: "success-baby")
    self.imageView = imageView
    self.addSubview(imageView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.imageView?.frame = self.bounds
  }
  
}
