
:: > From-pErfo

@echo off
title windows_Buffer_网络优化工具
if exist "%SystemRoot%\SysWOW64" path %path%;%windir%\SysNative;%SystemRoot%\SysWOW64;%~dp0
bcdedit >nul
if '%errorlevel%' NEQ '0' (goto UACPrompt) else (
	echo [!] 已获取管理员权限
	goto UACAdmin
)
:UACPrompt
%1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
exit /B
:UACAdmin

:: 启用延迟扩展
setlocal enabledelayedexpansion

echo windows Buffer 网络优化工具
echo.
set /p input=[1]恢复优化前的设置  [Enter]继续: 
if !input! equ 1 (
	echo.
	rem echo 恢复服务设置
	rem start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\RpcEptMapper" /v Start /t reg_dword /d 3 /f
	rem start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache" /v Start /t reg_dword /d 3 /f
	rem echo.
	rem echo 恢复MaxCacheTtl
	rem echo.
	rem start /wait /b reg delete "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheTtl /f
	rem echo.
	echo 恢复Buffer
	start /wait /b reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketSendBufferLength /f
	start /wait /b reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketReceiveBufferLength /f
	
	echo.
	echo 恢复UdpRecvBufferSize
	start /wait /b reg delete "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v UdpRecvBufferSize /f
	
	echo.
	echo 恢复MaxCacheSize
	start /wait /b reg delete "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheSize /f
	
	echo.
	echo 恢复完成
	pause
	exit
)


echo.
if exist %temp%\url.txt (
	del /F /S /Q %temp%\url.txt
)

echo 加载内置测试网址: %temp%\url.txt



echo https://authserver.mojang.com/>>%temp%\url.txt
echo https://www.minecraft.net/>>%temp%\url.txt
echo https://ipacamod.cc/>>%temp%\url.txt

echo https://cn.bing.com/>>%temp%\url.txt
echo https://baidu.com/>>%temp%\url.txt
echo https://www.mcbbs.net/>>%temp%\url.txt
echo https://www.bilibili.com/>>%temp%\url.txt
echo https://mail.qq.com/>>%temp%\url.txt
echo https://music.163.com/>>%temp%\url.txt
echo https://zhuanlan.zhihu.com/>>%temp%\url.txt
echo https://hypergryph.com/>>%temp%\url.txt

echo https://translate.google.cn/>>%temp%\url.txt



set /p input=[1]打开文件/编辑  [Enter]继续: 
if !input! equ 1 (
	%temp%\url.txt
	set /p input=[Enter]继续: 
)


echo.
set seq=1
for /F "tokens=* delims=" %%t in (%temp%\url.txt) do (
	set url=%%t
	if !seq! equ 1 (
		echo Set client = CreateObject("MSXML2.ServerXMLHTTP"^)>%temp%\send.vbs
	) else (
		echo Set client = CreateObject("MSXML2.ServerXMLHTTP"^)>>%temp%\send.vbs
	)
	echo client.SetTimeOuts 120000,120000,120000,120000>>%temp%\send.vbs
	echo client.open "GET","!url!",false>>%temp%\send.vbs
	echo client.send(^)>>%temp%\send.vbs
	set /a seq+=1
)

set avgTime=0
set totalTime=0
set minTime=
set minBuffer=
set initBuffer=512

echo.
echo 初始化服务设置
start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\RpcEptMapper" /v Start /t reg_dword /d 2 /f
rem start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\DcomLaunch" /v Start /t reg_dword /d 2 /f
start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\nsi" /v Start /t reg_dword /d 2 /f
start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache" /v Start /t reg_dword /d 2 /f

echo.
echo 启动服务
call net start RpcEptMapper
rem call net start DcomLaunch
call net start nsi
call net start Dnscache

echo.
echo 初始化MaxCacheTtl
start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheTtl /t reg_dword /d 255 /f



cls
echo 脚本执行需要一段时间, 完成时会弹窗显示结果

for /L %%f in (1,1,5) do (
	
	echo.
	echo.
	:: echo 初始化 Buffer 为 !initBuffer!
	start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketSendBufferLength /t reg_dword /d !initBuffer! /f
	start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketReceiveBufferLength /t reg_dword /d !initBuffer! /f
	
	:: echo  - 初始化 UdpRecvBufferSize
	start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v UdpRecvBufferSize /t reg_dword /d !initBuffer! /f
	
	:: echo  - 初始化 MaxCacheSize
	start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheSize /t reg_dword /d !initBuffer! /f
	
	
	echo.
	echo 开始测试 Buffer=!initBuffer!, 这可能需要一段时间...
	
	for /L %%t in (1,1,10) do (
		set start=!time!
		start /wait wscript /b %temp%\send.vbs
		set end=!time!
		set startHour=!start:~0,2!
		set /a startHour=1!startHour: =0!-100
		set /a startMin=1!start:~3,2!-100
		set /a startSec=1!start:~6,2!-100
		set /a startMil=1!start:~9,2!-100
		set endHour=!end:~0,2!
		set /a endHour=1!endHour: =0!-100
		set /a endMin=1!end:~3,2!-100
		set /a endSec=1!end:~6,2!-100
		set /a endMil=1!end:~9,2!-100
		set /a start=startHour*360000+startMin*6000+startSec*100+startMil
		set /a end=endHour*360000+endMin*6000+endSec*100+endMil
		set /a dura=!end!-!start!
		echo  - [%%t] Buffer=!initBuffer! 时间: !dura!
		set /a totalTime+=!dura!
	)
	set /a avgTime=!totalTime!/10
	echo Buffer为 !initBuffer! 总时间为 !totalTime! 平均时间为 !avgTime!
	echo.
	
	if "!minTime!" equ "" (
		set minTime=!avgTime!
		set minBuffer=!initBuffer!
	) else (
		if !avgTime! lss !minTime! (
			set minTime=!avgTime!
			set minBuffer=!initBuffer!
		)
	)
	set /a initBuffer*=2
	set avgTime=0
	set totalTime=0
)


del /F /S /Q %temp%\url.txt
del /F /S /Q %temp%\send.vbs

echo.
echo.
echo 最短平均时间为 !minTime!  Buffer 设置为 !minBuffer!
msg %username% /time:10 [Buffer] 最短平均时间为 !minTime!  Buffer 设置为 !minBuffer!

set /p input=使用上述值设置 Buffer: [1]手动输入  [Enter]自动设置: 
echo.
if "!input!" equ "0" (
	
	echo 设置Buffer开始
	start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketSendBufferLength /t reg_dword /d !minBuffer! /f
	start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketReceiveBufferLength /t reg_dword /d !minBuffer! /f
	
	echo.
	echo 初始化UdpRecvBufferSize
	start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v UdpRecvBufferSize /t reg_dword /d !minBuffer! /f
	
	echo.
	echo 初始化MaxCacheSize
	start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheSize /t reg_dword /d !minBuffer! /f
	
) else (
	if "!input!" equ "1" (
		set /p buffer=请输入数值 512-8192：
		echo.
		if !buffer! leq 8192 (
			if !buffer! geq 512 (
				
				echo 设置 Buffer
				start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketSendBufferLength /t reg_dword /d !buffer! /f
				start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketReceiveBufferLength /t reg_dword /d !buffer! /f
				
				echo  - 初始化 UdpRecvBufferSize
				start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v UdpRecvBufferSize /t reg_dword /d !buffer! /f
				
				echo  - 初始化 MaxCacheSize
				start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheSize /t reg_dword /d !buffer! /f
				
			)
		)
	)
)


cls
echo 完成!
pause
exit


