---
title: Java工程师面试题
date: 2016-02-25 17:20:58
tags: [面试,JAVA,技术]
---

#Java工程师面试题

### 1、下面哪些是Thread类的方法（  ）
- A、start()
- B、 run()   
- C、exit()  
- D、 getPriority()

### 2、下列说法正确的有（  ）
- A． class中的constructor不可省略
- B． constructor必须与class同名，但方法不能与class同名
- C． constructor在一个对象被new时执行
- D．一个class只能定义一个constructor

### 3、下面程序的运行结果：（  ）
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

### 4、GC线程是否为守护线程？（  ）


### 5、volatile关键字是否能保证线程安全？（  ）


### 6、下列说法正确的是（  ）
- A LinkedList继承自List
- B AbstractSet继承自Set
- C HashSet继承自AbstractSet
- D WeakMap继承自HashMap

### 7、存在使i + 1 < i的数吗（  ）


### 8、0.6332的数据类型是（  ）
- A、 float     
- B、 double     
- C、 Float      
- D、 Double



### 9、下面哪个流类属于面向字符的输入流（  ）
- A、  BufferedWriter           
- B、  FileInputStream          
- C、  ObjectInputStream          
- D、  InputStreamReader

### 10、不通过构造函数也能创建对象吗（  ）
- A、是
- B、否



### 11、ArrayList list = new ArrayList(20);中的list扩充几次（  ）
- A、0
- B、1
- C、2
- D、3
### 12、下面哪些是对称加密算法（  ）
- A、 DES   
- B、 AES   
- C、 DSA   
- D、 RSA

### 13、下面程序能正常运行吗（  ）
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

### 14、下面程序的运行结果是什么（  ）
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



### 15、下面代码的运行结果为：（  ）
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

### 16、 System.out.println("5" + 2);的输出结果应该是（  ）
- A、 52                   
- B、 7                     
- C、 2                     
- D、 5

### 17、指出下列程序的运行结果（  ）
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

### 18、下列哪种异常是检查型异常，需要在编写程序时声明 （  ）
- A、 NullPointerException        
- B、 ClassCastException      
- C、 FileNotFoundException       
- D、 IndexOutOfBoundsException

### 19、下面的方法，当输入为2的时候返回值是多少?（  ）
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


### 20、选项中哪一行代码可以替换题目中//add code here而不产生编译错误？（  ）
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
