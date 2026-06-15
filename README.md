# 用 AI 學寫 Python — 教學網站

給程式零基礎者（期貨營業員）的中文 Python 教學講義，從 Python 基礎一路帶到用 Streamlit 架起自己的網站。本專案用 [Quarto](https://quarto.org) + [quarto-live](https://github.com/r-wasm/quarto-live) 把講義渲染成**可互動**的教學網站——讀者能就地改程式、按 Run 在瀏覽器裡執行——部署在 GitHub Pages。

- 🌐 **線上閱讀**：<https://benjamin-teng.github.io/learn-python-with-ai>
- 📝 **唯一來源**：`index.qmd`（你只要維護這一個檔案）
- ▶️ **動手執行**：每個程式格都能**就地編輯 + 按 `Run Code` 執行**，靠 Pyodide 在讀者的瀏覽器裡跑 Python，不用安裝、不用註冊、不用 Colab

## 互動是怎麼做到的

程式直接跑在讀者的瀏覽器裡（[Pyodide](https://pyodide.org)，WebAssembly 版的 Python），由 `_extensions/live/` 的 quarto-live 擴充提供。幾個關鍵設定：

- 文件格式是 `live-html`、引擎是 `engine: markdown`（寫在 `index.qmd` 最上方的 front-matter）。**渲染時完全不跑 Python / Jupyter**，所有程式都在讀者端瀏覽器執行。
- 互動程式格用 ```` ```{pyodide} ```` 撰寫；同一頁的程式格**共用一個 Python session**（前面定義的變數，後面格子接著就能用）。
- 靜態唯讀程式（例如第 7 章的 Streamlit `app.py`，瀏覽器跑不了伺服器）用一般的 ```` ```python ````，只做語法高亮、不給 Run 按鈕。

## 檔案結構

```text
.
├── index.qmd            # 講義內容（唯一來源，你只維護這個）
├── index.ipynb          # (Legacy) 轉成 .qmd 前的舊 notebook，已不再 render
├── _extensions/live/    # quarto-live 擴充（提供 {pyodide} 互動 cell）
├── _quarto.yml          # 網站設定（live-html 格式、主題、左側目錄、搜尋）
├── custom.scss          # 主題微調（CJK 字型、配色、程式碼區塊、左側目錄 sticky）
├── preview.ps1          # 一鍵本機預覽
├── publish.ps1          # 一鍵重新發布
├── poc-interactive.qmd  # 互動化 POC（驗證用，未發布）
├── pyproject.toml       # (Legacy) jupyter 依賴；互動化後渲染已不需要
├── uv.lock              # (Legacy) uv 鎖定檔
├── README.md            # 本說明
├── _site/               # 渲染輸出（自動產生，不需手動編輯，已 gitignore）
└── docs/                # 設計文件
```

## 前置（第一次接手這個專案時做一次）

互動化之後，建置網站**只需要 Quarto**——渲染不再需要 Python / Jupyter（程式都在讀者瀏覽器端跑）。

```powershell
# 安裝 Quarto（Windows）
winget install --id Posit.Quarto -e
```

> macOS 的 Quarto：`brew install --cask quarto`。裝完開「新的」終端機，`quarto --version` 確認。
> quarto-live 擴充已隨 repo 放在 `_extensions/` 裡，clone 下來即可用，不必另外安裝。

## 日常工作流程

### 1. 更新內容

直接編輯 `index.qmd`。要互動執行的程式格，用 ```` ```{pyodide} ```` 包起來；只想展示、不讓讀者跑的程式，用一般 ```` ```python ````。

### 2. 本機預覽（邊改邊看）

```powershell
.\preview.ps1
```

會自動開瀏覽器，存檔 `index.qmd` 後畫面即時更新。按 `Ctrl+C` 結束。

### 3. 重新發布到網路上

```powershell
.\publish.ps1
```

會：渲染 → 推送到 `gh-pages` 分支 → GitHub Pages 自動更新（約 1～2 分鐘後生效）。第一次會問 `Update site at ...?`，輸入 `Y` 即可。

## 常見問題

- **改了內容但網站沒更新？** 確認有跑 `.\publish.ps1`，並等 1～2 分鐘讓 GitHub Pages 重建（瀏覽器可能要強制重新整理 `Ctrl+F5`）。
- **`quarto` 指令找不到？** 重開一個新的終端機（讓 PATH 生效），或重新安裝 Quarto。
- **互動程式格第一次按 Run 很慢、或沒反應？** 第一次按 Run 會先下載 Pyodide 環境（約幾秒～十幾秒），屬正常；之後就很快。
- **為什麼專案資料夾要用英文名？** 中文（非 ASCII）絕對路徑會讓 quarto-live 的 Lua 解析與 Jupyter kernel 在 Windows 上失敗（mojibake），改用 ASCII 名稱 `learn-python-with-ai` 根治。
- **想換主題 / 調整版面？** 改 `_quarto.yml` 的 `theme` 或 `custom.scss`，可選主題見 <https://quarto.org/docs/output-formats/html-themes.html>。
```
