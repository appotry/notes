tmp
===

-  feign

Java 正则
---------

.. code:: java

    import java.util.regex.Pattern;
    import java.util.regex.Matcher;

    public static boolean isContainChinese(String str) {
        # 字符串里面是否有中文
        Pattern p = Pattern.compile("[\u4e00-\u9fa5]");
        Matcher m = p.matcher(str);
        if (m.find()) {
            return true;
        }
        return false;
    }
