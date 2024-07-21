# MyDogsGallery
MyDogsGallery is a Swift framework for fetching random dog images from the [Dog CEO's Dog API](https://dog.ceo/dog-api/). It includes functionality to fetch a single image, the next image, and a specified number of images.

## Features
- Fetch a random dog image (getImage)
- Fetch the next dog image (getNextImage)
- Fetch a specified number of random dog images (getImages)

## Installation

### CocoaPods

To integrate MyDogsGallery into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
platform :ios, '12.0'
use_frameworks!

target 'YourAppTarget' do
  pod 'MyDogsGallery', '~> 0.8.0'
end
```

### Private Specs Repository

To integrate MyDogsGallery into your Xcode project using a Private Specs Repository, specify it in your `Podfile`:

```ruby
source 'https://github.com/kapilkhedkar/MDGPrivateSpecs.git'
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '12.0'
use_frameworks!

target 'YourAppTarget' do
  pod 'MyDogsGallery', '~> 0.8.0'
end
```

## Requirements
- iOS 12.0+
- Xcode 12.0+
- Swift 5.0+

## Unit Tests
Unit Tests have been written in the 'MyDogsGalleryTests' target using Apple's XCTestFramework for the 3 features:
- testGetImage
- testGetNextImage
- testGetImages

## License
MyDogsGallery is released under the MIT license. See `LICENSE` for details.
