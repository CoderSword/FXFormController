#
# Be sure to run `pod lib lint FXFormController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FXFormController'
  s.version          = '0.2.0'
  s.summary          = 'A short description of FXFormController.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/liutian6867@163.com/FXFormController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liutian6867@163.com' => 'liutian6867@163.com' }
  s.source           = { :git => 'https://github.com/CoderSword/FXFormController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'FXFormController/Classes/**/*'
  
   s.resource_bundles = {
     'FXFormController' => ['FXFormController/Assets/imageShare.bundle']
   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'MJExtension'
   s.dependency 'TZImagePickerController'
   s.dependency 'GKPhotoBrowser'
   s.dependency 'BRPickerView'
   s.dependency 'SDWebImage'
   s.dependency 'Masonry'
end
