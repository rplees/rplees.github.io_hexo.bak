---
title: SublimeText 3 搭建 React.js 开发环境
date: 2016-02-17 11:20:58
tags: [sublimetext,react,搭建]
---
## [转载来源](http://www.cnblogs.com/terrylin/p/4942332.html)
## Sublime Text 3 搭建 React.js 开发环境
Sublime有很强的自定义功能，插件库很庞大，针对新语言插件更新很快，配合使用可以快速搭建适配语言的开发环境。

## [babel-sublime](http://www.cnblogs.com/terrylin/p/4942332.html)

支持ES6， React.js, jsx代码高亮，对 JavaScript, jQuery 也有很好的扩展。关于 babel 的更多介绍可以看这里：[为什么说Babel将推动JavaScript的发展](http://www.infoq.com/cn/news/2015/05/ES6-TypeScript)

安装

- PC：Ctrl+shift+p

- Mac：Cmd+shift+p
打开面板输入babel安装

配置

- 打开.js, .jsx 后缀的文件;

- 打开菜单view， Syntax -> Open all with current extension as... -> Babel -> JavaScript (Babel)，选择babel为默认 javascript 打开syntax

## [sublimeLinter-jsxhint](https://packagecontrol.io/packages/SublimeLinter-jsxhint)

JSX 代码审查，实时提示语法错误, 帮助快速定位错误点.
![代码提示](http://segmentfault.com/img/bVoMHA "代码提示 Title")
安装

- PC上ctrl+shift+p（MacCmd+shift+p）打开面板输入sublimeLinter-jsx安装(依赖于 sublimeLinter)

- 安装 node.js

- 安装 [jsxhint](https://github.com/STRML/JSXHint/)
```bash
npm install -g jsxhint
```
## 修改 [Emmet](http://docs.emmet.io/) 兼容jsx 文件

emmet 作为前端开发必备插件之一非常方便快捷，通过修改默认的 sublime就可以在 jsx 文件中快速通过 emmet 编写自定义组件。
![emmet](http://segmentfault.com/img/bVoMHB "emmet Title")
安装

- PC上ctrl+shift+p（MacCmd+shift+p）打开面板输入emmet安装

使用方法

打开 preferences -> Key bindings - Users，把下面代码复制到[]内部。

    {
      "keys": [
        "super+e"
      ],
      "args": {
        "action": "expand_abbreviation"
      },
      "command": "run_emmet_action",
      "context": [{
        "key": "emmet_action_enabled.expand_abbreviation"
      }]
    },
    {
      "keys": ["tab"],
      "command": "expand_abbreviation_by_tab",
      "context": [{
        "operand": "source.js",
        "operator": "equal",
        "match_all": true,
        "key": "selector"
      }, {
        "key": "preceding_text",
        "operator": "regex_contains",
        "operand": "(\\b(a\\b|div|span|p\\b|button)(\\.\\w*|>\\w*)?([^}]*?}$)?)",
        "match_all": true
      }, {
        "key": "selection_empty",
        "operator": "equal",
        "operand": true,
        "match_all": true
      }]
    }    
使用super+e触发 emmet；正则判断用 a，div，span，p，button标签默认tab 触发；默认 class 修改为 className。

注：

- supre+e 在 PC 上指的是win+e（pc 建议修改为emmet 默认按键 ctrl+e）,在 mac 上指的是cmd+e

- 以上规则来源于[StackOverflow](http://stackoverflow.com/questions/26089802/in-sublime-text-3-how-do-you-enable-emmet-for-jsx-files)，正则小有修改

## [JsFormat](https://github.com/jdc0589/JsFormat) 格式化 js 代码

jsformat 是 sublime 上 js 格式化比较好用的插件之一，通过修改它的e4x 属性可以使它支持 jsx。

安装

- PC上ctrl+shift+p（MacCmd+shift+p）打开面板输入JsFormat安装.
使用

打开preferences -> Package Settings -> JsFormat -> Setting - Users,输入以下代码：
```bash
{
  "e4x": true,
  // jsformat options
  "format_on_save": true,
}
```
即可保存时自动格式化，并支持 jsx 类型文件.

## 编译 jsx

- 使用[babel-sublime](https://packagecontrol.io/packages/Babel)
- 带有编译 jsx 的命令 babel build。使用 babel 编译 jsx 也由 React 项目官方引用。该命令依赖于 node 包 [babel](https://babeljs.io/)。babel 同时也支持 ES6的新语法经过编译在浏览器中运用。
 ```bash
 npm install -g babel
 ```
在 sublime 中使用ctrl+shift+p打开面板输入babel transform自动编译成 react.js 文件

- 使用自动化构建工具（gulp|grunt 等）
以 [gulp](http://gulpjs.com/) 为例(依赖 [gulp](http://gulpjs.com/),需提前安装)：
 ```bash
 npm install gulp-babel
```

```bash
/**
* babel
*/
var gulp = require('gulp'),
  babel = require('gulp-babel');
gulp.task('babel', function() {
  return gulp.src('./src/**/*.jsx')
    .pipe(babel())
    .pipe(gulp.dest('./dist'));
});
```
- 在命令行中输入 gulp babel 运行
配合 BrowserSync 使用可以实时监测改动并同步刷新多平台上得浏览器。
```bash
npm install gulp-babel gulp-plumber gulp-notify gulp-cached browser-sync run-sequence
```

```bash
/**
*  babel
*/
var gulp = require('gulp'),
  babel = require('gulp-babel'),
  bs = require('browser-sync').create(),
  reload = bs.reload,
  runSequence = require('run-sequence').use(gulp),
  src = 'src', //源目录路径
  dist = 'dist'; //输出路径
gulp.task('babel', function() {
  var onError = function(err) {
    notify.onError({
      title: "Gulp",
      subtitle: "Failure!",
      message: "Error: <%= error.message %>",
      sound: "Beep"
    })(err);
  };

  return gulp.src(src + '/**/*.jsx')
    .pipe(cached('react')) //把所有东西放入缓存中，每次只编译修改过的文件
    .pipe(plumber({ //发生错误时不会中断 gulp 的流程，同时触发 notify 消息提示
      errorHandler: onError
    }))
    .pipe(babel())
    .pipe(gulp.dest(dist));
});

// Start the server
gulp.task('bs', function() {
  var files;

  files = [
    src + '/**/*.+(html|php|js|css|png|jpg|svg|gif)'
  ];

  bs.init(files, {
  server: {
    baseDir: src,
  }
  });
});

gulp.task('server', ['babel','bs'], function() {
  gulp.watch(src + '/**/*.jsx', function() {
    runSequence('babel', reload);
    });
  })```
在命令行中输入 gulp server 运行。

或者使用 sublime 自带的 build 工具，选择Tools -> Build System -> New Build System
输入:
```
{
    "shell_cmd": "gulp server --cwd $file_path"
}```
并保存为 gulpBabel.sublime-build(名称随意，保持.sublime-build后缀名)，存放到Packages - Users文件夹里面，在 sublime 中使用ctrl+shift+b（或Tools -> Build With ..）打开 build 面板，选择刚刚输入的名称，在这里是gulpBabel运行。
