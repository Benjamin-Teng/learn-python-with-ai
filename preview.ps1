# 本機預覽：邊改邊看（會即時更新）。按 Ctrl+C 結束。
# 內容已全面互動化：程式在讀者瀏覽器端用 Pyodide 執行，渲染本身不需要 Python / Jupyter，
# 直接呼叫 Quarto 即可（資料夾已是 ASCII 路徑，不再需要 chcp / UTF-8 / .venv 那一套）。
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
quarto preview
