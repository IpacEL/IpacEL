@echo off
title IpacaEL_AnoCker
choice /T 12 /D N

@set r=0

:s
	
	set /p n=<AnoCker.txt
	set /a n+=1
	>AnoCker.txt echo %n%
	title IpacaEL_AnoCker  ������=%r%/�ܼ�=%n%
	
	@echo  ------------------------
	@echo     ----���������----
	@echo  ------------------------
	
	
	:: java -Xms4G -Xmx4G -jar purpur-1.16.5-1171.jar -nogui
	
	
	:: GC
	:: -XX:+UnlockExperimentalVMOptions -XX:+UseShenandoahGC ����ShenandoahGC
	:: -XX:+ParallelRefProcEnabled ���������ò������ô��� ����
	:: -XX:ParallelGCThreads=8 �߳�[Ĭ�Ϻ�����]
	:: -XX:ConcGCThreads=4 ����[Ĭ��1/8������][���߸���Ҳ��������]
	:: -XX:+PerfDisableSharedMem ��ֹдͳ���ļ�
	
	:: �ڴ�
	:: -XX:+AlwaysPreTouch �����������ڴ沢������ʱ����
	:: -XX:+UseLargePages ʹ�ô�ҳ���ڴ�
	:: [LINUX] -XX:+UseTransparentHugePages ͸����ҳ��, ��ߴ�ѵ�����
	
	:: ����
	:: -XX:+UseNUMA ����CPU���һ����, ��֮���е�Ե��ͨѶ, ������� [����]
	:: -XX:+DisableExplicitGC ���Դ����е� System.gc() ���� ��ֹ�������GC
	
	:: ���ò���
	:: --nogui ������GUI
	:: [��ѡ] --world-dir worlds ����ͼ�ļ�����"worlds"Ŀ¼
	
	
	"..\jdk-17.0.1.0.1+12\bin\java.exe" -server -Xms20G -Xmx20G -Xss512K -XX:+DisableExplicitGC -XX:+UseLargePages -XX:+AlwaysPreTouch -XX:+PerfDisableSharedMem -XX:ConcGCThreads=4 -XX:ParallelGCThreads=8 -XX:+ParallelRefProcEnabled -XX:+UnlockExperimentalVMOptions -XX:+UseShenandoahGC -jar purpur-1.17.1-1428.jar --nogui --world-dir worlds
	
	:: "..\jdk-17.0.1.0.1+12\bin\java.exe" -server -Xms20G -Xmx20G -Xss640K -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar purpur-1.17.1-1428.jar --nogui --world-dir worlds
	
	
	@echo  ------------------------
	@echo     ----����˽���----
	@echo  ------------------------
	
	choice /T 64 /D N
	set /a r=%r%+1
	
goto s
