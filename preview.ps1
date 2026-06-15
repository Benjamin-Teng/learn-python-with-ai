# 本機預覽：邊改邊看（會即時更新）。按 Ctrl+C 結束。
# 這支腳本會自動處理「中文資料夾路徑」與「啟用 .venv 裡的 jupyter」兩件事，
# 所以你不用每次手動設定，直接在本資料夾按右鍵用 PowerShell 執行，或在終端機跑：  .\preview.ps1
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
chcp 65001 | Out-Null                       # 讓終端機用 UTF-8，中文路徑才不會壞
$env:PYTHONUTF8 = "1"
$env:PYTHONIOENCODING = "utf-8"
$env:QUARTO_PYTHON = ".venv\Scripts\python.exe"   # 用 .venv 裡的 Python（含 jupyter）來執行 notebook
& ".venv\Scripts\Activate.ps1"
quarto preview
