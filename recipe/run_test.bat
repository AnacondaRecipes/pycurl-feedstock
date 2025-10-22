@echo off

pip check
if %ERRORLEVEL% neq 0 exit 1

pytest -v tests
if %ERRORLEVEL% neq 0 exit 1
