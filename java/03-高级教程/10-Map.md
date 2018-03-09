# Map

将键映射到值的对象。一个映射不能包含重复的键；每个键最多只能映射到一个值。

## Map和Collection的区别

- Map 存储的是键值对形式的元素，键唯一，值可以重复。夫妻对
- Collection 存储的是单独出现的元素，子接口Set元素唯一，子接口List元素可重复。

## Map功能概述(待补齐)

- 添加功能
- 删除功能
- 判断功能
- 获取功能
- 长度功能

## Map集合的遍历

### 键找值

- 获取所有键的集合
- 遍历键的集合,得到每一个键
- 根据键到集合中去找值

### 键值对对象找键和值

- 获取所有的键值对对象的集合
- 遍历键值对对象的集合，获取每一个键值对对象
- 根据键值对对象去获取键和值

```java
代码体现：
    Map<String,String> hm = new HashMap<String,String>();

    hm.put("it002","hello");
    hm.put("it003","world");
    hm.put("it001","java");

    //方式1 键找值
    Set<String> set = hm.keySet();
    for(String key : set) {
        String value = hm.get(key);
        System.out.println(key+"---"+value);
    }

    //方式2 键值对对象找键和值
    Set<Map.Entry<String,String>> set2 = hm.entrySet();
    for(Map.Entry<String,String> me : set2) {
        String key = me.getKey();
        String value = me.getValue();
        System.out.println(key+"---"+value);
    }
```

## HashMap集合(常用)

- HashMap<String,String>
- HashMap<Integer,String>
- HashMap<String,Student>
- HashMap<Student,String>

## TreeMap集合的练习

- TreeMap<String,String>
- TreeMap<Student,String>

## 案例

### 统计一个字符串中每个字符出现的次数

### 集合的嵌套遍历

- HashMap嵌套HashMap
- HashMap嵌套ArrayList
- ArrayList嵌套HashMap
- 多层嵌套
