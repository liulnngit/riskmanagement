@echo off & setlocal enabledelayedexpansion

set CURRENT_DIR=%~dp0
cd /d %CURRENT_DIR%
cd ..
set DEPLOY_HOME=%cd%
cd %CURRENT_DIR%

set CONFIG_FILE=%CURRENT_DIR%\env.cfg

set f=0
for /f "eol=# delims== tokens=1,*" %%a in (%CONFIG_FILE%) do (
    set v=%%a
	if !v!==SERVER_NAME (set SERVER_NAME=%%b)
	if !v!==MAIN_CLASS (set MAIN_CLASS=%%b)
	if !v!==JAVA_OPTS (set JAVA_OPTS=%%b)
	if !v!==JDK_HOME (set JDK_HOME=%%b)
)

if "%JDK_HOME%" == "" set JDK_HOME="%JAVA_HOME%"

if "%JDK_HOME%" == "" goto noJavaHome

echo Using DEPLOY_HOME:    %DEPLOY_HOME%
echo Using JAVA_HOME:      %JDK_HOME%

set _RUNJAVA="%JDK_HOME%\bin\java"

if "%SERVER_NAME%" == "" set SERVER_NAME=Console
set _EXECJAVA=start "%SERVER_NAME%" %_RUNJAVA%

set LIB_JARS=""

cd ..\lib
for %%i in (*) do set LIB_JARS=!LIB_JARS!;%DEPLOY_HOME%\lib\%%i
cd ..

%_EXECJAVA% %JAVA_OPTS% -classpath %DEPLOY_HOME%\conf;%LIB_JARS% %MAIN_CLASS%
goto end

:noJavaHome
echo The JAVA_HOME environment variable is not defined correctly
echo This environment variable is needed to run this program
goto end

:end