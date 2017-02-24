
Pod::Spec.new do |s|
  s.name             = 'CTImageEdit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of CTImageEdit.'


  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/huangcheng1/CTImageEdit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'acct<blob>=<NULL>' => '632306630@qq.com' }
  s.source           = { :git => 'https://github.com/huangcheng1/CTImageEdit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CTImageEdit/Classes/**/*'
  
  s.resources = "CTImageEdit/Assets/*.png"

end
