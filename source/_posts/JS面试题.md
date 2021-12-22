---
title: JS面试题
date: 2018-04-19
tags: [面试,JS,技术]
---

## 下面的代码输出什么
```js
var x; // 声明 x
console.log(x);
console.log(typeof y);
console.log(z);
```
## 下面的代码输出什么？
```js
var y = 1;
if (function f(){}) {
    y += typeof f;
}
console.log(y);
```
## JavaScript中什么是闭包？

## 写一个mul函数，使用方法如下。
```js
console.log(mul(2)(3)(4)); // output : 24
console.log(mul(4)(3)(4)); // output : 48
```
## JavaScript怎么清空数组？
## 怎么判断一个object是否是数组(array)

## 下面代码输出什么？
```js
var output = (function(x){
    delete x;
    return x;
})(0);

console.log(output);
```

## 下面代码输出什么？
```js
var trees = ["xyz","xxxx","test","ryan","apple"];
delete trees[3];

console.log(trees.length);
```

## 下面代码输出什么？
```js
var bar = true;
console.log(bar + 0);   
console.log(bar + "xyz");  
console.log(bar + true);  
console.log(bar + false);
```

## 两种函数声明有什么区别？
```js
var foo = function(){
    // Some code
};
function bar(){
    // Some code
};
```

## HTTPRequestXML 原理
