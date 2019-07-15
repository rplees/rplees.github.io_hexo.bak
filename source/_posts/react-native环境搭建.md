---
title: ReactNative环境搭建
date: 2016-01-14 11:20:58
---
## React Native环境搭建

### 前期准备环境

#### [brew](http://brew.sh/) 安装

brew 在官方网站对brew的用法进行了详细的描述,是一款更方便的下载软件库的软件，类似于centos的yum。
安装方法：在Mac中打开Termal:  输入命令

```bash
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
```

##### 使用方法：

```bash
brew install wget
brew uninstall wget
brew search /wge*/
```

#### [node.js](https://nodejs.org/en/) 安装

###### 以下是官方定义:
```bash
Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine. Node.js uses an event-driven, non-blocking I/O model that makes it lightweight and efficient. Node.js' package ecosystem, npm, is the largest ecosystem of open source libraries in the world.
```
```bash
nmp 是 node的一个三方管理工具，相当于 Ruby中的RubyGems，iOS中的 CocoaPods，Java中的 Gradle/Maven，基本上，它使您能够轻松下载和管理你的项目需要的任何依赖库。
```

###### 安装方法:
---
  - 官方下载安装
  - 通过brew安装 
  ```bash 
  brew install node
  ```

#### react-navtive等的安装：
##### 接下来安装[watchman](https://facebook.github.io/watchman/)

```bash
brew install watchman
```

##### 接下来安装react-native-cli(如果权限不足需要sudo)
```bash
npm install -g react-native-cli 
```

##### 创建第一个项目并运行
```bash
react-native init FirstReactNative --verbose(能看到详细信息和进度，就是npm的安装进度)
```
##### *成功后控制打印*
```bash
This will walk you through creating a new React Native project in /Users/rplees/work/git/react-native/FirstReactNative
Installing react-native package from npm...
Setting up new React Native app in /Users/rplees/work/git/react-native/FirstReactNative
To run your app on iOS:
   Open /Users/rplees/work/git/react-native/FirstReactNative/ios/FirstReactNative.xcodeproj in Xcode
   Hit the Run button
To run your app on Android:
   Have an Android emulator running (quickest way to get started), or a device connected
   cd /Users/rplees/work/git/react-native/FirstReactNative
   react-native run-android
```
##### 运行 ios
```bash
Now open any example (the .xcodeproj file in each of the Examples subdirectories) and hit Run in Xcode.(需要打开xcode编译项目再运行)
```

#### 运行 android  *需要安装* [Android SDK](https://github.com/facebook/react-native/blob/master/ReactAndroid/README.md#prerequisites)
```bash
react-native run-android
```
###### 运行watchman的时候抛错
```bash
192:FirstReactNative rplees$ sudo watchman
Password:
dyld: Library not loaded: /usr/local/lib/libpcre.1.dylib
  Referenced from: /usr/local/bin/watchman
  Reason: image not found
192:FirstReactNative rplees$ npm uninstall watchman
192:FirstReactNative rplees$ watchman
dyld: Library not loaded: /usr/local/lib/libpcre.1.dylib
  Referenced from: /usr/local/bin/watchman
  Reason: image not found
```
##### 经过一番搜索，发现是pcre找不到，通过如下命令即可修复：
```bash
brew uninstall pcre && brew install pcre 
```

###### 运行npm start的时候抛错
```bash
TypeError: Cannot read property 'root' of null
这个问题困扰很久，后来才发现是watchman版本的问题
brew update && brew upgrade watchman 就解决了
```



