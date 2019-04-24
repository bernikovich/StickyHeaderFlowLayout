Pod::Spec.new do |spec|
    spec.name          = "StickyHeaderFlowLayout"
    spec.version       = "0.2.0"
    spec.summary       = "Sticky headers for UICollectionView written in pure Swift (based on CSStickyHeaderFlowLayout)"
    spec.homepage      = "https://github.com/bernikovich/StickyHeaderFlowLayout"
    spec.license       = { :type => "MIT", :file => "LICENSE" }
    spec.author        = { "Timur Bernikovich" => "bernikowich@icloud.com" }
    spec.platform      = :ios, "9.0"
    spec.swift_version = "5.0"
    spec.framework     = "UIKit"
    spec.source        = { :git => "https://github.com/bernikovich/StickyHeaderFlowLayout.git", :tag => spec.version.to_s }
    spec.source_files  = "StickyHeaderFlowLayout/Classes/**/*.swift"
    spec.module_name   = "StickyHeaderFlowLayout"
end
