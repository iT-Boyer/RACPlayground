#  说明
### 教程
[状态』驱动的世界：ReactiveCocoa](https://draveness.me/racsignal/)  
[ReactiveCocoa入门教程：第一部分](http://www.cocoachina.com/articles/10994)  
[ReactiveCocoa入门教程：第二部分](https://developer.aliyun.com/article/33610)  

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
