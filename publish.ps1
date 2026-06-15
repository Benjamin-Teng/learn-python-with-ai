# 重新發布到 GitHub Pages：本機執行 notebook + 渲染 → 推上線（約 1～2 分鐘後生效）。
# 一樣自動處理中文路徑與 .venv，在本資料夾執行：  .\publish.ps1
# 第一次會問「Update site at ...?」輸入 Y 即可。
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
chcp 65001 | Out-Null
$env:PYTHONUTF8 = "1"
$env:PYTHONIOENCODING = "utf-8"
$env:QUARTO_PYTHON = ".venv\Scripts\python.exe"
& ".venv\Scripts\Activate.ps1"
quarto publish gh-pages
