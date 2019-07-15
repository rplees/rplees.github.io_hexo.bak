---
title: ReactNative技术分享
date: 2016-10-28 09:20:58
---

# React-Native介绍
> LEARN ONCE, WRITE ANYWHERE: BUILD MOBILE APPS WITH REACT

### 优点:
* 复用了 React 的思想，有利于前端开发者涉足移动端。
* 能够利用 JavaScript 动态更新的特性，快速迭代。
* 相比于原生平台，开发速度更快，相比于 Hybrid 框架，性能更好。

### 缺点:
* 做不到 `Write once, Run everywhere`，也就是说开发者依然需要为 iOS 和 Android 平台提供两套不同的代码，比如参考官方文档可以发现不少组件和API都区分了 `Android` 和 `iOS` 版本。即使是共用组件，也会有平台独享的函数。
* 不能做到完全屏蔽 `iOS` 端或 `Android` 的细节，前端开发者必须对原生平台有所了解。加重了学习成本。对于移动端开发者来说，完全不具备用 `React Native` 开发的能力。
* 由于 `Objective-C` 与 `JavaScript` 之间切换存在固定的时间开销，所以性能必定不及原生。


综上，我对 React Native 的定位是：
> 利用脚本语言进行原生平台开发的一次成功尝试，降低了前端开发者入门移动端的门槛，一定业务场景下具有独特的优势，几乎不可能取代原生平台开发。

[环境搭建(官方)](http://reactnative.cn/docs/0.35/getting-started.html)

![图解](http://upload-images.jianshu.io/upload_images/1171077-75412d65af198cf5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

其次，`React Native` 能够运行起来，全靠 `Objective-C` 和 `JavaScript` 的交互。对于没有接触过 `JavaScript` 的人来说，非常有必要理解 `JavaScript` 代码如何被执行。

我们知道 `C` 系列的语言，经过编译，链接等操作后，会得到一个二进制格式的可执行文，所谓的运行程序，其实是运行这个二进制程序。

而 `JavaScript` 是一种脚本语言，它不会经过编译、链接等操作，而是在运行时才动态的进行词法、语法分析，生成抽象语法树(AST)和字节码，然后由解释器负责执行或者使用 JIT 将字节码转化为机器码再执行。整个流程由 `JavaScript` 引擎负责完成。

苹果提供了一个叫做 `JavaScript Core` 的框架，这是一个 `JavaScript` 引擎。通过下面这段代码可以简单的感受一下 Objective-C 如何调用 JavaScript 代码：

```objective-c
JSContext *context = [[JSContext alloc] init];
JSValue *jsVal = [context evaluateScript:@"21+7"];
int iVal = [jsVal toInt32];
```
# 项目基本文件介绍
> ##### 创建第一个项目并运行
```bash
react-native init FirstReactNative --verbose(能看到详细信息和进度，就是npm的安装进度)
```

- `index.android.js` android 入口
- `index.ios.js` ios 入口
- `package.json` 项目的描述配置文件(依赖,指令等,这是nodejs的部分) [double-bull-probability](https://github.com/rplees/double-bull-probability/)

# 组件
>摘自`ReactNative`

官方项目支持的组件,官方例子(UIExplorer)详细介绍组件,API的作用与使用,如果想自定义组件可以自己写也可以到github等去找别人写好的组件,比如 [react-native-gifted-listview](https://github.com/FaridSafi/react-native-gifted-listview) 下拉刷新列表

```js
get ActivityIndicatorIOS() { return require('ActivityIndicatorIOS'); },
  get ART() { return require('ReactNativeART'); },
  get DatePickerIOS() { return require('DatePickerIOS'); },
  get DrawerLayoutAndroid() { return require('DrawerLayoutAndroid'); },
  get Image() { return require('Image'); },
  get ImageEditor() { return require('ImageEditor'); },
  get ImageStore() { return require('ImageStore'); },
  get ListView() { return require('ListView'); },
  get MapView() { return require('MapView'); },
  get Modal() { return require('Modal'); },
  get Navigator() { return require('Navigator'); },
  get NavigatorIOS() { return require('NavigatorIOS'); },
  get Picker() { return require('Picker'); },
  get PickerIOS() { return require('PickerIOS'); },
  get ProgressBarAndroid() { return require('ProgressBarAndroid'); },
  get ProgressViewIOS() { return require('ProgressViewIOS'); },
  get ScrollView() { return require('ScrollView'); },
  get SegmentedControlIOS() { return require('SegmentedControlIOS'); },
  get SliderIOS() { return require('SliderIOS'); },
  get SnapshotViewIOS() { return require('SnapshotViewIOS'); },
  get Switch() { return require('Switch'); },
  get PullToRefreshViewAndroid() { return require('PullToRefreshViewAndroid'); },
  get RecyclerViewBackedScrollView() { return require('RecyclerViewBackedScrollView'); },
  get RefreshControl() { return require('RefreshControl'); },
  get StatusBar() { return require('StatusBar'); },
  get SwitchAndroid() { return require('SwitchAndroid'); },
  get SwitchIOS() { return require('SwitchIOS'); },
  get TabBarIOS() { return require('TabBarIOS'); },
  get Text() { return require('Text'); },
  get TextInput() { return require('TextInput'); },
  get ToastAndroid() { return require('ToastAndroid'); },
  get ToolbarAndroid() { return require('ToolbarAndroid'); },
  get Touchable() { return require('Touchable'); },
  get TouchableHighlight() { return require('TouchableHighlight'); },
  get TouchableNativeFeedback() { return require('TouchableNativeFeedback'); },
  get TouchableOpacity() { return require('TouchableOpacity'); },
  get TouchableWithoutFeedback() { return require('TouchableWithoutFeedback'); },
  get View() { return require('View'); },
  get ViewPagerAndroid() { return require('ViewPagerAndroid'); },
  get WebView() { return require('WebView'); },
```

# 样式
> 弹性盒(Flexbox)和样式
> 我们在React Native中使用flexbox规则来指定某个组件的子元素的布局。Flexbox可以在不同屏幕尺寸上提供一致的布局结构。
一般来说，使用flexDirection、alignItems和 justifyContent三个样式属性就已经能满足大多数布局需求。

[使用Flexbox布局](http://reactnative.cn/docs/0.35/layout-with-flexbox.html#content)

# 自定义方法
> 想要创建一个iOS模块，只需要创建一个接口，实现RCTBridgeModule协议，然后把你想在Javascript中使用的任何方法用RCT_EXPORT_METHOD包装。最后，再用RCT_EXPORT_MODULE导出整个模块即可。

以Xcode为例, 在Utils.h 定义俩个方法:
- clearCookies(callback)
- appInfo(callback)

```objective-c
#import "Utils.h"

static NSString * const kAppId = @"1079873993";

@implementation Utils

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(clearCookies:(RCTResponseSenderBlock)callback) {
  NSHTTPCookieStorage *cookieStore = [NSHTTPCookieStorage sharedHTTPCookieStorage];
  for (NSHTTPCookie *cookie in [cookieStore cookies]) {
    [cookieStore deleteCookie:cookie];
  }

  callback(@[[NSNull null]]);
}

RCT_EXPORT_METHOD(appInfo:(RCTResponseSenderBlock)callback) {
  NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];

  callback(@[
             @{@"appVersion": appVersion
               }
             ]);
}

@end
```
JS中使用
```js
const React = require('react-native');

var {
  NativeModules: {//导入自定义的原生模块
      Utils,
  }
} = React;

var Uitls = {
  clearCookies(cb) {
    Utils.clearCookies(() => {});
  },

  appInfo(cb) {
    Utils.appInfo((info) => {
      cb && cb(info);
    });
  }
};

module.exports = Uitls;
```

# 调试
> 模拟器 `Command ⌘` + `D` 弹出菜单有js调试选项,打开一个chrome浏览器,在控制台可以看到执行的js及日志输出
> 调试模式下当js修改了,可以reload不需要再次编译

![debugging](http://reactnative.cn/static/img/chrome_breakpoint.png)

React Native lets you build your app faster. Instead of recompiling, you can reload your app instantly. With hot reloading, you can even run new code while retaining your application state. Give it a try - it's a magical experience.

![reload](https://media.giphy.com/media/13WZniThXy0hSE/giphy.gif)

# 发布打包
##iOS
> 如果是用pod引入包的话,需要先编译
> open the project in ios dir `cd ios`
> `pod install`

### Release mode

1. edit xcode project `OSCGit`'s scheme to `release` mode
2. bundle the JS resources, in project root dir (如果第一次运行没生存index.ios.jsbundle,再运行一次)
  ```sh
  #将所有的js代码都打包到一个文件index.ios.jsbundle去
 react-native bundle --entry-file index.ios.js --bundle-output ./ios/bundle/index.ios.jsbundle --platform ios --assets-dest ./ios/bundle --dev false --sourcemap-output ./ios/bundle/source.map --verbose
  ```
3. AppDelegate.m 注释 ` jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=true"];` 取消 `jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"index.ios" withExtension:@"jsbundle"];`的注释,发布版本的index.ios.jsbundle都打包到项目里去了
4. xcode run!

### Debug mode

Edit xcode project `OSCGit` edit scheme to `debug` mode

Xcode run!

## Android
### Device
    - sh ./build_android.sh
### Emulator
    - Just run the project
### Debug mode
    - react-native run-android
# code-push热更新(可选)
### 安装
    ```bash
    cnpm install -g code-push-cli --verbose
    code-push register (会弹出网页,按照步骤安装)
    code-push access-key ls

    code-push app add RN_OSCGit
    code-push deployment ls RN_OSCGit
    code-push release-react RN_OSCGit ios --entryFile ./ios/bundle/index.ios.jsbundle

    #android
    code-push app add RN_OSCGit_android
    code-push deployment ls RN_OSCGit_android
    code-push release-react RN_OSCGit_android android
    ```

### Check app status

	code-push deployment ls RN_OSCGit

	code-push deployment ls RN_OSCGit_android

### Publish update

	code-push release-react RN_OSCGit ios --entryFile ./ios/bundle/index.ios.jsbundle
	code-push release-react RN_OSCGit_android android
