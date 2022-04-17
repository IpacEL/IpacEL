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
	@echo .
	
	
	::https://ipacamod.cc/Message/?where=ID=_aAxORv6dHNc
	
	"..\dragonwell-17.0.2.0.2+8-GA\bin\java.exe" -XX:+UnlockExperimentalVMOptions --add-modules=jdk.incubator.vector -server -Xms14G -Xmx14G -Xss768K -XX:+UseNUMA -XX:CICompilerCount=12 -XX:+PerfDisableSharedMem -XX:LargePageSizeInBytes=2M -XX:+UseLargePages -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+ParallelRefProcEnabled -XX:GCTimeRatio=98 -XX:ShenandoahGCMode=iu -XX:+UseShenandoahGC -jar Mirai-Purpur-1.18.2-R0.1-SNAPSHOT.jar --world-dir worlds --nogui
	
	
	
	@echo .
	@echo  ------------------------
	@echo     ----服务端结束----
	@echo  ------------------------
	
	choice /T 64 /D N
	set /a r=%r%+1
	
goto s
