@echo off
setlocal enabledelayedexpansion

set "pcs=listepc.csv"
set "resultat=resultatping.txt"
set "temp=temppinginfo.txt"
set "tempresult=tempresult.txt"

for /f "tokens=* delims=/ " %%a in ('date /t') do (
	set "date=%%a"
)
for /f "tokens=* delims=: " %%a in ('time /t') do (
	set "time=%%a"
)


for /f "tokens=1 delims= " %%a in (%pcs%) do (
	set "nompc=%%a"

	if exist %resultat% (
		for /f "tokens=* delims=;" %%c in (%resultat%) do (
			for /f "tokens=1 delims=;" %%d in ("%%c") do (
				if "%%d"=="hostname: !nompc!" (
					set "statutP=%%c"
				)
			)
		)
	)

	ping -n 1 -w 1000 !nompc! > %temp%
	set "ip="
	for /f "tokens=2 delims=[]" %%b in (%temp%) do (
		set "ip=%%b"
	)

	set "statutA="
	if !errorlevel! == 0 (
		set "statutA=hostname: !nompc!; adresse ip: !ip!; date et heure: !date!a !time!.
	) else (
		set "statutA=hostname: !nompc!; aucune reponse."
	)
	
	if defined statutP (
		if "!statutA!" neq "!statutP!" (
			echo !statutA! | find "aucune reponse" >nul
			if !errorlevel! == 0 (
				echo !statutP! >> %tempresult%
			) else (
				echo !statutA! >> %tempresult%
			)
		) else (
			echo !statutP! >> %tempresult%
		)
	)

)
move /y %tempresult% %resultat%
echo Execution terminee, le resultat se trouve dans %resultat%
del %temp%
endlocal

