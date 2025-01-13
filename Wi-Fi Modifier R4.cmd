@echo off
title Wi-Fi Modifier Script by Darkn
mode 40,10

net session >NUL 2>&1
if %errorlevel% == 0 (
	timeout 1 >NUL
	goto START
) else (
	echo [31mThis script requires Admin.[0m
	echo [33mWhen prompted, select "Yes".[0m
	echo.
	echo To proceed faster, press [33m"SHIFT"[0m.
	timeout 5 >NUL
	set "params=%*"
	cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
)

:START
mode 65,18
cls
echo ----------------------------
echo [32mWi-Fi Modifier Script[0m
echo [33mBy Darkn[0m // 1/10/2025
echo.
echo [33m[1][0m - Unblock Wi-Fi
echo [33m[2][0m - Reblock Wi-Fi
echo [33m[0][0m - Exit
echo.
echo [33m"Unblock Wi-Fi"[0m - Changes DNS Servers to unblock everything.
echo [33m"Reblock Wi-Fi"[0m - Reverts DNS Servers to fix Wi-Fi temporarily.
echo [33m"Exit"[0m - Closes the script, duh.
echo.
echo ----------------------------

set /p option="[32mType & Enter An Option:[0m "
if "%option%" == "1" goto UNBLOCK0
if "%option%" == "2" goto REBLOCK0
if "%option%" == "0" goto CLOSE
goto RESTART

:UNBLOCK0
mode 60,15
cls
echo [32mNOTE: If this is the wrong option, just type N to go back.[0m
echo Selected Option: [33mUnblock Wi-Fi[0m
echo.
timeout 1 >NUL
choice /c yn /m "Proceed?"
if errorlevel 2 goto START
if errorlevel 1 goto UNBLOCK1

:REBLOCK0
mode 60,15
cls
echo [32mNOTE: If this is the wrong option, just type N to go back.[0m
echo Selected Option: [33mReblock Wi-Fi[0m
echo.
timeout 1 >NUL
choice /c yn /m "Proceed?"
if errorlevel 2 goto START
if errorlevel 1 goto REBLOCK1

:UNBLOCK1
mode 72,25
cls 
timeout 1 >NUL
	echo [33mSetting DNS Servers...[0m
	echo [This will unblock the majority of the Wi-Fi for you.]
	netsh interface ipv4 set dnsserver "Wi-Fi" source=static addr=1.1.1.1 > wifiscriptlog.txt
		timeout 3 >NUL
		findstr /i "The configured DNS server is incorrect or does not exist." wifiscriptlog.txt > nul
		if %errorlevel% == 0 (
			del wifiscriptlog.txt
			echo.
			echo [31mAn error has occured applying DNS.[0m
			timeout 1 >NUL
			echo Make sure Wi-Fi is turned on and connected, then restart the script.
			timeout 2 >NUL
			goto CLOSE
		) else (
			del wifiscriptlog.txt
			echo.
			echo Windows IP Configuration
			echo.
			echo [32mSuccessfully set Preferred DNS Server to 1.1.1.1[0m
		)
	netsh interface ipv4 add dnsserver "Wi-Fi" addr=1.0.0.1 index=2
timeout 3 >NUL
	echo Windows IP Configuration
	echo.
	echo [32mSuccessfully set Alternate DNS Server to 1.0.0.1[0m
	echo.
timeout 2 >NUL	
	echo [33mFlushing / Resetting DNS Cache[0m
	echo [This will reset internet cache, preventing you the need to restart.]
timeout 2 >NUL
	ipconfig /flushdns >NUL
	echo.
timeout 1 >NUL
	echo Windows IP Configuration
	echo.
	echo [32mSuccessfully flushed the DNS Resolver Cache.[0m
	echo.
timeout 2 >NUL
	echo [32mFinished![0m
	echo [31mNOTE: If an error occurs, check if Wi-Fi is on and connected.[0m
timeout 3 >NUL
GOTO CLOSE

:REBLOCK1
mode 72,25
cls 
timeout 1 >NUL
	echo [33mResetting DNS Servers...[0m
	echo [This will change the DNS Servers back to default.]
timeout 3 >NUL
	netsh interface ip set dnsservers name="Wi-Fi" source=dhcp
timeout 1 >NUL
	echo Windows IP Configuration
	echo.
	echo [32mSuccessfully set DNS Servers to be obtained automatically.[0m
	echo.
timeout 2 >NUL	
	echo [33mFlushing / Resetting DNS Cache[0m
	echo [This will reset internet cache, preventing you the need to restart.]
timeout 2 >NUL
	ipconfig /flushdns >NUL
	echo.
timeout 1 >NUL
	echo Windows IP Configuration
	echo.
	echo [32mSuccessfully flushed the DNS Resolver Cache.[0m
	echo.
timeout 2 >NUL
	echo [32mFinished![0m
	echo [31mOnce internet works again, re-run this script and use option 1.[0m
timeout 3 >NUL
goto CLOSE	

:RESTART
mode 42,10
cls
timeout 1 >NUL
	echo [31mPlease input one of the options properly.[0m
	echo The available options are: [1, 2, 0]
	echo.
timeout 2 >NUL
	echo [33mReturning back to menu.[0m
timeout 3 >NUL
goto START

:CLOSE
	echo.
	echo [33mClosing Script...[0m
timeout 5 >NUL
	cls
	echo [30mVERSION 1 (REV 4) // 1/10/2025
exit