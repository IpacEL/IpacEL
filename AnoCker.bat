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
	
	
	:: GC
	:: -XX:+UnlockExperimentalVMOptions -XX:+UseShenandoahGC ����ShenandoahGC
	:: -XX:+ParallelRefProcEnabled ���������ò������ô��� ����
	:: -XX:ParallelGCThreads=8 �߳�[������]
	:: [��ʹ��] -XX:ConcGCThreads=1 ����[1/8������][���߸���Ҳ��������]
	
	:: �ڴ�
	:: -XX:+AlwaysPreTouch �����������ڴ沢������ʱ����
	:: -XX:+UseNUMA ʹ��UNMA�ڴ���� [����]
	:: -XX:+UseCompressedOops ��64λ����ʹ��32λָ�� [Ĭ��]
	:: -XX:+UseLargePages ʹ�ô�ҳ���ڴ�
	:: [Linux] -XX:+UseTransparentHugePages ��ߴ�ѵ�����
	
	:: ����
	:: -XX:+DisableExplicitGC ���Դ����е� System.gc() ���� ��ֹ�������GC
	:: -XX:+UseSuperWord "��չ��ѭ���е����������滻�����ʼ��"
	:: -XX:+OptimizeFill "�� intrisc �滻�κ����ģʽ"
	
	:: ���ò���
	:: --nogui ������GUI
	:: [��ѡ] --world-dir worlds ����ͼ�ļ�����"worlds"Ŀ¼
	
	"..\jdk-17.0.1.0.1+12\bin\java.exe" -server -Xms10G -Xmx10G -Xss512K -XX:+OptimizeFill -XX:+UseSuperWord -XX:+DisableExplicitGC -XX:+UseLargePages -XX:+UseNUMA -XX:+UseCompressedOops -XX:+AlwaysPreTouch -XX:ParallelGCThreads=8 -XX:+ParallelRefProcEnabled -XX:+UnlockExperimentalVMOptions -XX:+UseShenandoahGC -jar purpur-1.17.1-1428.jar --nogui --world-dir worlds
	
	:: java -Xms4G -Xmx4G -jar purpur-1.16.5-1171.jar -nogui
	
	
	@echo  ------------------------
	@echo     ----����˽���----
	@echo  ------------------------
	
	choice /T 64 /D N
	set /a r=%r%+1
	
goto s
