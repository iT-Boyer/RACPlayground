//
//  RWViewController.m
//  RWReactivePlayground
//
//  Created by Colin Eberhardt on 18/12/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "RWViewController.h"
#import "RWDummySignInService.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RWViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UILabel *signInFailureText;

@property (nonatomic) BOOL passwordIsValid;
@property (nonatomic) BOOL usernameIsValid;
@property (strong, nonatomic) RWDummySignInService *signInService;

@end

@implementation RWViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self updateUIState];
  
  self.signInService = [RWDummySignInService new];
  
  // handle text changes for both text fields
  [self.usernameTextField addTarget:self action:@selector(usernameTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
  [self.passwordTextField addTarget:self action:@selector(passwordTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
  
  // initially hide the failure message
  self.signInFailureText.hidden = YES;
    
    //RAC
    //监听输入的文字长度大于3的信号对象
    RACSignal *userSignal = self.usernameTextField.rac_textSignal;
    RACSignal *filterUserSigal = [userSignal filter:^BOOL(id value) {
        NSString *text = value;
        return  text.length > 3;
    }];
    [filterUserSigal subscribeNext:^(NSString *x) {
        NSLog(@"%@",x);
    }] ;
    
    // 事件：log输出变成了文本的长度而不是内容
    [[[self.usernameTextField.rac_textSignal map:^id(NSString *value) {
                return @(value.length);
        }] filter:^BOOL(NSNumber *value) {
            return [value integerValue] > 3;
        }] subscribeNext:^(id x) {
            NSLog(@"%@",x);
    }];
    
    //MARK:属性信号
    RACSignal *userValid = [self.usernameTextField.rac_textSignal map:^id(NSString *text) {
        return @([self isValidUsername:text]);
    }];
    RACSignal *userValidColor = [userValid map:^id(NSNumber *isValid) {
        return isValid.boolValue?[UIColor clearColor]:[UIColor yellowColor];
    }];
    RAC(self.usernameTextField,backgroundColor) = userValidColor;
    //MARK:颜色属性信号
    RACSignal *pwdValid = [self.passwordTextField.rac_textSignal map:^id(NSString *text) {
        return @([self isValidPassword:text]);
    }];
    RACSignal *pwdValidColor = [pwdValid map:^id(NSNumber *isValid) {
        return isValid.boolValue?[UIColor clearColor]:[UIColor yellowColor];
    }];
    RAC(self.passwordTextField,backgroundColor) = pwdValidColor;
    
    //聚合信号，更改登录按钮状态
    RACSignal *signUpdateActiveSignal = [RACSignal combineLatest:@[userValid,pwdValid] reduce:^id(NSNumber *userValid,NSNumber *pwdValid){
        return @(userValid.boolValue && pwdValid.boolValue);
    }];
    [signUpdateActiveSignal subscribeNext:^(NSNumber *active) {
        self.signInButton.enabled = active.boolValue;
    }];
//
    //响应式登录:创建信号 [self signSignal];
    [[[self.signInButton rac_signalForControlEvents:UIControlEventTouchUpInside]
      map:^id(id value) {
        return [self signSignal];
    }] subscribeNext:^(id x) {
        NSLog(@"Sign in result: %@", x);
    }];
    
    //信号中的信号
    [[[self.signInButton
       rac_signalForControlEvents:UIControlEventTouchUpInside]
      flattenMap:^id(id x){
          return[self signSignal];
      }]
     subscribeNext:^(NSNumber*signedIn){
         BOOL success =[signedIn boolValue];
         self.signInFailureText.hidden = success;
         if(success){
             [self performSegueWithIdentifier:@"signInSuccess" sender:self];
         }
     }];
    
    //添加附加操作（Adding side-effects）
    [[[[self.signInButton
        rac_signalForControlEvents:UIControlEventTouchUpInside]
       doNext:^(id x){
           self.signInButton.enabled = NO;
           self.signInFailureText.hidden = YES;
       }]
      flattenMap:^id(id x){
          return[self signSignal];
      }]
     subscribeNext:^(NSNumber*signedIn){
         self.signInButton.enabled = YES;
         BOOL success =[signedIn boolValue];
         self.signInFailureText.hidden = success;
         if(success){
             [self performSegueWithIdentifier:@"signInSuccess" sender:self];
         }
     }];
}


-(RACSignal *)signSignal
{
    RACSignal *sign = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.signInService signInWithUsername:self.usernameTextField.text password:self.passwordTextField.text complete:^(BOOL success) {
            [subscriber sendNext:@(success)];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
    return sign;
}

- (BOOL)isValidUsername:(NSString *)username {
  return username.length > 3;
}

- (BOOL)isValidPassword:(NSString *)password {
  return password.length > 3;
}

- (IBAction)signInButtonTouched:(id)sender {
  // disable all UI controls
  self.signInButton.enabled = NO;
  self.signInFailureText.hidden = YES;
  
  // sign in
  [self.signInService signInWithUsername:self.usernameTextField.text
                            password:self.passwordTextField.text
                            complete:^(BOOL success) {
                              self.signInButton.enabled = YES;
                              self.signInFailureText.hidden = success;
                              if (success) {
                                [self performSegueWithIdentifier:@"signInSuccess" sender:self];
                              }
                            }];
}


// updates the enabled state and style of the text fields based on whether the current username
// and password combo is valid
- (void)updateUIState {
//  self.usernameTextField.backgroundColor = self.usernameIsValid ? [UIColor clearColor] : [UIColor yellowColor];
//  self.passwordTextField.backgroundColor = self.passwordIsValid ? [UIColor clearColor] : [UIColor yellowColor];
  self.signInButton.enabled = self.usernameIsValid && self.passwordIsValid;
}

- (void)usernameTextFieldChanged {
  self.usernameIsValid = [self isValidUsername:self.usernameTextField.text];
  [self updateUIState];
}

- (void)passwordTextFieldChanged {
  self.passwordIsValid = [self isValidPassword:self.passwordTextField.text];
  [self updateUIState];
}

#pragma mark - UIAction
-(IBAction)viperVC:(id)sender
{
    //通过路由进入home
//   XF_Present_URLComponent_Fast(@"rac://home")
}

-(IBAction)backAction:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
