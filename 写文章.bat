@echo off
mode con lines=30 cols=60
cd C:\Users\xsin\Documents\Github\xsin\ 
echo.================================
echo.       请输入标题
echo.================================
set /p name=标题:
echo name:%name%
echo please wait
hexo new %name% && call 3.bat %name%
pause