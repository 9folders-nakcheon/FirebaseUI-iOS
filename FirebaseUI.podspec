Pod::Spec.new do |s|
  s.name         = 'FirebaseUI'
  s.version      = '4.2.0'
  s.summary      = 'UI binding libraries for Firebase.'
  s.homepage     = 'https://github.com/firebase/FirebaseUI-iOS'
  s.license      = { :type => 'Apache 2.0', :file => 'FirebaseUIFrameworks/LICENSE' }
  s.source       = { :http => 'https://github.com/firebase/FirebaseUI-iOS/releases/download/v4.2.0/FirebaseUIFrameworks.zip' }
  s.author       = 'Firebase'
  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.ios.framework = 'UIKit'
  s.requires_arc = true
  s.default_subspecs = 'All'
  s.ios.vendored_frameworks = 'FirebaseUIFrameworks/*/Frameworks/*.framework'

  s.subspec 'All' do |all|
    all.platform = :ios, '9.0'
    all.dependency 'FirebaseUI/Database'
    all.dependency 'FirebaseUI/Storage'
    all.dependency 'FirebaseUI/Auth'
    all.dependency 'FirebaseUI/Facebook'
    all.dependency 'FirebaseUI/Google'
    all.dependency 'FirebaseUI/Phone'
    all.dependency 'FirebaseUI/Twittersrc'
    all.dependency 'FirebaseUI/Databasesrc'
    all.dependency 'FirebaseUI/Storagesrc'
    all.dependency 'FirebaseUI/Authsrc'
    all.dependency 'FirebaseUI/Facebooksrc'
    all.dependency 'FirebaseUI/Googlesrc'
    all.dependency 'FirebaseUI/Phonesrc'
    all.dependency 'FirebaseUI/Twittersrc'
  end

  s.subspec 'Database' do |database|
    database.platform = :ios, '8.0'
    database.vendored_frameworks = ["FirebaseUIFrameworks/FirebaseDatabaseUI/Frameworks/FirebaseDatabaseUI.framework"]
    database.dependency 'Firebase/Database', '~> 4.0'
  end

  s.subspec 'Storage' do |storage|
    storage.platform = :ios, '8.0'
    storage.vendored_frameworks = ["FirebaseUIFrameworks/FirebaseStorageUI/Frameworks/FirebaseStorageUI.framework"]
    storage.dependency 'Firebase/Storage', '~> 4.0'
    storage.dependency 'SDWebImage', '~> 4.0'
  end

  s.subspec 'Auth' do |auth|
    auth.platform = :ios, '8.0'
    auth.vendored_frameworks = ["FirebaseUIFrameworks/FirebaseAuthUI/Frameworks/FirebaseAuthUI.framework"]
    auth.dependency 'Firebase/Auth', '~> 4.0'
    auth.resource_bundle = {
      'FirebaseAuthUI' => ['FirebaseUIFrameworks/FirebaseAuthUI/Frameworks/FirebaseAuthUI.framework/*.nib',
                           'FirebaseUIFrameworks/FirebaseAuthUI/Frameworks/FirebaseAuthUI.framework/*.lproj',
                           'FirebaseUIFrameworks/FirebaseAuthUI/Frameworks/FirebaseAuthUI.framework/*.png']
    }
  end

  s.subspec 'Facebook' do |facebook|
    facebook.platform = :ios, '8.0'
    facebook.vendored_frameworks = ["FirebaseUIFrameworks/FirebaseFacebookAuthUI/Frameworks/FirebaseFacebookAuthUI.framework"]
    facebook.dependency 'FirebaseUI/Auth'
    facebook.dependency 'FBSDKLoginKit', '~> 4.0'
    facebook.resource_bundle = {
      'FirebaseFacebookAuthUI' => ['FirebaseUIFrameworks/FirebaseFacebookAuthUI/Frameworks/FirebaseFacebookAuthUI.framework/*.nib',
                                   'FirebaseUIFrameworks/FirebaseFacebookAuthUI/Frameworks/FirebaseFacebookAuthUI.framework/*.lproj',
                                   'FirebaseUIFrameworks/FirebaseFacebookAuthUI/Frameworks/FirebaseFacebookAuthUI.framework/*.png']
    }
  end

  s.subspec 'Google' do |google|
    google.platform = :ios, '8.0'
    google.vendored_frameworks = ["FirebaseUIFrameworks/FirebaseGoogleAuthUI/Frameworks/FirebaseGoogleAuthUI.framework"]
    google.dependency 'FirebaseUI/Auth'
    google.dependency 'GoogleSignIn', '~> 4.0'
    google.resource_bundle = {
      'FirebaseGoogleAuthUI' => ['FirebaseUIFrameworks/FirebaseGoogleAuthUI/Frameworks/FirebaseGoogleAuthUI.framework/*.nib',
                                 'FirebaseUIFrameworks/FirebaseGoogleAuthUI/Frameworks/FirebaseGoogleAuthUI.framework/*.lproj',
                                 'FirebaseUIFrameworks/FirebaseGoogleAuthUI/Frameworks/FirebaseGoogleAuthUI.framework/*.png']
    }
  end

  s.subspec 'Phone' do |phone|
    phone.platform = :ios, '8.0'
    phone.vendored_frameworks = ["FirebaseUIFrameworks/FirebasePhoneAuthUI/Frameworks/FirebasePhoneAuthUI.framework"]
    phone.dependency 'FirebaseUI/Auth'
    phone.resource_bundle = {
      'FirebasePhoneAuthUI' => ['FirebaseUIFrameworks/FirebasePhoneAuthUI/Frameworks/FirebasePhoneAuthUI.framework/*.nib',
                                'FirebaseUIFrameworks/FirebasePhoneAuthUI/Frameworks/FirebasePhoneAuthUI.framework/*.lproj',
                                'FirebaseUIFrameworks/FirebasePhoneAuthUI/Frameworks/FirebasePhoneAuthUI.framework/*.png',
                                'FirebaseUIFrameworks/FirebasePhoneAuthUI/Frameworks/FirebasePhoneAuthUI.framework/*.json']
    }
  end

  s.subspec 'Twitter' do |twitter|
    twitter.vendored_frameworks = ["FirebaseUIFrameworks/FirebaseTwitterAuthUI/Frameworks/FirebaseTwitterAuthUI.framework"]
    twitter.dependency 'FirebaseUI/Auth'
    twitter.dependency 'TwitterKit', '~> 3.0'
    twitter.platform = :ios, '9.0'
    twitter.resource_bundle = {
      'FirebaseTwitterAuthUI' => ['FirebaseUIFrameworks/FirebaseTwitterAuthUI/Frameworks/FirebaseTwitterAuthUI.framework/*.nib',
                                  'FirebaseUIFrameworks/FirebaseTwitterAuthUI/Frameworks/FirebaseTwitterAuthUI.framework/*.lproj',
                                  'FirebaseUIFrameworks/FirebaseTwitterAuthUI/Frameworks/FirebaseTwitterAuthUI.framework/*.png']
    }
  end

  ####################################################################################################################################
  # src
  ####################################################################################################################################
  s.subspec 'Databasesrc' do |databasesrc|
    #databasesrc.source = { :git => 'https://github.com/9folders-nakcheon/FirebaseUI-iOS.git', :branch => 'feature/ncjung_add_sourceincoude_to_cocoapod_spec' }
    databasesrc.license = { :type => 'Apache 2.0', :file => 'LICENSE' }
    databasesrc.platform = :ios, '8.0'

    databasesrc.ios.source_files = 'FirebaseDatabaseUI/**/*.[h,m]'
    databasesrc.ios.public_header_files = 'FirebaseDatabaseUI/*.h'

    databasesrc.dependency 'Firebase/Database', '~> 4.0'
  end

  s.subspec 'Storagesrc' do |storagesrc|
    #storagesrc.source = { :git => 'https://github.com/9folders-nakcheon/FirebaseUI-iOS.git', :branch => 'feature/ncjung_add_sourceincoude_to_cocoapod_spec' }
    storagesrc.license = { :type => 'Apache 2.0', :file => 'LICENSE' }
    storagesrc.platform = :ios, '8.0'
    
    storagesrc.ios.source_files = 'FirebaseStorageUI/**/*.[h,m]'
    storagesrc.ios.public_header_files = 'FirebaseStorageUI/*.h'

    storagesrc.dependency 'Firebase/Storage', '~> 4.0'
    storagesrc.dependency 'SDWebImage', '~> 4.0'
  end

  s.subspec 'Authsrc' do |authsrc|
    #authsrc.source = { :git => 'https://github.com/9folders-nakcheon/FirebaseUI-iOS.git', :branch => 'feature/ncjung_add_sourceincoude_to_cocoapod_spec' }
    authsrc.license = { :type => 'Apache 2.0', :file => 'LICENSE' }
    authsrc.platform = :ios, '8.0'
    
    authsrc.ios.source_files = 'FirebaseAuthUI/*.[h,m]'
    authsrc.ios.public_header_files = 'FirebaseAuthUI/*.h'
    authsrc.resources = "FirebaseAuthUI/**/*.png", 'FirebaseAuthUI/**/*.xib', "FirebaseAuthUI/*.lproj"

    authsrc.dependency 'Firebase/Auth', '~> 4.0'
  end

  s.subspec 'Facebooksrc' do |facebooksrc|
    #facebooksrc.source = { :git => 'https://github.com/9folders-nakcheon/FirebaseUI-iOS.git', :branch => 'feature/ncjung_add_sourceincoude_to_cocoapod_spec' }
    facebooksrc.license = { :type => 'Apache 2.0', :file => 'LICENSE' }
    facebooksrc.platform = :ios, '8.0'
    
    facebooksrc.ios.source_files = 'FirebaseFacebookAuthUI/**/*.[h,m]'
    facebooksrc.ios.public_header_files = 'FirebaseFacebookAuthUI/*.h'
    facebooksrc.resources = "FirebaseAuthUI/**/*.png", 'FirebaseAuthUI/**/*.xib', "FirebaseAuthUI/*.lproj"

    facebooksrc.dependency 'FirebaseUI/Auth'
    facebooksrc.dependency 'FBSDKLoginKit', '~> 4.0'
  end

  s.subspec 'Googlesrc' do |googlesrc|
    #googlesrc.source = { :git => 'https://github.com/9folders-nakcheon/FirebaseUI-iOS.git', :branch => 'feature/ncjung_add_sourceincoude_to_cocoapod_spec' }
    googlesrc.license = { :type => 'Apache 2.0', :file => 'LICENSE' }
    googlesrc.platform = :ios, '8.0'
    
    googlesrc.ios.source_files = 'FirebaseGoogleAuthUI/**/*.[h,m]'
    googlesrc.ios.public_header_files = 'FirebaseGoogleAuthUI/**/*.h'
    googlesrc.resources = "FirebaseAuthUI/**/*.png", 'FirebaseAuthUI/**/*.xib', "FirebaseAuthUI/*.lproj"

    googlesrc.dependency 'FirebaseUI/Auth'
    googlesrc.dependency 'GoogleSignIn', '~> 4.0'
  end

  s.subspec 'Phonesrc' do |phonesrc|
    #phonesrc.source = { :git => 'https://github.com/9folders-nakcheon/FirebaseUI-iOS.git', :branch => 'feature/ncjung_add_sourceincoude_to_cocoapod_spec' }
    phonesrc.license = { :type => 'Apache 2.0', :file => 'LICENSE' }
    phonesrc.platform = :ios, '8.0'
    
    phonesrc.ios.source_files = 'FirebasePhoneAuthUI/**/*.[h,m]'
    phonesrc.ios.public_header_files = 'FirebasePhoneAuthUI/**/*.h'
    phonesrc.resources = "FirebaseAuthUI/**/*.png", 'FirebaseAuthUI/**/*.xib', "FirebaseAuthUI/*.lproj", "FirebaseAuthUI/*.json"

    phonesrc.dependency 'FirebaseUI/Auth'
  end

  s.subspec 'Twittersrc' do |twittersrc|
    #twittersrc.source = { :git => 'https://github.com/9folders-nakcheon/FirebaseUI-iOS.git', :branch => 'feature/ncjung_add_sourceincoude_to_cocoapod_spec' }
    twittersrc.license = { :type => 'Apache 2.0', :file => 'LICENSE' }
    twittersrc.platform = :ios, '8.0'

    twittersrc.ios.source_files = 'FirebaseTwitterAuthUI/**/*.[h,m]'
    twittersrc.ios.public_header_files = 'FirebaseTwitterAuthUI/**/*.h'
    twittersrc.resources = "FirebaseAuthUI/**/*.png", 'FirebaseAuthUI/**/*.xib', "FirebaseAuthUI/*.lproj"

    twittersrc.dependency 'FirebaseUI/Auth'
    twittersrc.dependency 'TwitterKit', '~> 3.0'
    twittersrc.platform = :ios, '9.0'
  end

end
