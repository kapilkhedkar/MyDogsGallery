Pod::Spec.new do |s|
  s.name             = 'MyDogsGallery'
  s.version          = '0.2.0'
  s.summary          = 'A simple library to fetch random dog images.'
  s.description      = <<-DESC
  MyDogsGallery is a simple Swift library that fetches random dog images from the Dog CEO API.
  DESC
  s.homepage         = 'https://github.com/kapilkhedkar/MyDogsGallery'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kapil Khedkar' => 'kapilkhedkar9@gmail.com' }
  s.source           = { :git => 'https://github.com/kapilkhedkar/MyDogsGallery.git', :tag => s.version.to_s }
  s.platform         = :ios, '12.0'
  s.source_files     = 'MyDogsGallery/Source/**/*'
  s.swift_version    = '5.0'
  s.dependency 'RealmSwift', '~> 10.0'
end
