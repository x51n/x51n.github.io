@echo off
mode con lines=30 cols=60

cd C:\Users\xsin\Documents\xsin\ 
echo.================================
echo.       ���������
echo.================================
set /p name=����:
echo name:%name%
echo please wait
hexo new %name% && call 3.bat %name%
pause
