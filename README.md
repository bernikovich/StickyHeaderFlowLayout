<p align="center">
	<img src="/Resources/logo.svg" alt="StickyHeaderFlowLayout" width="105">
  <br/>
  <h3 align="center">StickyHeaderFlowLayout</h2>
  <p align="center">Sticky headers for UICollectionView written in pure Swift</p>
  <h1></h1>
  <br/>
</p>

Based on [CSStickyHeaderFlowLayout](https://github.com/CSStickyHeaderFlowLayout/CSStickyHeaderFlowLayout). `StickyHeaderFlowLayout` makes it easy to create sticky headers in `UICollectionView`.

## Integration

#### CocoaPods

You can use [CocoaPods](http://cocoapods.org/) to install `StickyHeaderFlowLayout` by adding it to your `Podfile`:

```ruby
platform :ios, '9.0'

target 'MyApp' do
    pod 'StickyHeaderFlowLayout'
end
```

#### Manually

To use this library in your project manually you may:

Just drag `StickyHeaderFlowLayout.swift` and `StickyHeaderFlowLayoutAttributes.swift` to the project tree

## Usage

#### Sample project

Repository contains small sample project which shows basic integration.

#### Basic idea

1. Create layout and collection view
```swift
let layout = StickyHeaderFlowLayout()
let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
```

2. Setup sticky header
```swift
collectionView.register(CollectionParallaxHeader.self, forSupplementaryViewOfKind: StickyHeaderFlowLayout.parallaxHeaderIdentifier, withReuseIdentifier: "parallaxHeader")
layout.parallaxHeaderReferenceSize = CGSize(width: view.frame.size.width, height: 200)
layout.parallaxHeaderMinimumReferenceSize = CGSize(width: view.frame.size.width, height: 160)
```

3. Return correct view in `viewForSupplementaryElementOfKind` function
```swift
override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
     if kind == StickyHeaderFlowLayout.parallaxHeaderIdentifier {
         return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "parallaxHeader", for: indexPath)
     }
     
     // Other views.
     ...
}
```
