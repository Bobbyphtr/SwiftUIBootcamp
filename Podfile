require_relative 'PodfileHelper'

platform :ios, '14.5'

use_frameworks! :linkage => :static
inhibit_all_warnings!

target 'SwiftUIBootcamp' do

  # Pods for SwiftUIBootcamp
  pod 'EarlGreyApp'

  target 'SwiftUIBootcampTests' do
    # Pods for testing
    pod 'Nimble', '= 9.2.1'
    pod "Quick", "= 2.2.0"

  end

  target 'SwiftUIBootcampUITests' do
    # Pods for testing
    pod 'EarlGreyTest'
  end

end

post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = '$(inherited)'
      end
  end

  static_frameworks = [
    'EarlGreyApp',
    'EarlGreyTest'
  ]
  remove_static_framework_duplicate_linkage({
    'Framework' => static_frameworks
  })
end