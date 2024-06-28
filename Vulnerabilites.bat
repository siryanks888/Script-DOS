@echo off
setlocal enabledelayedexpansion

set "serverlist=servalisto.csv"
set "apps=ServeursApplications.csv"
set "res=resultatapp.txt"

if exist %res% del %res%

for /f "tokens=1,2,3,4 delims=;" %%a in (%apps%) do (
	set "ligne=%%a,%%b,%%c,%%d"
	set "nomApp=%%a
	set "servers="

	for /f "tokens=1 delims=;" %%s in (%serverlist%) do (
		set "server=%%s"
		
		echo !ligne! | findstr /i /c:"!server!" > nul
		if not errorlevel 1 (
			set "servers=!servers! !server!,"
		)
	)

	if defined servers (
		echo L'application !nomApp! utilise les serveurs !servers! contenant des vulnerabilites. >> %res%
	)
)

echo execution finito, resultats dans %res%
echo ------
endlocal
		