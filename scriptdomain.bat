@echo off
setlocal enabledelayedexpansion

set "listenom=list.txt"
set "temp=temp.txt"
set "temp2=temp2.txt"
set "resAct=resultats_actifs.txt"
set "resNoAct=resultats_non_actifs.txt"

for /f "tokens=* delims=/ " %%a in ('date /t') do (
	set "date=%%a"
)
for /f "tokens=* delims=: " %%a in ('time /t') do (
	set "time=%%a"
)

chcp 65001 > nul
>%resAct% echo. || >%resNoAct% echo.

echo Date et heure : !date! à !time! >> %resAct%
echo Date et heure : !date! à !time! >> %resNoAct%

for /f "tokens=* delims=" %%a in (%listenom%) do (
	set "nom=%%a"
	net user !nom! /domain > %temp%
	for /f "tokens=*" %%i in (%temp%) do (
		echo %%i
	)
	for /f "tokens=*" %%i in ('findstr /c:"Compte" %temp%') do (
		set "actif=%%i"
	)
	for /f "tokens=*" %%i in ('findstr /c:"Dernier" %temp%') do (
		set "acces=%%i"
	)
	for /f "tokens=*" %%i in ('findstr /c:"mot de passe expire" %temp%') do (
		set "mdp=%%i"
	)
	for /f "tokens=*" %%i in ('findstr /c:"changmt" %temp%') do (
		set "change=%%i"
	)

	echo !actif! > %temp2%
	set "act="
	for /f "tokens=*" %%i in ('findstr /c:"Oui" %temp2%') do (
		if errorlevel == 0 (
			set "act=Oui"
		)
	)
	
	if defined act (
		(
		echo nom du compte: !nom!
		echo !actif!
		echo !acces!
		echo !mdp! 
		echo !change!
		echo ----
		echo. 
		) >> %resAct%
	) else (
		(
		echo nom du compte: !nom!
		echo !actif!
		echo !acces!
		echo !mdp!
		echo !change!
		echo ----
		echo. 
		) >> %resNoAct%
	)
	
)

del %temp%
del %temp2%
echo Execution finie
echo -----
Pause