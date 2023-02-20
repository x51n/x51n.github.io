start /min /w mshta vbscript:setTimeout("window.close()",1000)
echo The InputValue is %1
set articledir=C:\Users\xsin\Documents\xsin\source\_posts\
set name=%1
echo %name%
cd C:\Users\xsin\Documents\xsin\source\_posts
for %%i in (*%name%*) do start /d "D:\Program Files\Typora\"   Typora.exe  "%articledir%\%%i"
exit