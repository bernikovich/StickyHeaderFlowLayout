//
//  CollectionViewCell.swift
//  StickyHeaderFlowLayout
//
//  Created by Tsimur Bernikovich on 12/6/18.
//  Copyright © 2018 Tsimur Bernikovich. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
  
  var text : String? {
    didSet {
      self.reloadData()
    }
  }
  
  private var textLabel : UILabel?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
    
    let bounds = CGRect(x: 0, y: 0, width: frame.maxX, height: frame.maxY)
    let label = UILabel(frame: bounds)
    label.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    self.textLabel = label
    self.addSubview(label)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func reloadData() {
    self.textLabel?.text = self.text
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.textLabel?.frame = self.bounds
  }

}
