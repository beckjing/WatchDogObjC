#
#  Be sure to run `pod spec lint WatchdogObjC.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "WatchdogObjC"
  s.version      = "0.0.1"
  s.summary      = "Class for logging excessive blocking on the main thread."
  s.description  = <<-DESC
  Class for logging excessive blocking on the main thread. It watches the main thread and checks if it doesn’t get blocked for more than defined threshold. You can also inspect which part of your code is blocking the main thread.
                   DESC

  s.homepage              = "https://github.com/beckjing/WatchDogObjC"
  s.license               = "MIT"
  s.author                = { "beckjing" => "176547352@qq.com" }
  s.social_media_url      = "https://github.com/beckjing"
  s.ios.deployment_target = "8.0"
  s.source                = { :git => "https://github.com/beckjing/WatchDogObjC.git", :tag => "#{s.version}" }
  s.source_files          = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files         = "Classes/Exclude"
  s.requires_arc          = true


end
