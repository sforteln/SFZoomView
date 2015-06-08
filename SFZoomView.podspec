Pod::Spec.new do |s|
  s.name             = "SFZoomView"
  s.version          = "0.1.0"
  s.summary          = "A library to simply zoom in and out a UIView."
  s.description      = <<-DESC
                       A library to simply zoom in and out a UIView.  It has a default animation similar to UIAlertView and allows for custom anitmation keyframes.

                       DESC
  s.homepage         = "https://github.com/sforteln/SFZoomView"
  s.license          = 'MIT'
  s.author           = { "Simon Fortelny" => "sforteln@gmail.com" }
  s.source           = { :git => "https://github.com/sforteln/SFZoomView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/simonfort'
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'Classes/**/*'
end
