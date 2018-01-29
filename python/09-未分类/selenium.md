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
