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
	
	
	:: java -Xms4G -Xmx4G -jar purpur-1.16.5-1171.jar -nogui
	
	
	:: GC
	:: -XX:+UnlockExperimentalVMOptions -XX:+UseShenandoahGC 启用ShenandoahGC
	:: -XX:+ParallelRefProcEnabled 尽可能启用并行引用处理 缓存
	:: -XX:ParallelGCThreads=8 线程[默认核心数]
	:: -XX:ConcGCThreads=4 并发[默认1/8核心数][调高更快也更吃性能]
	:: -XX:+PerfDisableSharedMem 禁止写统计文件
	
	:: 内存
	:: -XX:+AlwaysPreTouch 分配连续的内存并在启动时保留
	:: -XX:+UseLargePages 使用大页面内存
	:: [LINUX] -XX:+UseTransparentHugePages 透明大页面, 提高大堆的性能
	
	:: 其他
	:: -XX:+UseNUMA 若干CPU组成一个组, 组之间有点对点的通讯, 提高性能 [测试]
	:: -XX:+DisableExplicitGC 忽略代码中的 System.gc() 调用 防止插件调用GC
	
	:: 后置参数
	:: --nogui 不启动GUI
	:: [可选] --world-dir worlds 将地图文件放入"worlds"目录
	
	
	"..\jdk-17.0.1.0.1+12\bin\java.exe" -server -Xms20G -Xmx20G -Xss512K -XX:+DisableExplicitGC -XX:+UseLargePages -XX:+AlwaysPreTouch -XX:+PerfDisableSharedMem -XX:ConcGCThreads=4 -XX:ParallelGCThreads=8 -XX:+ParallelRefProcEnabled -XX:+UnlockExperimentalVMOptions -XX:+UseShenandoahGC -jar purpur-1.17.1-1428.jar --nogui --world-dir worlds
	
	:: "..\jdk-17.0.1.0.1+12\bin\java.exe" -server -Xms20G -Xmx20G -Xss640K -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar purpur-1.17.1-1428.jar --nogui --world-dir worlds
	
	
	@echo  ------------------------
	@echo     ----服务端结束----
	@echo  ------------------------
	
	choice /T 64 /D N
	set /a r=%r%+1
	
goto s
