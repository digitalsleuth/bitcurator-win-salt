@echo off
setlocal
title BitCurator WSL Offline Config
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
powershell -f "_this_path_\wsl\wsl-after-reboot.ps1"
