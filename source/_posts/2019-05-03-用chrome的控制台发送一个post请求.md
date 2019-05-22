---
title: 用chrome的控制台发送一个post请求
categories:
  - 未归类
date: 2019-05-03 13:43:44
tags:
---

实例

```
var xml = new XMLHttpRequest();
var url = "http://10.66.1.1/abc.jsp";       
xml.open('POST', url, true); 
xml.setRequestHeader("Content-type","application/x-www-form-urlencoded"); 
xml.send("score=5&abc=6"); 
```

