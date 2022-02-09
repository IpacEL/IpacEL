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
	:: -XX:+UnlockExperimentalVMOptions -XX:+UseShenandoahGC 启用ShenandoahGC
	:: -XX:+ParallelRefProcEnabled 尽可能启用并行引用处理 缓存
	:: -XX:ParallelGCThreads=8 线程[核心数]
	:: [不使用] -XX:ConcGCThreads=1 并发[1/8核心数][调高更快也更吃性能]
	
	:: 内存
	:: -XX:+AlwaysPreTouch 分配连续的内存并在启动时保留
	:: [del] -XX:+UseNUMA 使用UNMA内存分配 [测试] 这个参数可能造成一些问题
	:: -XX:+UseCompressedOops 在64位环境使用32位指针 [默认]
	:: -XX:+UseLargePages 使用大页面内存
	:: [Linux] -XX:+UseTransparentHugePages 提高大堆的性能
	
	:: 其他
	:: -XX:+DisableExplicitGC 忽略代码中的 System.gc() 调用 防止插件调用GC
	:: -XX:+UseSuperWord "用展开循环中的向量操作替换数组初始化"
	:: -XX:+OptimizeFill "用 intrisc 替换任何填充模式"
	
	:: 后置参数
	:: --nogui 不启动GUI
	:: [可选] --world-dir worlds 将地图文件放入"worlds"目录
	
	"..\jdk-17.0.1.0.1+12\bin\java.exe" -server -Xms10G -Xmx10G -Xss512K -XX:+OptimizeFill -XX:+UseSuperWord -XX:+DisableExplicitGC -XX:+UseLargePages -XX:+UseCompressedOops -XX:+AlwaysPreTouch -XX:ParallelGCThreads=8 -XX:+ParallelRefProcEnabled -XX:+UnlockExperimentalVMOptions -XX:+UseShenandoahGC -jar purpur-1.17.1-1428.jar --nogui --world-dir worlds
	
	:: java -Xms4G -Xmx4G -jar purpur-1.16.5-1171.jar -nogui
	
	
	@echo  ------------------------
	@echo     ----服务端结束----
	@echo  ------------------------
	
	choice /T 64 /D N
	set /a r=%r%+1
	
goto s
