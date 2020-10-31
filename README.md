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
