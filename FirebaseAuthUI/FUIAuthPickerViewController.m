//
//  Copyright (c) 2016 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "FUIAuthPickerViewController.h"

#import <FirebaseAuth/FirebaseAuth.h>
#import "FUIAuthBaseViewController_Internal.h"
#import "FUIAuthSignInButton.h"
#import "FUIAuthStrings.h"
#import "FUIAuthUtils.h"
#import "FUIAuth_Internal.h"
#import "FUIEmailEntryViewController.h"
#import "IXAppManager.h"

/** @var kErrorUserInfoEmailKey
 @brief The key for the email address in the userinfo dictionary of a sign in error.
 */
static NSString *const kErrorUserInfoEmailKey = @"FIRAuthErrorUserInfoEmailKey";

/** @var kEmailButtonAccessibilityID
 @brief The Accessibility Identifier for the @c email sign in button.
 */
static NSString *const kEmailButtonAccessibilityID = @"EmailButtonAccessibilityID";

/** @var kSignInButtonWidth
 @brief The width of the sign in buttons.
 */
static const CGFloat kSignInButtonWidth = 220.0f;

/** @var kSignInButtonHeight
 @brief The height of the sign in buttons.
 */
static const CGFloat kSignInButtonHeight = 40.0f;

/** @var kSignInButtonVerticalMargin
 @brief The vertical margin between sign in buttons.
 */
static const CGFloat kSignInButtonVerticalMargin = 24.0f;

/** @var kButtonContainerBottomMargin
 @brief The magin between sign in buttons and the bottom of the screen.
 */
static const CGFloat kButtonContainerBottomMargin = 56.0f;

@interface FUIAuthPickerViewController ()
@property (strong, nonatomic) UIView *buttonContainerView;

@end

@implementation FUIAuthPickerViewController

#pragma mark - class life cycle

- (instancetype)initWithAuthUI:(FUIAuth *)authUI {
    
    BOOL bundleLoaded = [FUIAuthUtils bundleNamed:FUIAuthBundleName].isLoaded;
    
    return [self initWithNibName:NSStringFromClass([self class])
                          bundle:bundleLoaded? [FUIAuthUtils bundleNamed:FUIAuthBundleName] : nil
                          authUI:authUI];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                         authUI:(FUIAuth *)authUI {
    
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil
                           authUI:authUI];
    if (self) {
        self.title = FUILocalizedString(kStr_AuthPickerTitle);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // cancel button
    if (!self.hideCancelButton) {
        UIBarButtonItem *cancelBarButton =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                      target:self
                                                      action:@selector(cancelAuthorization)];
        self.navigationItem.leftBarButtonItem = cancelBarButton;
    }
    
    // add provider buttons
    NSInteger numberOfButtons = self.authUI.providers.count;
    BOOL showEmailButton = !self.authUI.signInWithEmailHidden;
    if (showEmailButton) {
        ++numberOfButtons;
    }
    CGFloat buttonContainerViewHeight =
    kSignInButtonHeight * numberOfButtons + kSignInButtonVerticalMargin * (numberOfButtons - 1);
    CGRect buttonContainerViewFrame = CGRectMake(0, 0, kSignInButtonWidth, buttonContainerViewHeight);
    self.buttonContainerView = [[UIView alloc] initWithFrame:buttonContainerViewFrame];
    [self.view addSubview:self.buttonContainerView];
    
    CGRect buttonFrame = CGRectMake(0, 0, kSignInButtonWidth, kSignInButtonHeight);
    for (id<FUIAuthProvider> providerUI in self.authUI.providers) {
        UIButton *providerButton = [[FUIAuthSignInButton alloc] initWithFrame:buttonFrame providerUI:providerUI];
        [providerButton addTarget:self
                           action:@selector(didTapSignInButton:)
                 forControlEvents:UIControlEventTouchUpInside];
        [self.buttonContainerView addSubview:providerButton];
        
        // Make the frame for the new button.
        buttonFrame.origin.y += (kSignInButtonHeight + kSignInButtonVerticalMargin);
    }
    
    // add email button
    if (showEmailButton) {
        UIColor *emailButtonBackgroundColor =
        [UIColor colorWithRed:208.f/255.f green:2.f/255.f blue:27.f/255.f alpha:1.0];
        UIButton *emailButton =
        [[FUIAuthSignInButton alloc] initWithFrame:buttonFrame
                                             image:[FUIAuthUtils imageNamed:@"ic_email"
                                                                 fromBundle:FUIAuthBundleName]
                                              text:FUILocalizedString(kStr_SignInWithEmail)
                                   backgroundColor:emailButtonBackgroundColor
                                         textColor:[UIColor whiteColor]];
        [emailButton addTarget:self
                        action:@selector(signInWithEmail)
              forControlEvents:UIControlEventTouchUpInside];
        emailButton.accessibilityIdentifier = kEmailButtonAccessibilityID;
        [self.buttonContainerView addSubview:emailButton];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat distanceFromCenterToBottom =
    CGRectGetHeight(self.buttonContainerView.frame) / 2.0f + kButtonContainerBottomMargin;
    CGFloat centerY = CGRectGetHeight(self.view.bounds) - distanceFromCenterToBottom;
    // Compensate for bounds adjustment if any.
    centerY += self.view.bounds.origin.y;
    self.buttonContainerView.center = CGPointMake(self.view.center.x, centerY);
}

- (void)viewDidAppear:(BOOL)animated
{
    DDLogVerbose(@"%s", __PRETTY_FUNCTION__);
    
    // navigation bar
    if (self.hideNavigationBar) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(36, 36), NO, 0.0);
        UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithCGImage:blank.CGImage] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [UIImage imageWithCGImage:blank.CGImage];
        self.navigationController.navigationBar.translucent = YES;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Navigation

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    [super willMoveToParentViewController:parent];
    
    // back button event
    if (!parent) {
        // WARNING: 정확한 순간에 호출되지 않음
        DDLogVerbose(@"%s", __PRETTY_FUNCTION__);
    }
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    // back button event
    if (!parent) {
        // WARNING: 정확한 순간에 호출되지 않음
        DDLogVerbose(@"%s", __PRETTY_FUNCTION__);
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DDLogVerbose(@"%s", __PRETTY_FUNCTION__);
}

- (BOOL)canPerformUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender
{
    DDLogVerbose(@"%s", __PRETTY_FUNCTION__);
    
    if (![super canPerformAction:action withSender:self]) {
        return NO;
    }
    
    if ([fromViewController isEqual:self]) {
        return NO;
    }
    
    return YES;
}

- (IBAction)prepareForUnwindToFirebaseAuthPickerView:(UIStoryboardSegue *)segue
{
    DDLogVerbose(@"%s", __PRETTY_FUNCTION__);
}


#pragma mark - Public

- (void)configure
{
    // cancel button
    if (self.hideCancelButton) {
        self.navigationItem.leftBarButtonItem = nil;
    }
    
    // navigation bar
    if (self.hideNavigationBar) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(36, 36), NO, 0.0);
        UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithCGImage:blank.CGImage] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [UIImage imageWithCGImage:blank.CGImage];
        self.navigationController.navigationBar.translucent = YES;
    }
}

#pragma mark - Actions

- (IBAction)signInWithEmail {
    if (self.hideNavigationBar) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = nil;
        self.navigationController.navigationBar.translucent = YES;
    }
    
    UIViewController *controller;
    if ([self.authUI.delegate respondsToSelector:@selector(emailEntryViewControllerForAuthUI:)]) {
        controller = [self.authUI.delegate emailEntryViewControllerForAuthUI:self.authUI];
    } else {
        controller = [[FUIEmailEntryViewController alloc] initWithAuthUI:self.authUI];
    }
    [self pushViewController:controller];
}

- (IBAction)didTapSignInButton:(FUIAuthSignInButton *)button {
    //[[IXAppManager appManager] dismissAuthenticationScreen];
    [self.authUI signInWithProviderUI:button.providerUI presentingViewController:self];
}

@end
