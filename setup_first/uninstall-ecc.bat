@echo off
setlocal enabledelayedexpansion

:: ============================================================
:: Everything Claude Code - Uninstallation Script
:: Removes all ECC components from Claude Code configuration.
:: ============================================================

set "SCRIPT_DIR=%~dp0"
set "CLAUDE_DIR=%USERPROFILE%\.claude"
set "BACKUP_DIR=%CLAUDE_DIR%\backups"
set "INSTALL_MARKER=%CLAUDE_DIR%\.ecc-installed"
set "DEBUG_MARKER=%CLAUDE_DIR%\.ecc-debug-configured"

:: Color codes for Windows 10+
for /f %%i in ('echo prompt $E^| cmd') do set "ESC=%%i"
set "GREEN=!ESC![92m"
set "YELLOW=!ESC![93m"
set "RED=!ESC![91m"
set "CYAN=!ESC![96m"
set "WHITE=!ESC![97m"
set "GRAY=!ESC![90m"
set "RESET=!ESC![0m"

echo.
echo !CYAN!================================================!RESET!
echo !CYAN!  Everything Claude Code - Uninstaller!RESET!
echo !CYAN!================================================!RESET!
echo.

:: Check if installed
if not exist "%INSTALL_MARKER%" (
    if not exist "%CLAUDE_DIR%\rules\common" (
        if not exist "%CLAUDE_DIR%\agents" (
            echo !YELLOW![INFO] ECC does not appear to be installed.!RESET!
            echo.
            echo No ECC components found in: %CLAUDE_DIR%
            echo.
            goto :end
        )
    )
)

:: Show what will be removed
echo !YELLOW!The following will be removed:!RESET!
echo.
if exist "%CLAUDE_DIR%\rules\common" echo   - Rules (common)
if exist "%CLAUDE_DIR%\rules\typescript" echo   - Rules (typescript)
if exist "%CLAUDE_DIR%\rules\python" echo   - Rules (python)
if exist "%CLAUDE_DIR%\rules\golang" echo   - Rules (golang)
if exist "%CLAUDE_DIR%\rules\swift" echo   - Rules (swift)
if exist "%CLAUDE_DIR%\agents" echo   - Agents
if exist "%CLAUDE_DIR%\commands" echo   - Commands
if exist "%CLAUDE_DIR%\skills" echo   - Skills
if exist "%CLAUDE_DIR%\scripts\hooks" echo   - Hook scripts
if exist "%DEBUG_MARKER%" echo   - Debug config marker
if exist "%INSTALL_MARKER%" echo   - Installation marker
echo.

:: Confirm uninstallation
choice /c YN /m "Are you sure you want to uninstall? (Y/N)"
if errorlevel 2 (
    echo.
    echo !GREEN!Uninstall cancelled. All components preserved.!RESET!
    goto :end
)

echo.
echo !CYAN!========================================!RESET!
echo !CYAN!  Starting Uninstallation...!RESET!
echo !CYAN!========================================!RESET!
echo.

:: Create backup before uninstall
echo !YELLOW!Creating backup before removal...!RESET!
set "BACKUP_TIMESTAMP=%date:~0,4%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "BACKUP_TIMESTAMP=!BACKUP_TIMESTAMP: =0!"
set "PRE_UNINSTALL_BACKUP=%BACKUP_DIR%\pre_uninstall_!BACKUP_TIMESTAMP!"

if exist "%CLAUDE_DIR%\rules" (
    call :create_dir "!PRE_UNINSTALL_BACKUP!"
    xcopy "%CLAUDE_DIR%\rules" "!PRE_UNINSTALL_BACKUP!\rules\" /E /I /Q >nul 2>&1
)
if exist "%CLAUDE_DIR%\agents" (
    xcopy "%CLAUDE_DIR%\agents" "!PRE_UNINSTALL_BACKUP!\agents\" /E /I /Q >nul 2>&1
)
if exist "%CLAUDE_DIR%\commands" (
    xcopy "%CLAUDE_DIR%\commands" "!PRE_UNINSTALL_BACKUP!\commands\" /E /I /Q >nul 2>&1
)
if exist "%CLAUDE_DIR%\skills" (
    xcopy "%CLAUDE_DIR%\skills" "!PRE_UNINSTALL_BACKUP!\skills\" /E /I /Q >nul 2>&1
)
echo !GREEN!  Backup created: !PRE_UNINSTALL_BACKUP!!RESET!
echo.

:: Remove Rules
echo !YELLOW!Removing Rules...!RESET!
if exist "%CLAUDE_DIR%\rules\common" (
    rd /s /q "%CLAUDE_DIR%\rules\common" 2>nul
    echo   Removed: rules\common
)
if exist "%CLAUDE_DIR%\rules\typescript" (
    rd /s /q "%CLAUDE_DIR%\rules\typescript" 2>nul
    echo   Removed: rules\typescript
)
if exist "%CLAUDE_DIR%\rules\python" (
    rd /s /q "%CLAUDE_DIR%\rules\python" 2>nul
    echo   Removed: rules\python
)
if exist "%CLAUDE_DIR%\rules\golang" (
    rd /s /q "%CLAUDE_DIR%\rules\golang" 2>nul
    echo   Removed: rules\golang
)
if exist "%CLAUDE_DIR%\rules\swift" (
    rd /s /q "%CLAUDE_DIR%\rules\swift" 2>nul
    echo   Removed: rules\swift
)
:: Remove rules dir if empty
dir /b "%CLAUDE_DIR%\rules" 2>nul | findstr "^" >nul || rd /s /q "%CLAUDE_DIR%\rules" 2>nul
echo !GREEN!  Done.!RESET!
echo.

:: Remove Agents
echo !YELLOW!Removing Agents...!RESET!
if exist "%CLAUDE_DIR%\agents" (
    rd /s /q "%CLAUDE_DIR%\agents" 2>nul
    echo   Removed: agents
)
echo !GREEN!  Done.!RESET!
echo.

:: Remove Commands
echo !YELLOW!Removing Commands...!RESET!
if exist "%CLAUDE_DIR%\commands" (
    rd /s /q "%CLAUDE_DIR%\commands" 2>nul
    echo   Removed: commands
)
echo !GREEN!  Done.!RESET!
echo.

:: Remove Skills
echo !YELLOW!Removing Skills...!RESET!
if exist "%CLAUDE_DIR%\skills" (
    rd /s /q "%CLAUDE_DIR%\skills" 2>nul
    echo   Removed: skills
)
echo !GREEN!  Done.!RESET!
echo.

:: Remove Scripts
echo !YELLOW!Removing Scripts...!RESET!
if exist "%CLAUDE_DIR%\scripts\hooks" (
    rd /s /q "%CLAUDE_DIR%\scripts\hooks" 2>nul
    echo   Removed: scripts\hooks
)
if exist "%CLAUDE_DIR%\scripts\lib" (
    rd /s /q "%CLAUDE_DIR%\scripts\lib" 2>nul
    echo   Removed: scripts\lib
)
:: Remove scripts dir if empty
dir /b "%CLAUDE_DIR%\scripts" 2>nul | findstr "^" >nul || rd /s /q "%CLAUDE_DIR%\scripts" 2>nul
echo !GREEN!  Done.!RESET!
echo.

:: Remove markers
echo !YELLOW!Removing markers...!RESET!
if exist "%INSTALL_MARKER%" (
    del "%INSTALL_MARKER%" >nul 2>&1
    echo   Removed: installation marker
)
if exist "%DEBUG_MARKER%" (
    del "%DEBUG_MARKER%" >nul 2>&1
    echo   Removed: debug config marker
)
echo !GREEN!  Done.!RESET!
echo.

:: Remove debug config from settings.json
echo !YELLOW!Cleaning settings.json...!RESET!
if exist "%CLAUDE_DIR%\settings.json" (
    powershell -ExecutionPolicy Bypass -Command ^
        "$json = Get-Content -Raw -Path '%CLAUDE_DIR%\settings.json' | ConvertFrom-Json; " ^
        "$json.PSObject.Properties.Remove('verbose'); " ^
        "$json.PSObject.Properties.Remove('appendSystemPrompt'); " ^
        "$json | ConvertTo-Json -Depth 10 | Set-Content -Path '%CLAUDE_DIR%\settings.json' -Encoding UTF8" 2>nul
    echo   Cleaned: verbose and appendSystemPrompt removed
)
echo !GREEN!  Done.!RESET!
echo.

:: Success message
echo.
echo !GREEN!================================================!RESET!
echo !GREEN!  Uninstallation Complete!!RESET!
echo !GREEN!================================================!RESET!
echo.
echo !WHITE!Removed Components:!RESET!
echo   - Rules (all languages)
echo   - Agents
echo   - Commands
echo   - Skills
echo   - Scripts
echo   - Configuration markers
echo.
echo !WHITE!Backup Location:!RESET!
echo   !PRE_UNINSTALL_BACKUP!
echo.
echo !YELLOW!Note: Restart Claude Code for changes to take effect.!RESET!
echo.
echo !GRAY!To reinstall, run: install-ecc.bat!RESET!
echo.

goto :end

:: ============================================================
:: Subroutines
:: ============================================================

:create_dir
if not exist "%~1" (
    mkdir "%~1" >nul 2>&1
)
exit /b

:end
echo Press any key to exit...
pause >nul
endlocal
