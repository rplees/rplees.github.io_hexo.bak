---
title: ReactJS技术分享
date: 2016-10-17 09:20:58
---

# React的定义与原理
React是一个用于构建用户界面的JavaScript库，而不是一个MVC框架，但可以使用React作为MVC架构的View层轻易的在已有项目中使用。

> 官方定义 A JAVASCRIPT LIBRARY FOR BUILDING USER INTERFACES(一个用于构建用户界面的JavaScript库)

# 为什么用React
> 高效DOM渲染

以前没有ajax技术的时候，web页面从服务端整体render出html输出到浏览器端进行渲染，同样的，用户的一个改变页面的操作也会刷新整个页面来完成。直到有了ajax出现，实现页面局部刷新，带来的高效和分离让web开发者们惊叹不已。但随之而来的问题是，复杂的用户交互及展现需要通过大量的DOM操作来完成，这让页面的性能以及开发的效率又出现了新的瓶颈。

时至今日，谈到前端性能优化，减少DOM元素、减少reflow和repaint、编码过程中尽量减少DOM的查询等手段是大家耳熟能详的。而页面任何UI的变化都是通过整体刷新来完成的。幸运的是，React通过自己实现的DOM Diff算法，计算出虚拟页面当前版本和新版本之间的差异，最小化重绘，避免不必要的DOM操作，解决了这两个公认的前端性能瓶颈，实现高效DOM渲染。

- 我们知道，频繁的操作DOM所带来的性能消耗是很大的，而React之所以快，是因为它不直接操作DOM，而是引进虚拟DOM的实现来解决这个问题
- 对于页面的更新，React通过自己实现的[DOM Diff](http://segmentfault.com/a/1190000000606216)算法来进行差异对比、差异更新，反映到页面上就是只重绘了更新的部分，从而提高渲染效率。

对于React的性能方面
- React 从来没有说过 “React 比原生操作 DOM 快”。React 的基本思维模式是每次有变动就整个重新渲染整个应用。如果没有 Virtual DOM，简单来想就是直接重置 innerHTML。
- 在比较性能的时候，要分清楚初始渲染、小量数据更新、大量数据更新这些不同的场合。
- 不要天真地以为 Virtual DOM 就是快，diff 不是免费的，Virtual DOM 真正的价值从来都不是性能，而是它
  - 1) 为函数式的 UI 编程方式打开了大门；
  - 2) 可以渲染到 DOM 以外的其他场景，如backend、native。

> 组件化

在业务开发中，遇到公共的模板部分，我们不得不将模板和规定的数据格式耦合在一起来实现组件。而在React中，我们可以使用JSX语法来封装组件，将组件的结构、数据逻辑甚至样式都聚合在一起，更加简单、明了、直观的定义组件。

有了组件化的实现，我们可以很直观的将一个复杂的页面分割成若干个独立组件，再将这些独立组件组合完成一个复杂的页面。这样既减少了逻辑复杂度，又实现了代码的重用。

React认为一个组件应该具有如下的特征：

- 可组合：一个组件可以和其他的组件一起使用或者可以直接嵌套在另一个组件内部，通过这样的组合方式，一个复杂的UI组件可以分拆成若干个简单的UI组件
- 可重用：每个组件都是具有独立功能的，它可以被使用在多个UI场景
- 可维护：每个小的组件仅仅包含自身的逻辑，更容易被理解和维护

> 单向数据流

在React中，数据的流向是从父节点到子节点的单向流动，这样可以使组件简单并且容易把握，因为子节点是无状态的，只需要从父节点获取props渲染即可。这样带来的收益是，顶层组件的某个prop改变了，React就会向下递归遍历整棵组件树，重新渲染所有使用到了这个属性的组件。

单向数据流带来的几个重要的好处是：

- 相比之前的资源重组实现的组件，单向数据流可以很好的完成组件间的数据通信，否则的话，我们需要写一个事件机制来处理这个事情。
- 大家可能会问，这所倡导的单向流动，那相对MVC或是MVVM框架的双向数据绑定简直是弱爆了。那么这里需要理解的是，这里的单向，是循环流动的单向，数据是持续更新的。双向数据绑定是优秀便捷的实现，这个需要用实现的成本和业务场景来考量二者了。
- 对于单向数据流目前已经有很好的类库实现了，如flux reflux redux等。
- React组件被认为自己是一个有限状态机。与用户交互，改变自己的状态（state）。算法根据这些状态，render算法现计算出合适的数据集呈现给用户。这样做的好处是设计范式高度一致

#  挑战
> React是数据驱动式的UI component体系，是一个开放的数据依赖式，非自闭OO对象。它会有以下挑战

- render方法可能很大，component显示逻辑是一次性在render里实现的。这里往往有两部分逻辑实现，初次数据绑定，与用户交互之后的算法。
- render出一个ReactElement树，但这个树中的一些组件、UI元素因为计算被前移了，这会导致这个树看起来不太完整，进而不太直观。
- 虽然可以分解成小的component，构建大的Component可能是个挑战，因为所有逻辑都依赖于外部数据，而外部数据相对不稳定，组件失去了自我边界的保护，非自闭。
- 当交互复杂，组件的state也会越来越大，render全局算法会越来越难写。
- 把子组件的行为传上来也是一件不显化的事，往往需要把父组件的一个函数作为回调传给子组件。
- 大组件往往有多个Page，这几个Page如何交换数据是个很大的挑战

# 版本更新及接口说明

### 目前下载的最新版本包含一下文件,**原来的react.js被一分为三**
```
react.js
react-dom.js
react-dom-server.js
react-with-addons.js
```

### 之前的react.js现在已经被分拆为react.js react-dom.js react-dom-server.js三个文件了。
- `react.js` react包提供了一系列的API，以下列举几个常用的：
  ```
  // 使用ES6的时候可以用这个API来定义一个组件
React.Component
// 创建一个组件类，并作出定义
React.createClass
// 创建并返回一个新的指定类型的 ReactElement
React.createElement
React.cloneElement
// 返回一个生成指定类型 ReactElements 的函数
React.createFactory
// 验证一个对象是否为ReactElement，返回boolean值
React.isValidElement
React.DOM
.....
  ```

- `react-dom.js` 提供与 DOM 操作相关的接口，以下列举几个常用的：
```
// 渲染一个 ReactElement 到 DOM 中，放在 container 指定的 DOM 元素下，返回一个到该组件的引用。
ReactDOM.render
// 从 DOM 中移除已经挂载的 React 组件，清除相应的事件处理器和 state
ReactDOM.unmountComponentAtNode
ReactDOM.findDOMNode
```
- `react-dom-server.js` 服务端渲染的几个 API 被独立出来，以下两个是常用的
```
ReactDOMServer.renderToString
ReactDOMServer.renderToStaticMarkup
```
- `react-with-addons.js` React.addons被拆分出若干个独立的包
  - 说明下，这个文件是官方提供的已封装的一系列插件
  - 在0.14版本将其中的插件封装成若干个独立的 package提供使用（至少五个，之前版本是直接在一个文件中引用）。

### 编译器优化
react-tools 及 JSXTransformer.js 已弃用

### 以前是采用JSXTransformer来解析JSX语法，现在是全面拥抱Babel（可以 `npm insttall babel -g` 安装babel进行JSX语法解析、或是加上babel提供的browser.js库进行解析）。

> 如果没接触Babel，请移步这里[babeljs.io](https://babeljs.io/)，Babel是一款强大的语言解析器，基于babel还可以自定义封装自己的解析器插件。

# JSX 语法
> JSX这种混合使用 JavaScript 和 XML 的语言,JSX语法跟 JavaScript不兼容。凡是使用 JSX 的地方，都要加上type="text/babel"

```js
// Input (JSX):
var person = <Person name={window.isLoggedIn ? window.name : ''} />;
// Output (JS):
var person = React.createElement(
  Person,
  {name: window.isLoggedIn ? window.name : ''}
);
```

```js
//JSX
class HelloMessage extends React.Component {
  render() {
    return <div>Hello {this.props.name}</div>;
  }
}

ReactDOM.render(<HelloMessage name="John" />, mountNode);

//JS
class HelloMessage extends React.Component {
  render() {
    return React.createElement(
      "div",
      null,
      "Hello ",
      this.props.name
    );
  }
}

ReactDOM.render(React.createElement(HelloMessage, { name: "John" }), mountNode);
```

# 组件 API
### ReactComponent
React 组件实例在渲染的时候创建。这些实例在接下来的渲染中被重复使用，可以在组件方法中通过 this 访问。唯一一种在 React 之外获取 React 组件实例句柄的方式就是保存 `React.render` 的返回值。在其它组件内，可以使用 `refs` 得到相同的结果。

### setState
```
setState(object nextState[, function callback])
```

合并 nextState 和当前 state。这是在事件处理函数中和请求回调函数中触发 UI 更新的主要方法。另外，也支持可选的回调函数，该函数在 `setState` 执行完毕并且组件重新渲染完成之后调用。

> ### 注意：
> 绝对不要直接改变 `this.state`，因为在之后调用 `setState()` 可能会替换掉你做的更改。把 `this.state` 当做不可变的。
`setState()` 不会立刻改变 `this.state`，而是创建一个即将处理的 state 转变。在调用该方法之后获取 `this.state` 的值可能会得到现有的值，而不是最新设置的值。
> 不保证 `setState()` 调用的同步性，为了提升性能，可能会批量执行 state 转变和 DOM 渲染。
> `setState()` 将总是触发一次重绘，除非在 `shouldComponentUpdate()` 中实现了条件渲染逻辑。如果使用可变的对象，但是又不能在 `shouldComponentUpdate()` 中实现这种逻辑，仅在新 state 和之前的 state 存在差异的时候调用 `setState()` 可以避免不必要的重新渲染。

### replaceState
```
replaceState(object nextState[, function callback])
```
类似于 `setState()`，但是删除之前所有已存在的 state 键，这些键都不在 nextState 中。

### forceUpdate()
```
forceUpdate([function callback])
```

如果 `render()` 方法从 this.props 或者 `this.state` 之外的地方读取数据，你需要通过调用 `forceUpdate()` 告诉 React 什么时候需要再次运行 `render()`。如果直接改变了 `this.state`，也需要调用 `forceUpdate()`。
调用 `forceUpdate()` 将会导致 `render()` 方法在相应的组件上被调用，并且子级组件也会调用自己的 `render()`，但是如果标记改变了，那么 React 仅会更新 DOM。
通常情况下，应该尽量避免所有使用 `forceUpdate()` 的情况，在 `render()` 中仅从 this.props 和 this.state 中读取数据。这会使应用大大简化，并且更加高效。

### getDOMNode
```
DOMElement getDOMNode()
```
如果组件已经挂载到了 DOM 上，该方法返回相应的本地浏览器 DOM 元素。从 DOM 中读取值的时候，该方法很有用，比如获取表单字段的值和做一些 DOM 操作。当 `render` 返回 null 或者 false 的时候，`this.getDOMNode()` 返回 null。

### isMounted()
```
bool isMounted()
```
如果组件渲染到了 DOM 中，`isMounted()` 返回 true。可以使用该方法保证 `setState()` 和 `forceUpdate()` 在异步场景下的调用不会出错。

### setProps
```
setProps(object nextProps[, function callback])
```
当和一个外部的 JavaScript 应用集成的时候，你可能想给一个用 `React.render()` 渲染的组件打上改变的标记。
尽管在同一个节点上再次调用 `React.render()` 来更新根组件是首选的方式，也可以调用 `setProps()` 来改变组件的属性，触发一次重新渲染。另外，可以传递一个可选的回调函数，该函数将会在 `setProps` 完成并且组件重新渲染完成之后调用。

### replaceProps
```
replaceProps(object nextProps[, function callback])
```
类似于 `setProps()`，但是删除所有已存在的 props，而不是合并新旧两个 props 对象。

# 生命周期
> 许多方法在组件生命周期中某个确定的时间点执行

### 挂载: componentWillMount
```
componentWillMount()
```
服务器端和客户端都只调用一次，在初始化渲染执行之前立刻调用。如果在这个方法内调用 `setState()`，`render()` 将会感知到更新后的 state，将会执行仅一次，尽管 state 改变了。

### 挂载: componentDidMount
```
componentDidMount()
```
在初始化渲染执行之后立刻调用一次，仅客户端有效（服务器端不会调用）。在生命周期中的这个时间点，组件拥有一个 DOM 展现，你可以通过 `this.getDOMNode()` 来获取相应 DOM 节点。

### 更新： componentWillReceiveProps
```
  componentWillReceiveProps()
```
在组件接收到新的 props 的时候调用。在初始化渲染的时候，该方法不会调用。
用此函数可以作为 react 在 prop 传入之后， `render()` 渲染之前更新 `state` 的机会。老的 props 可以通过 `this.props` 获取到。在该函数中调用 `this.setState()` 将不会引起第二次渲染。
```js
componentWillReceiveProps: function(nextProps) {
  this.setState({
    likesIncreasing: nextProps.likeCount > this.props.likeCount
  });
}
```
> ### 注意：
>
```
对于 state，没有相似的方法： componentWillReceiveState。
将要传进来的 prop 可能会引起 state 改变，反之则不然。
如果需要在 state 改变 的时候执行一些操作，
请使用 componentWillUpdate。
```

### 更新： shouldComponentUpdate
```
boolean shouldComponentUpdate(object nextProps, object nextState)
```
在接收到新的 props 或者 state，将要渲染之前调用。该方法在初始化渲染的时候不会调用，在使用 `forceUpdate` 方法的时候也不会。

如果确定新的 props 和 state 不会导致组件更新，则此处应该 返回 false。
```js
shouldComponentUpdate: function(nextProps, nextState) {
  return nextProps.id !== this.props.id;
}
```
如果 `shouldComponentUpdate` 返回 false，则 render() 将不会执行，直到下一次 state 改变。（另外，`componentWillUpdate` 和 `componentDidUpdate` 也不会被调用。）
默认情况下，`shouldComponentUpdate` 总会返回 true，在 state 改变的时候避免细微的 bug，但是如果总是小心地把 state 当做不可变的，在 render() 中只从 props 和 state 读取值，此时你可以覆盖 `shouldComponentUpdate` 方法，实现新老 props 和 state 的比对逻辑。
如果性能是个瓶颈，尤其是有几十个甚至上百个组件的时候，使用 `shouldComponentUpdate` 可以提升应用的性能。

### 更新： componentWillUpdate
```
componentWillUpdate(object nextProps, object nextState)
```
在接收到新的 props 或者 state 之前立刻调用。在初始化渲染的时候该方法不会被调用。
使用该方法做一些更新之前的准备工作。
> ### 注意：
> 你不能在刚方法中使用 `this.setState()`。如果需要更新 state 来响应某个 prop 的改变，请使用 `componentWillReceiveProps`。

### 更新： componentDidUpdate
```
componentDidUpdate(object prevProps, object prevState)
```
在组件的更新已经同步到 DOM 中之后立刻被调用。该方法不会在初始化渲染的时候调用。
使用该方法可以在组件更新之后操作 DOM 元素。
> ### 注意：
> 为了兼容 v0.9，DOM 节点会作为最后一个参数传入。如果使用这个方法，你仍然可以使用 `this.getDOMNode()` 来访问 DOM 节点。

### 移除： componentWillUnmount
```
componentWillUnmount()
```
在组件从 DOM 中移除的时候立刻被调用。
在该方法中执行任何必要的清理，比如无效的定时器，或者清除在 componentDidMount 中创建的 DOM 元素。

# 状态机
> React 框架将所有的UI视为一个简单的状态机，那么任意一个UI场景就是一个状态机中一种状态。根据决定状态的状态机变量的值，React框架渲染出状态机的当前状态----对于开发者来说，单个UI场景就被渲染出来了。随着状态机变量值的改变，UI状态机也在不停的改变状态，UI场景也随之不停的被重新渲染。这样一个过程可以轻松的做到数据与UI保持一致。
> 单个组件在`render`时就有组件自身的各个状态的UI视图的渲染的逻辑,调用`setState`触发`render`,`render` 就是单个组件渲染的逻辑

```js
class StateComponent extends React.createClass({
  statics: {
    randStateEnum: function() {
      let i = parseInt(Math.random() * 5);
      let se = StateComponent.stateEnum();
      return se[i < se.length ? i : se.length - 1];
    },
    stateEnum: function() {
      return [1,2,3,4];
    }
  },
  doRand() {
    this.setState({
      state: StateComponent.randStateEnum(),
      count: this.state.count + 1
    });
  },

  getInitialState() {
       return {state: StateComponent.randStateEnum(), count: 0};
  },
  componentDidMount() {
    this.interval = setInterval(() => this.doRand(), 1000);
  },

  componentWillUnmount() {
    clearInterval(this.interval);
  },

  render() {
    return <div>Hello {this.props.name}, state:{this.state.state}</div>;
  }
});

ReactDOM.render(<StateComponent name="World" />, mountNode);
```

# 事件
### 虚拟事件对象
> 事件处理器将会传入虚拟事件对象的实例，一个对浏览器本地事件的跨浏览器封装。它有和浏览器本地事件相同的属性和方法
> 如果因为一些因素，需要底层的浏览器事件对象，只要使用 nativeEvent 属性就可以获取到它了

每一个虚拟事件对象都有下列的属性：
```js
boolean bubbles
boolean cancelable
DOMEventTarget currentTarget
boolean defaultPrevented
number eventPhase
boolean isTrusted
DOMEvent nativeEvent
void preventDefault()
void stopPropagation()
DOMEventTarget target
number timeStamp
string type
```

### 剪贴板事件
> onCopy onCut onPaste

### 键盘事件
> onKeyDown onKeyPress onKeyUp

### 焦点事件
> onFocus onBlur

### 表单事件
> onChange onInput onSubmit

### 鼠标事件
> onClick onDoubleClick onDrag onDragEnd onDragEnter onDragExit onDragLeave
onDragOver onDragStart onDrop onMouseDown onMouseEnter onMouseLeave
onMouseMove onMouseOut onMouseOver onMouseUp
> 参数:
> ```js
boolean altKey
Number button
Number buttons
Number clientX
Number clientY
boolean ctrlKey
function getModifierState(key)
boolean metaKey
Number pageX
Number pageY
DOMEventTarget relatedTarget
Number screenX
Number screenY
boolean shiftKey
```
### 触摸事件
> 为了使触摸事件生效，在渲染所有组件之前调用 React.initializeTouchEvents(true)
> onTouchCancel onTouchEnd onTouchMove onTouchStart

### UI 事件
> onScroll

### 鼠标滚轮滚动事件
> onWheel


# 语法糖(Promise)
>参照 [JavaScript Promise迷你书（中文版）](http://liubin.org/promises-book/)

```js
//定义
var promise = new Promise(function(resolve, reject) {
    let rand = Math.random() * 10;
    console.log('rand:' + rand)
    if(rand > 5) {
      resolve({rand:rand, msg:'猜对了.'});
    } else {
      reject({rand:rand, msg:'不好意思猜错了.'});
    }
    // 异步处理
    // 处理结束后、调用resolve 或 reject
});

//使用
promise
.then(data => {
  console.log('promise.then>>>data:%s', JSON.stringify(data));
})
.catch(data => {
  console.log('promise.catch>>>data:%s', JSON.stringify(data));
});
```

* xhr-promise.js

```js
function getURL(URL) {
    return new Promise(function (resolve, reject) {
        var req = new XMLHttpRequest();
        req.open('GET', URL, true);
        req.onload = function () {
            if (req.status === 200) {
                resolve(req.responseText);
            } else {
                reject(new Error(req.statusText));
            }
        };
        req.onerror = function () {
            reject(new Error(req.statusText));
        };
        req.send();
    });
}
// 运行示例
var URL = "http://httpbin.org/get";
getURL(URL).then(function onFulfilled(value){
    console.log(value);
}).catch(function onRejected(error){
    console.error(error);
});

//fetch
//fetch本身也是返回一个类似 Promise 的对象
fetch("https://www.baidu.com", {method: 'GET'})
.then((response) => {
    if(response.status === 200) {
        console.trace(response);
    } else {//这个异常也会被后面的 catch 到
      throw new Error('非200状态码的异常', response.status)
    }
  })
.catch((error) => console.trace(error))
```

# 理解和运用mixin
---
> ### 什么是mixin
mixin是解决代码重复的强大工具之一，它同时还能让组件保持专注于自身的业务逻辑。实际运用中的简单理解就是：她们就是混合进组建类的对象而已。（讲人话：让不同的组件共用同一部分逻辑，实现代码重用）

## 示例
```js
// 组件间都需要用到的一段逻辑
// 经常写太麻烦，抽离出来公用
var stateRecordMixin = {
    componentWillMount:function(){
        this.oldStates = [];
    },
    componentWillUpdate: function(nextProp,nextState){
        this.oldStates.push(nextState);
    },
    previousState:function(){
        var index = this.oldStates.length -1;
        return index == -1 ? {} : this.oldStates[index];
    }
}

// 定义一个组件MessageBox
var MessageBox = React.createClass({
  // 在这里使用mixin
    mixins: [stateRecordMixin],
    getInitialState:function(){
        return {
            count: 0,
        }
    },
    doUpdate:function(){
        this.setState({
            count: this.state.count + 1,
        });

        alert('上一次的计数是：'+this.previousState().count)
    },
    render:function(){
        console.log('渲染');
        return (
            <div>
                <h1 > 计数： {this.state.count}</h1>
                <button onClick={this.doUpdate}>手动更新一下组件（包括子组件）</button>
                <Submessage count={this.state.count}/>
            </div>
        )
    }
});

var Submessage = React.createClass({
    mixins: [stateRecordMixin],
    getInitialState:function(){
        return {
            count: 0,
        }
    },
    componentWillReceiveProps:function(nextProp){
        this.setState({
            count: this.props.count *2,
        })
    },
    render:function(){
        console.log('上一次子组件的计数是：'+this.previousState().count )
        return (
            <h3>当前子组件的计数是：{this.state.count}</h3>
        )
    }
});

// 使用组件
ReactDOM.render( <MessageBox/>,
    document.getElementById('app')
)
```

# other

### 很多js库的开头
```js
(function (factory) {
    'use strict';
    if (typeof define === 'function' && define.amd) {
        // Register as an anonymous AMD module:
        define([
            'jquery',
            'jquery.ui.widget'
        ], factory);
    } else if (typeof exports === 'object') {
        // Node/CommonJS:
        factory(
            require('jquery'),
            require('./vendor/jquery.ui.widget')
        );
    } else {
        // Browser globals:
        factory(window.jQuery);
    }
}(function ($) {
    'use strict';
}));
```
