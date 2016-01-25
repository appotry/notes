# Django配置详解

## Django 时间与时区设置问题

- 在Django的配置文件`settings.py`中，有两个配置参数是跟时间与时区有关的，分别是`TIME_ZONE`和`USE_TZ`
- 如果`USE_TZ`设置为`True`时，Django会使用系统默认设置的时区，即`America/Chicago`，此时的`TIME_ZONE`不管有没有设置都不起作用。
- 如果`USE_TZ` 设置为`False`，而`TIME_ZONE`设置为`None`，则Django还是会使用默认的`America/Chicago`时间。若`TIME_ZONE`设置为其它时区的话，则还要分情况，如果是Windows系统，则`TIME_ZONE`设置是没用的，Django会使用本机的时间。如果为其他系统，则使用该时区的时间，入设置`USE_TZ = False`, `TIME_ZONE = 'Asia/Shanghai'`, 则使用上海的`UTC`时间。