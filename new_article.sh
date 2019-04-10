#!/bin/bash
echo "请输入文章名"
read title
echo "$title is your title"
cd /home/xsin/Documents/x51n
hexo new $title
echo "创建成功"
cd /home/xsin/Documents/x51n/source/_posts/
titles=$(find . -iname "*$title.md")
echo $titles
gnome-open $titles && exit
