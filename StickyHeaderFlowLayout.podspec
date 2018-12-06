Pod::Spec.new do |spec|
  spec.name          = "StickyHeaderFlowLayout"
  spec.version       = "0.9"
  spec.summary       = "Sticky headers for UICollectionView written in pure Swift"
  spec.homepage      = "https://github.com/bernikowich/StickyHeaderFlowLayout"
  spec.license       = { :type => 'MIT' }
  spec.author        = { "Timur Bernikowich" => "bernikowich@icloud.com" }
  spec.platform      = :ios, "8.0"
  spec.swift_version = "4.2"
  spec.source        = { :git => "https://github.com/bernikowich/StickyHeaderFlowLayout.git", :tag => "#{s.version}" }
  spec.source_files  = "StickyHeaderFlowLayout/Classes/*.{h,m}"
  spec.module_name   = "StickyHeaderFlowLayout"
end
