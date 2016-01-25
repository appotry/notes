# Collections

1. 是针对集合进行操作的工具类

<!-- TOC -->

- [Collections](#collections)
    - [Collection和Collections的区别](#collection和collections的区别)
    - [常见的几个小方法](#常见的几个小方法)
    - [案例](#案例)
    - [Collection集合总结](#collection集合总结)
    - [在集合中常见的数据结构(掌握)](#在集合中常见的数据结构掌握)
    - [针对Collection集合我们到底使用谁](#针对collection集合我们到底使用谁)

<!-- /TOC -->

## Collection和Collections的区别

- Collection 是单列集合的顶层接口，有两个子接口List和Set
- Collections 是针对集合进行操作的工具类，可以对集合进行排序和查找等

## 常见的几个小方法

- `public static <T> void sort(List<T> list)`
- `public static <T> int binarySearch(List<?> list,T key)`
- `public static <T> T max(Collection<?> coll)`
- `public static void reverse(List<?> list)`
- `public static void shuffle(List<?> list)`

## 案例

ArrayList集合存储自定义对象的排序

模拟斗地主洗牌和发牌

模拟斗地主洗牌和发牌并对牌进行排序

## Collection集合总结

- Collection
    - |--List 有序,可重复
        - |--ArrayList
            - 底层数据结构是数组，查询快，增删慢。
            - 线程不安全，效率高
        - |--Vector
            - 底层数据结构是数组，查询快，增删慢。
            - 线程安全，效率低
        - |--LinkedList
            - 底层数据结构是链表，查询慢，增删快。
            - 线程不安全，效率高
    - |--Set 无序,唯一
        - |--HashSet
            - 底层数据结构是哈希表。
            - 如何保证元素唯一性的呢?
                - 依赖两个方法：hashCode()和equals()
                - 开发中自动生成这两个方法即可
        - |--LinkedHashSet
            - 底层数据结构是链表和哈希表
            - 由链表保证元素有序
            - 由哈希表保证元素唯一
        - |--TreeSet
            - 底层数据结构是红黑树。
            - 如何保证元素排序的呢?
                - 自然排序
                - 比较器排序
            - 如何保证元素唯一性的呢?
                - 根据比较的返回值是否是0来决定

## 在集合中常见的数据结构(掌握)

- ArrayXxx:底层数据结构是数组，查询快，增删慢
- LinkedXxx:底层数据结构是链表，查询慢，增删快
- HashXxx:底层数据结构是哈希表。依赖两个方法：`hashCode()`和`equals()`
- TreeXxx:底层数据结构是二叉树。两种方式排序：自然排序和比较器排序

## 针对Collection集合我们到底使用谁

- 是否唯一
    - 是：Set
        - 排序吗?
            - 是：TreeSet
            - 否：HashSet
        - 如果你知道是Set，但是不知道是哪个Set，就用HashSet。
    - 否：List
        - 要安全吗?
            - 是：Vector
            - 否：ArrayList或者LinkedList
                - 查询多：ArrayList
                - 增删多：LinkedList
        - 如果你知道是List，但是不知道是哪个List，就用ArrayList。
- 如果你知道是Collection集合，但是不知道使用谁，就用ArrayList。
- 如果你知道用集合，就用ArrayList。
