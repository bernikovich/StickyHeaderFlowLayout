//
//  CollectionViewController.swift
//  StickyHeaderFlowLayout
//
//  Created by Tsimur Bernikovich on 12/6/18.
//  Copyright © 2018 Tsimur Bernikovich. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
  
  var items : [String] = ["CSStickyHeaderFlowLayout basic example", "Example to initialize in code", "As well as in Swift", "Please Enjoy"]
  
  private var layout : CSStickyHeaderFlowLayout? {
    return self.collectionView?.collectionViewLayout as? CSStickyHeaderFlowLayout
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView?.alwaysBounceVertical = true
    view.backgroundColor = .white
    
    // Setup Cell.
    collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    layout?.itemSize = CGSize(width: view.frame.size.width, height: 44)
    
    // Setup Header.
    collectionView.register(CollectionParallaxHeader.self, forSupplementaryViewOfKind: CSStickyHeaderFlowLayout.parallaxHeaderIdentifier, withReuseIdentifier: "parallaxHeader")
    layout?.parallaxHeaderReferenceSize = CGSize(width: self.view.frame.size.width, height: 200)
    layout?.parallaxHeaderMinimumReferenceSize = CGSize(width: self.view.frame.size.width, height: 160)
    
    // Setup Section Header.
    collectionView?.register(CollectionViewSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "sectionHeader")
    layout?.headerReferenceSize = CGSize(width: view.frame.size.width, height: 40)
  }
  
  // Cells.
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.items.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
    cell.text = self.items[indexPath.row]
    return cell
  }
  
  // Parallax Header.
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == CSStickyHeaderFlowLayout.parallaxHeaderIdentifier {
      let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "parallaxHeader", for: indexPath)
      return view
    } else if kind == UICollectionView.elementKindSectionHeader {
      let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath)
      view.backgroundColor = .lightGray
      return view
    }
    
    return UICollectionReusableView()
  }
  
}
