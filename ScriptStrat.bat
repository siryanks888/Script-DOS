echo off
setlocal enabledelayedexpansion

set user=%USERNAME%
set tab=F:\09_Espace_Commun\Projets\Avantdecliquer\agentspiegesmai.txt
set URL=

for /f "tokens=1,2 delims=;" %%a in (%tab%) do (
	if "%%a"=="%USERNAME%" (
		set URL=%%b
		goto :found
	)
)

:found
start "" "%URL%"

endlocal
