#  说明
### 教程
[状态』驱动的世界：ReactiveCocoa](https://draveness.me/racsignal/)  
[ReactiveCocoa入门教程：第一部分](http://www.cocoachina.com/articles/10994)  
[ReactiveCocoa入门教程：第二部分](https://developer.aliyun.com/article/33610)  

### RAC原理
作为一个iOS开发者，你写的每一行代码几乎都是在相应某个事件，例如按钮的点击，收到网络消息，属性的变化（通过KVO）或者用户位置的变化（通过CoreLocation）。但是这些事件都用不同的方式来处理，比如action、delegate、KVO、callback等。ReactiveCocoa为事件定义了一个标准接口，从而可以使用一些基本工具来更容易的连接、过滤和组合。

1. ReactiveCocoa结合了几种编程风格：
函数式编程（Functional Programming）：使用高阶函数，例如函数用其他函数作为参数。  
响应式编程（Reactive Programming）：关注于数据流和变化传播。  
所以，你可能听说过ReactiveCocoa被描述为函数响应式编程（FRP）框架。  

2. 信号
ReactiveCocoa signal（RACSignal）发送事件流给它的subscriber。  
目前总共有三种类型的事件：next、error、completed。一个signal在因error终止或者完成前，可以发送任意数量的next事件。

RACSignal的每个操作都会返回一个RACsignal，这在术语上叫做连贯接口（fluent interface）。这个功能可以让你直接构建管道，而不用每一步都使用本地变量。

RACSignal有很多方法可以来订阅不同的事件类型。每个方法都需要至少一个block，当事件发生时就会执行block中的逻辑。在上面的例子中可以看到每次next事件发生时，subscribeNext:方法提供的block都会执行。

3. UIKit

ReactiveCocoa框架使用category来为很多基本UIKit控件添加signal。这样你就能给控件添加订阅了，text field的rac_textSignal就是这么来的。


#### 类型转换
1. 信号中的block参数的类型，一般是明确的。 
将id隐式转换为NSString，这看起来不是很好看。幸运的是，传入block的值肯定是个NSString，所以你可以直接修改参数类型，把代码更新成下面的这样的：
``` objc
[[self.usernameTextField.rac_textSignal
  filter:^BOOL(NSString*text){
    return text.length > 3;
  }]
  subscribeNext:^(id x){
    NSLog(@"%@", x);
  }];
```
2. RAC宏 ： 绑定UI控件的颜色属性信号
RAC帮助把信号的输出转为UIKit的属性，例如：输入框的backgroundColor属性上。
RAC宏允许直接把信号的输出应用到对象的属性上。
RAC宏有两个参数，第一个是需要设置属性值的对象，第二个是属性名。每次信号产生一个next事件，传递过来的值都会应用到该属性上。
如下代码：两个文本信号，经过一个map转为表示是否有效的布尔值，再经过一个map转为UIColor，而这个UIColor已经和输入框的背景颜色绑定了。
``` objc
//MARK:属性信号
RACSignal *userValid = [self.usernameTextField.rac_textSignal map:^id(NSString *text) {
    return @([self isValidUsername:text]);
}];
RACSignal *userValidColor = [userValid map:^id(NSNumber *isValid) {
    return isValid.boolValue?[UIColor orangeColor]:[UIColor yellowColor];
}];
RAC(self.usernameTextField,backgroundColor) = userValidColor;
//MARK:颜色属性信号
RACSignal *pwdValid = [self.passwordTextField.rac_textSignal map:^id(NSString *text) {
    return @([self isValidPassword:text]);
}];
RACSignal *pwdValidColor = [pwdValid map:^id(NSNumber *isValid) {
    return isValid.boolValue?[UIColor orangeColor]:[UIColor yellowColor];
}];
RAC(self.passwordTextField,backgroundColor) = pwdValidColor;
```
3. 聚合信号
目前在应用中，登录按钮只有当用户名和密码输入框的输入都有效时才工作。现在要把这里改成响应式的。
如下代码中，使用combineLatest:reduce:方法把validUsernameSignal和validPasswordSignal产生的最新的值聚合在一起，并生成一个新的信号。每次这两个源信号的任何一个产生新值时，reduce block都会执行，block的返回值会发给下一个信号。
``` objc
RACSignal *signUpActiveSignal =
  [RACSignal combineLatest:@[validUsernameSignal, validPasswordSignal]
                    reduce:^id(NSNumber*usernameValid, NSNumber *passwordValid){
                      return @([usernameValid boolValue]&&[passwordValid boolValue]);
          }];
```
注意：RACsignal的这个方法可以聚合任意数量的信号，reduce block的参数和每个源信号相关。ReactiveCocoa有一个工具类RACBlockTrampoline，它在内部处理reduce block的可变参数。实际上在ReactiveCocoa的实现中有很多隐藏的技巧，值得你去看看。

上图展示了一些重要的概念，你可以使用ReactiveCocoa来完成一些重量级的任务。  
1. 分割——信号可以有很多subscriber，也就是作为很多后续步骤的源。注意上图中那个用来表示用户名和密码有效性的布尔信号，它被分割成多个，用于不同的地方。  
2. 聚合——多个信号可以聚合成一个新的信号，在上面的例子中，两个布尔信号聚合成了一个。实际上你可以聚合并产生任何类型的信号。  
这些改动的结果就是，代码中没有用来表示两个输入框有效状态的私有属性了。这就是用响应式编程的一个关键区别，你不需要使用实例变量来追踪瞬时状态。  

4. 响应式登录:点击事件的信号
在storyboard中，登录按钮的Touch Up Inside事件和RWViewController.m中的signInButtonTouched方法是绑定的。下面会用响应的方法替换，所以首先要做的就是断开当前的storyboard action。  
你已经知道了ReactiveCocoa框架是如何给基本UIKit控件添加属性和方法的了。   
目前你已经使用了rac_textSignal，它会在文本发生变化时产生信号。   
为了处理按钮的事件，现在需要用到ReactiveCocoa为UIKit添加的另一个方法，rac_signalForControlEvents。  
``` objc
[[self.signInButton
   rac_signalForControlEvents:UIControlEventTouchUpInside]
   subscribeNext:^(id x) {
     NSLog(@"button clicked");
   }];
```
5. 创建信号：如何使用这些不是用信号表示的API呢？
把已有的异步API用信号的方式，创建了一个信号，使用用户名和密码登录：

``` objc
- (RACSignal *)signInSignal {
return [RACSignal createSignal:^RACDisposable *(id subscriber){
   [self.signInService 
     signInWithUsername:self.usernameTextField.text
               password:self.passwordTextField.text
               complete:^(BOOL success){
                    [subscriber sendNext:@(success)];
                    [subscriber sendCompleted];
     }];
   return nil;
}];
}
```
上面的代码使用RACSignal的createSignal:方法来创建信号。方法的入参是一个block，这个block描述了这个信号。当这个信号有subscriber时，block里的代码就会执行。  
block的入参是一个subscriber实例，它遵循RACSubscriber协议，协议里有一些方法来产生事件，你可以发送任意数量的next事件，或者用error\complete事件来终止。本例中，信号发送了一个next事件来表示登录是否成功，随后是一个complete事件。  

这个block的返回值是一个RACDisposable对象，它允许你在一个订阅被取消时执行一些清理工作。当前的信号不需要执行清理操作，所以返回nil就可以了。  
可以看到，把一个异步API用信号封装是多简单！  
6. 添加附加操作（Adding side-effects）

``` objc
[[[[self.signInButton
   rac_signalForControlEvents:UIControlEventTouchUpInside]
   doNext:^(id x){
     self.signInButton.enabled =NO;
     self.signInFailureText.hidden =YES;
   }]
   flattenMap:^id(id x){
     return[self signInSignal];
   }]
   subscribeNext:^(NSNumber*signedIn){
     self.signInButton.enabled =YES;
     BOOL success =[signedIn boolValue];
     self.signInFailureText.hidden = success;
     if(success){
       [self performSegueWithIdentifier:@"signInSuccess" sender:self];
     }
   }];
```
你可以看到doNext:是直接跟在按钮点击事件的后面。而且doNext: block并没有返回值。因为它是附加操作，并不改变事件本身。

上面的doNext: block把按钮置为不可点击，隐藏登录失败提示。然后在subscribeNext: block里重新把按钮置为可点击，并根据登录结果来决定是否显示失败提示。

#### 什么是事件
事件可以包括任何事情。
以map为例：
map操作之后的步骤收到的都是NSNumber实例。你可以使用map操作来把接收的数据转换成想要的类型，只要它是个对象。
``` objc
[[[self.usernameTextField.rac_textSignal
  map:^id(NSString*text){
    return @(text.length);
  }]
  filter:^BOOL(NSNumber*length){
    return[length integerValue] > 3;
  }]
  subscribeNext:^(id x){
    NSLog(@"%@", x);
  }];
```
新加的map操作通过block改变了事件的数据。map从上一个next事件接收数据，通过执行block把返回值传给下一个next事件。在上面的代码中，map以NSString为输入，取字符串的长度，返回一个NSNumber。
现在就来使用这个新的信号。
``` objc
[[[self.signInButton
   rac_signalForControlEvents:UIControlEventTouchUpInside]
   map:^id(id x){
     return[self signInSignal];
   }]
   subscribeNext:^(id x){
     NSLog(@"Sign in result: %@", x);
   }];
```
上面的代码使用map方法，把按钮点击信号转换成了登录信号。subscriber输出log。
当点击按钮时，rac_signalForControlEvents发送了一个next事件（事件的data是UIButton）。map操作创建并返回了登录信号，这意味着后续步骤都会收到一个RACSignal。这就是你在subscribeNext:这步看到的。

上面问题的解决方法，有时候叫做信号中的信号，换句话说就是一个外部信号里面还有一个内部信号。你可以在外部信号的subscribeNext:block里订阅内部信号。不过这样嵌套太混乱啦，还好ReactiveCocoa已经解决了这个问题。



### 通过demo希望得到什么
1. button事件的使用
2. 输入框代理的使用
3. 异步请求网络的使用
4. UI更新数据的使用

### Xcode 11 新建工程中的SceneDelegate
[原文](https://www.jianshu.com/p/20df9eb8c913)
Xcode 11 建新工程默认会创建通过 UIScene 管理多个 UIWindow 的应用，工程中除了 AppDelegate 外还会有一个 SceneDelegate，这是为了实现iPadOS支持多窗口的结果。AppDelegate.h不再有window属性，window属性被定义在了SceneDelegate.h中，AppDelegate中有新增的关于scene的代理方法，SceneDelegate中也有相应的代理方法。因此，当我们用Xcode11针对不同版本的iOS开发应用时，就要做一些适配。

### 导入ReactiveCocoa
#### Objective-C
`ReactiveCocoa 2.5`版本以后改用了Swift，所以Objective-C项目需要导入2.5版本
CocoaPods集成：
```
platform :ios, '8.0'

target 'YouProjectName' do

use_frameworks!
pod 'ReactiveCocoa', '~> 2.5'

end
```
PS:新版本的CocoaPods需要加入
```
target 'YouProjectName' do 
... 
end
```
这句话来限定项目，否则导入失败。

#### Swift

Swift项目导入2.5后的版本
```
platform :ios, '8.0'

target 'YouProjectName' do

use_frameworks!
pod 'ReactiveCocoa'

end
```
### 使用
使用时在全局头文件导入头文件即可

PrefixHeader.pch

#ifndef PrefixHeader_pch
#define PrefixHeader_pch

#import <ReactiveCocoa/ReactiveCocoa.h>

#endif
