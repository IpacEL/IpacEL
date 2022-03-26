@echo off
title IpacaEL_AnoCker
choice /T 12 /D N

@set r=0

:s
	
	set /p n=<AnoCker.txt
	set /a n+=1
	>AnoCker.txt echo %n%
	title IpacaEL_AnoCker  已重启=%r%/总计=%n%
	
	@echo  ------------------------
	@echo     ----服务端运行----
	@echo  ------------------------
	
	
	
	:: GC
	:: -XX:+UseShenandoahGC 启用SGC
	:: -XX:GCTimeRatio=98 应用程序运行时间百分比[与GC] 给GC更多时间_减少GC次数
	:: -XX:+ParallelRefProcEnabled 尽可能启用并行引用处理 缓存
	:: [检查插件, 不要一直使用它] // -XX:+DisableExplicitGC 忽略代码中的 System.gc() 调用 防止插件调用GC
	
	:: 内存
	:: -XX:+AlwaysPreTouch 分配连续的内存并在启动时保留
	:: -XX:+UseLargePages 使用大页面内存
	:: [LINUX] -XX:+UseTransparentHugePages 透明大页面, 提高大堆的性能
	:: -XX:+PerfDisableSharedMem 将匿名内存用于性能计数器
	
	:: 其他/JIT
	:: [系统支持] -XX:+UseNUMA 若干CPU组成一个组, 组之间有点对点的通讯 [测试]
	:: -Xss640K 每个线程的堆栈大小 256?
	:: -Xms20G -Xmx20G #堆栈大小
	:: [默认] -server 使用C2编译器
	
	:: ###临时###
	:: -XX:+CITime JVM关闭时得到各种编译的统计信息
	:: -XX:-BackgroundCompilation 禁用后台编译
	
	:: spigot参数 [放在核心后面]
	:: --nogui 不启动GUI
	:: [可选] --world-dir worlds 将地图文件放入"worlds"目录
	
	
	"..\dragonwell-17.0.2.0.2+8-GA\bin\java.exe" -XX:+CITime -server -Xms20G -Xmx20G -Xss640K -XX:+UseNUMA -XX:+PerfDisableSharedMem -XX:+UseLargePages -XX:+AlwaysPreTouch -XX:+ParallelRefProcEnabled -XX:GCTimeRatio=97 -XX:+UseShenandoahGC -jar purpur-1.17.1-1428.jar --nogui --world-dir worlds
	
	
	:: java -Xms4G -Xmx4G -jar purpur-1.16.5-1171.jar --nogui --world-dir worlds
	
	@echo  ------------------------
	@echo     ----服务端结束----
	@echo  ------------------------
	
	choice /T 64 /D N
	set /a r=%r%+1
	
goto s
