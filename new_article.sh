#!/bin/bash
echo "请输入文章名"
read title
echo "$title is your title"
cd /home/xsin/xsin
hexo new $title
echo "创建成功"
cd /home/xsin/xsin/source/_posts/
titles=$(find . -iname "*$title.md")
echo $titles
gnome-open $titles && exit
