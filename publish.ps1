# 重新發布到 GitHub Pages：渲染 → 推上線（約 1～2 分鐘後生效）。
# 內容已全面互動化：程式在讀者瀏覽器端用 Pyodide 執行，發布本身不需要 Python / Jupyter。
# 第一次會問「Update site at ...?」輸入 Y 即可。
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
quarto publish gh-pages
