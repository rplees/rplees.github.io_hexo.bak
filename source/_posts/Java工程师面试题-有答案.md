---
title: Java工程师面试题-有答案
date: 2016-02-25 17:20:58
tags: [面试,JAVA,技术]
---

#Java工程师面试题-有答案

### 1、下面哪些是Thread类的方法（ ABD ）
- A、start()
- B、 run()   
- C、exit()  
- D、 getPriority()

### 2、下列说法正确的有（ C ）
- A． class中的constructor不可省略
- B． constructor必须与class同名，但方法不能与class同名
- C． constructor在一个对象被new时执行
- D．一个class只能定义一个constructor

### 3、下面程序的运行结果：（ B ）
```bash
public static void main(String args[]) {
        Thread t = new Thread() {
            public void run() {
                pong();
            }
        };
        t.run();
        System.out.print("ping");
    }
    static void pong() {
        System.out.print("pong");
    }
```

- A、pingpong        
- B、pongping       
- C、pingpong和pongping都有可能       
- D、都不输出

### 4、GC线程是否为守护线程？（ 是 ）
***只要当前JVM实例中尚存在任何一个非守护线程没有结束，守护线程就全部工作；只有当最后一个非守护线程结束时，守护线程随着JVM一同结束工作。
守护线程最典型的应用就是 GC (垃圾回收器)***

### 5、volatile关键字是否能保证线程安全？（不能）
***volatile关键字用在多线程同步中，可保证读取的可见性，JVM只是保证从主内存加载到线程工作内存的值是最新的读取值，而非cache中。但多个线程对

volatile的写操作，无法保证线程安全。例如假如线程1，线程2 在进行read,load 操作中，发现主内存中count的值都是5，那么都会加载这个最新的值，在线程1堆count进行修改之后，会write到主内存中，主内存中的count变量就会变为6；线程2由于已经进行read,load操作，在进行运算之后，也会更新主内存count的变量值为6；导致两个线程及时用volatile关键字修改之后，还是会存在并发的情况。***

### 6、下列说法正确的是（AC）
- A LinkedList继承自List
- B AbstractSet继承自Set
- C HashSet继承自AbstractSet
- D WeakMap继承自HashMap

### 7、存在使i + 1 < i的数吗（存在）
***如果i为int型，那么当i为int能表示的最大整数时，i+1就溢出变成负数了，此时不就<i了吗。

扩展：存在使i > j || i <= j不成立的数吗
存在、比如Double.NaN或Float.NaN***

### 8、0.6332的数据类型是（B）
- A、 float     
- B、 double     
- C、 Float      
- D、 Double

***默认为double型，如果为float型需要加上f显示说明，即0.6332f***

### 9、下面哪个流类属于面向字符的输入流（ D ）
- A、  BufferedWriter           
- B、  FileInputStream          
- C、  ObjectInputStream          
- D、  InputStreamReader

### 10、不通过构造函数也能创建对象吗（ A ）
- A、是
- B、否

***Java创建对象的几种方式-重要：

(1) 用new语句创建对象，这是最常见的创建对象的方法。
(2) 运用反射手段,调用java.lang.Class或者java.lang.reflect.Constructor类的newInstance()实例方法。
(3) 调用对象的clone()方法。
(4) 运用反序列化手段，调用java.io.ObjectInputStream对象的 readObject()方法。

(1)和(2)都会明确的显式的调用构造函数 ；(3)是在内存上对已有对象的影印，所以不会调用构造函数 ；(4)是从文件中还原类的对象，也不会调用构造函数。***

### 11、ArrayList list = new ArrayList(20);中的list扩充几次（A）
- A、0
- B、1
- C、2
- D、3
### 12、下面哪些是对称加密算法（ AB ）
- A、 DES   
- B、 AES   
- C、 DSA   
- D、 RSA

### 13、下面程序能正常运行吗（ 能 ）
```java
public class NULL {
    public static void haha(){
        System.out.println("haha");
    }
    public static void main(String[] args) {
        ((NULL)null).haha();
    }
}
```

### 14、下面程序的运行结果是什么（）
```java
class HelloA {

    public HelloA() {
        System.out.println("HelloA");
    }

    { System.out.println("I'm A class"); }

    static { System.out.println("static A"); }

}

public class HelloB extends HelloA {
    public HelloB() {
        System.out.println("HelloB");
    }

    { System.out.println("I'm B class"); }

    static { System.out.println("static B"); }

    public static void main(String[] args) {
　　　　 new HelloB();
　　 }

}
```

***答案：

static A
static B
I'm A class
HelloA
I'm B class
HelloB***

### 15、下面代码的运行结果为：（C）
```java
public class foo{
    public static void main (String[] args){
        String s;
        System.out.println("s=" + s);
    }
}
```
- A、 代码得到编译，并输出“s=”
- B、 代码得到编译，并输出“s=null”
- C、 由于String s没有初始化，代码不能编译通过
- D、 代码得到编译，但捕获到 NullPointException异常

### 16、 System.out.println("5" + 2);的输出结果应该是（ A ）
- A、 52                   
- B、 7                     
- C、 2                     
- D、 5

### 17、指出下列程序的运行结果（B）
```java
public class Example {
    String str = new String("good");
    char[] ch = { 'a', 'b', 'c' };
    public static void main(String args[]) {
        Example ex = new Example();
        ex.change(ex.str, ex.ch);
        System.out.print(ex.str + " and ");
        System.out.print(ex.ch);
    }
    public void change(String str, char ch[]) {
        str = "test ok";
        ch[0] = 'g';
    }
}
```

- A、 good and abc
- B、 good and gbc
- C、 test ok and abc
- D、 test ok and gbc

### 18、下列哪种异常是检查型异常，需要在编写程序时声明 （ C ）
- A、 NullPointerException        
- B、 ClassCastException      
- C、 FileNotFoundException       
- D、 IndexOutOfBoundsException

### 19、下面的方法，当输入为2的时候返回值是多少?（）
```java
public static int getValue(int i) {
        int result = 0;
        switch (i) {
        case 1:
            result = result + i;
        case 2:
            result = result + i * 2;
        case 3:
            result = result + i * 3;
        }
        return result;
    }
```

- A、 0
- B、 2
- C、 4
- D、 10


### 20、选项中哪一行代码可以替换题目中//add code here而不产生编译错误？（A）
```java
public abstract class MyClass {
     public int constInt = 5;
     //add code here
     public void method() {
     }
}
```

### 21、两个对象值相同(x.equals(y)==true),但却可有不同的hash code,这句话对不对？为什么？

### 22、"组合优于继承"，是否同意这句话，并阐述你的观点。
