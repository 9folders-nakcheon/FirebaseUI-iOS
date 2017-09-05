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
    all.dependency 'FirebaseUI/FirebaseDatabaseUI'
    all.dependency 'FirebaseUI/FirebaseStorageUI'
    all.dependency 'FirebaseUI/FirebaseAuthUI'
    all.dependency 'FirebaseUI/FirebaseFacebookAuthUI'
    all.dependency 'FirebaseUI/FirebaseGoogleAuthUI'
    all.dependency 'FirebaseUI/FirebasePhoneAuthUI'
    all.dependency 'FirebaseUI/FirebaseTwitterAuthUI'
  end

  s.subspec 'Database' do |database|
    database.platform = :ios, '8.0'
    database.vendored_frameworks = ["FirebaseUIFrameworks/FirebaseDatabaseUI/Frameworks/FirebaseDatabaseUI.framework"]
    database.dependency 'Firebase/Database'
  end

  s.subspec 'Storage' do |storage|
    storage.platform = :ios, '8.0'
    storage.vendored_frameworks = ["FirebaseUIFrameworks/FirebaseStorageUI/Frameworks/FirebaseStorageUI.framework"]
    storage.dependency 'Firebase/Storage'
    storage.dependency 'SDWebImage'
  end

  s.subspec 'Auth' do |auth|
    auth.platform = :ios, '8.0'
    auth.vendored_frameworks = ["FirebaseUIFrameworks/FirebaseAuthUI/Frameworks/FirebaseAuthUI.framework"]
    auth.dependency 'Firebase/Auth'
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
    facebook.dependency 'FBSDKLoginKit'
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
    google.dependency 'GoogleSignIn'
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
  s.subspec 'FirebaseDatabaseUI' do |ss|
  
    ss.platform = :ios, '8.0'

    ss.ios.source_files = 'FirebaseDatabaseUI/**/*.[h,m]'
    ss.ios.public_header_files = 'FirebaseDatabaseUI/**/*.h'

    ss.dependency 'Firebase/Database'
  end

  s.subspec 'FirebaseStorageUI' do |ss|
    ss.platform = :ios, '8.0'
    
    ss.ios.source_files = 'FirebaseStorageUI/**/*.[h,m]'
    ss.ios.public_header_files = 'FirebaseStorageUI/**/*.h'

    ss.dependency 'Firebase/Storage'
    ss.dependency 'SDWebImage'
  end

  s.subspec 'FirebaseAuthUI' do |ss|
    ss.platform = :ios, '8.0'
    
    ss.ios.source_files = 'FirebaseAuthUI/**/*.[h,m]'
    ss.ios.public_header_files = 'FirebaseAuthUI/**/*.h'
    ss.resources = "FirebaseAuthUI/**/*.png", 'FirebaseAuthUI/**/*.xib', "FirebaseAuthUI/*.lproj"

    ss.dependency 'Firebase/Auth'
  end

  s.subspec 'FirebaseFacebookAuthUI' do |ss|
    ss.platform = :ios, '8.0'
    
    ss.ios.source_files = 'FirebaseFacebookAuthUI/**/*.[h,m]'
    ss.ios.public_header_files = 'FirebaseFacebookAuthUI/**/*.h'
    ss.resources = "FirebaseFacebookAuthUI/**/*.png", 'FirebaseFacebookAuthUI/**/*.xib', "FirebaseFacebookAuthUI/*.lproj"

    ss.dependency 'FirebaseUI/FirebaseAuthUI'
    ss.dependency 'FBSDKLoginKit'
  end

  s.subspec 'FirebaseGoogleAuthUI' do |ss|
    ss.platform = :ios, '8.0'
    
    ss.ios.source_files = 'FirebaseGoogleAuthUI/**/*.[h,m]'
    ss.ios.public_header_files = 'FirebaseGoogleAuthUI/**/*.h'
    ss.resources = "FirebaseGoogleAuthUI/**/*.png", 'FirebaseGoogleAuthUI/**/*.xib', "FirebaseGoogleAuthUI/*.lproj"

    ss.dependency 'FirebaseUI/FirebaseAuthUI'
    ss.dependency 'GoogleSignIn'
  end

  s.subspec 'FirebasePhoneAuthUI' do |ss|
    ss.platform = :ios, '8.0'
    
    ss.ios.source_files = 'FirebasePhoneAuthUI/**/*.[h,m]'
    ss.ios.public_header_files = 'FirebasePhoneAuthUI/**/*.h'
    ss.resources = "FirebasePhoneAuthUI/**/*.png", 'FirebasePhoneAuthUI/**/*.xib', "FirebasePhoneAuthUI/*.lproj", "FirebasePhoneAuthUI/*.json"

    ss.dependency 'FirebaseUI/FirebaseAuthUI'
  end

  s.subspec 'FirebaseTwitterAuthUI' do |ss|
    ss.platform = :ios, '9.0'
    ss.ios.source_files = 'FirebaseTwitterAuthUI/**/*.[h,m]'
    ss.ios.public_header_files = 'FirebaseTwitterAuthUI/**/*.h'
    ss.resources = "FirebaseTwitterAuthUI/**/*.png", 'FirebaseTwitterAuthUI/**/*.xib', "FirebaseTwitterAuthUI/*.lproj"

    ss.dependency 'FirebaseUI/FirebaseAuthUI'
    ss.dependency 'TwitterKit', '~> 3.0'
  end

end
