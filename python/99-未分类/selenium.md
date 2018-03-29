# selenium

[http://www.seleniumhq.org/](http://www.seleniumhq.org/)

Selenium 自动化浏览器

## WebDriver

### ChromeDriver - WebDriver for Chrome

- [下载地址](https://sites.google.com/a/chromium.org/chromedriver/)
- [使用方法](https://sites.google.com/a/chromium.org/chromedriver/getting-started)

方式一: 指定 `/path/to/chromedriver`

```python
from selenium import webdriver

path = "/Users/xxx/Downloads/chromedriver"

browser = webdriver.Chrome(path)
browser.get("http://www.baidu.com")
print(browser.page_source)
browser.close()

```

方式二: Start the ChromeDriver server

先运行 `chromedriver`

```python
capabilities = webdriver.DesiredCapabilities.CHROME.copy()
# capabilities['platform'] = "MAC"
# capabilities['version'] = "10.12"
browser = webdriver.Remote(command_executor="http://127.0.0.1:9515", desired_capabilities=capabilities)
browser.get("http://www.baidu.com")
print(browser.page_source)
```

## headless

无头浏览器 `PhantomJS`, `NightmareJS`等等

最新版本 `selenium` 不再支持 `PhantomJS`

Chrome推出了`headless mode`

可以利用

* ES2017
* ServiceWork(PWA测试随便耍)
* 无沙盒环境
* 无痛通讯&API调用
* 无与伦比的速度
* ...

### 使用 selenium 的 webdrive 驱动 headless chrome

```python
from selenium.webdriver.chrome.options import Options

chrome_options = Options()
chrome_options.add_argument("--headless")
# chrome_options.add_argument('--disable-gpu')

driver = webdriver.Chrome(driver_path, options=chrome_options)
```

### 利用Xvfb方式实现伪 headless chrome

当浏览器不支持headless模式,可以利用python 的Xvfb实现伪 headless mode,Xvfb只是产生了一个虚拟窗口,浏览器只是没有在当前窗口显示.

示例

```python
from selenium import webdriver
from xvfbwrapper import Xvfb

xvfb = Xvfb(width=1280,height=720)
xvfb.start()
driver = webdriver.Chrome()
driver.get('http://www.baidu.com')
cookies = driver.get_cookies()
print(cookies)
driver.close()
xvfb.stop()
```
