platform :osx, '10.12'

target 'SuperLachaiseRealmLoader' do
  use_frameworks!

  pod 'RealmSwift'
  pod 'SwiftyJSON'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
    end
  end
end
