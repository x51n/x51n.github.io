---
title: python中使用requests构造post和get请求
categories:
  - 未归类
date: 2019-05-31 21:55:02
tags:
  - python
  - requests
  - http
  - post
  - get
---

### 1.安装

```
pip install requests
```

### 2.GET请求

##### 2.1不带参数

```python
#!/usr/bin/python

import requests

url="http://my.os/notification/charm/"

r = requests.get(url)
print r.status_code
print r.content
```

##### 2.2带参数

```python
#!/usr/bin/python

import requests


url="http://my.os/notification/charm/"

payload={'message': "Opportunities and challenges together"}
r = requests.get(url, params=payload)

print r.status_code
print r.content
```

##### 2.3定制请求头

```python
#!/usr/bin/python

import requests

url="http://my.os/notification/charm/"

headers={'Authorization': 'token 52ee7d4c57686ca8d6884fa4c482a28'}
payload={'message': "Opportunities and challenges together"}
r = requests.get(url, headers=headers, params=payload)

print r.status_code
print r.content
```

### 3.发起POST请求

##### 3.1 简单请求

```
#!/usr/bin/python

import requests

url="http://my.os/api/notification/charm/"

payload={'message': "Opportunities and challenges together"}

r = requests.post(url, data=payload)

print r.status_code
print r.content
```

##### 3.2 定制请求头

```
#!/usr/bin/python

import requests


url="http://my.os/api/notification/charm/"

headers={'Authorization': 'token 52ee7d4c57686ca8d6884fa4c482a28'}
payload={'message': "Opportunities and challenges together"}

r = requests.post(url, headers=headers, data=payload)

print r.status_code
print r.content
```

---------------------
作者：翔云123456 
来源：CSDN 
原文：https://blog.csdn.net/lanyang123456/article/details/72594982 