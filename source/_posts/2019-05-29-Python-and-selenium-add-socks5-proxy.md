---
title: Python_and_selenium_add_socks5_proxy
categories:
  - 未归类
date: 2019-05-29 12:56:14
tags:
  - python
  - selenium
---

例程如下
```
 options = webdriver.ChromeOptions()
 proxy = '12.12.421.125:1949'   
 options.add_argument('--proxy-server=socks5://' + proxy)
 driver = webdriver.Chrome(options=options)
 driver.get('https://www.google.com') # 获取百度页面
```

