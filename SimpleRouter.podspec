#
# Be sure to run `pod lib lint SimpleRouter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SimpleRouter"
  s.version          = "0.1.0"
  s.summary          = "A Simple Laravel/Lumen Inspired Url-Based Router Library With Middleware Support Written Entirely in Swift"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                        This pod provides the ability to use url based routing in app. It's inspired by Laravel/Lumen with middleware support.
                       DESC

  s.homepage         = "https://github.com/wenfzhao/SimpleRouter"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Wen Zhao" => "wzhao@money-media.com" }
  s.source           = { :git => "https://github.com/wenfzhao/SimpleRouter.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Source/**/*'

  # s.public_header_files = 'Source/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
