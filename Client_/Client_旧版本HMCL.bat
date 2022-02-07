@ECHO OFF

REM 判断目录是否存在, 不存在就退出
IF NOT EXIST Ipac_Client_E EXIT


REM 客户端目录
CD Ipac_Client_E


REM 启动[start ]
..\zulu17.30.15-ca-fx-jre17.0.1-win_x64\bin\javaw.exe -jar HMCL.jar


REM 删除旧日志
FORFILES -P "Client_files\logs" -s -m *.log -d -32 -C "CMD /C DEL @PATH
FORFILES -P "Client_files\logs" -s -m *.gz -d -32 -C "CMD /C DEL @PATH
FORFILES -P "Client_files\logs" -s -m *.log -d -32 -C "CMD /C DEL @PATH

FORFILES -P "Client_files\crash-reports" -s -m *.txt -d -32 -C "CMD /C DEL @PATH


REM 删除可能存在的内存转储文件
DEL /Q *.dmp


REM 结束后, 删除HMCL留下的日志文件
CD %appdata%
IF NOT EXIST .hmcl\dependencies (
	REM 目录不存在, 删除.hmcl目录
	RMDIR /S/Q %appdata%\.hmcl\logs
)