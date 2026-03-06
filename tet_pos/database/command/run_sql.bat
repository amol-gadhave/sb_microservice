@echo off
echo $Id: run_sql.bat 444 2014-04-25 01:26:03Z dtvdomain\ikhan $
echo $URL: https://dtvsource/remote-svn/cst_template/branches/7.0.1/pos/database/command/run_sql.bat $

rem ************************************************************************
rem ************************************************************************
rem Author:      ikhan
rem Create Date: 04/24/2014
rem
rem Purpose: Data Scripts to allow individual Region/Country scripting.
rem These scripts are run in addition to and after the Base scripts.
rem These scripts also support DoubleByte.
rem ************************************************************************
rem ************************************************************************

pushd %~dp0

echo STARTING: run_sql called with args: %*
echo scriptPath: %1
echo    cust id: %2
echo   sql file: %3
echo   database: %4
echo        org: %5
echo      store: %6
echo    country: %7
echo   currency: %8
echo     region: %9

rem To execute the SQL through XXXdbup.exe, this exe file needs to be in ..\database\ location
rem echo EXECUTING: %1\%2dbup.EXE %3 %5 %6 %7 %8 %9 %4
rem %1\%2dbup.EXE %3 %5 %6 %7 %8 %9 %4

rem The following command utilizes the sqlcmd tool of the MSSQL server. For Oracle this will not work
rem sqlcmd -d %4 -i %1\%3 -v OrgID = %5  StoreID = %6 CountryID = '%7' CurrencyID = '%8' RegionID = '%9'

sqlplus dtv/dtv @%1\%3 %5 %6 %7 %8 %9

rem Failure handling
IF ERRORLEVEL 1 (
  echo :: FAILURE :: %3
  goto :eof
)

:eof

popd
