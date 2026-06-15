# 交接：下個 session 接續事項（Option A 互動化）

> 這份是給「改名資料夾 + 重開 Claude Code」後的新 session 看的。讀完照著做即可接續。

## 為什麼改名

原資料夾名 `學習用AI寫程式`（中文）會害 **quarto-live 互動功能** 與 **Jupyter kernel** 在 Windows 失敗：

- Jupyter kernel spawn：中文絕對路徑變 mojibake → 找不到 python（之前用 `chcp 65001`+UTF-8 暫時繞過）。
- quarto-live 的 `live.lua`：Lua `require('resources/tinyyaml')` 解析中文絕對路徑失敗，**chcp 也救不了**。

所以把資料夾改成 ASCII 名稱 `learn-python-with-ai`（與 repo 同名）。Repo 與線上網址不受影響：

- Repo：`Benjamin-Teng/learn-python-with-ai`
- 線上：<https://benjamin-teng.github.io/learn-python-with-ai>

## 開工第一件事

`.venv` 在搬移時已刪除（gitignored），先重建並驗證：

```powershell
uv sync                          # 重建 .venv（含 jupyter）
# 驗證 ASCII 路徑已修好 kernel 問題（理論上不再需要 chcp/UTF-8 hack）：
quarto render index.ipynb
```

若 `quarto render` 順利顯示輸出，代表中文路徑問題已解決。

## 主任務：Option A —— 全面互動化（使用者已同意全轉 .qmd）

把講義的程式碼變成「可編輯 + 按 Run 就地執行」（Pyodide，瀏覽器內跑，不用 Colab）。

**關鍵技術事實（已驗證）：**

- quarto-live 擴充已裝在 `_extensions/live/`。
- 互動 cell 語法：```` ```{pyodide} ```` + 選項 `#| edit:` / `#| autorun:` / `#| runbutton:` / `#| min-lines:` / `#| timelimit:`。
- 文件格式 `format: live-html`；**`engine: markdown`**（不需 jupyter，pyodide 全在瀏覽器端；這點很重要，否則會報 `No module named 'yaml'`）。
- 同頁 cell **共用 Python session**（前面定義後面能用）。
- POC 已完成並驗證可行：`poc-interactive.qmd`（第 4 章）。可先 `quarto preview poc-interactive.qmd` 看效果。

**轉換計畫：**

1. `index.ipynb` → `index.qmd`（`quarto convert index.ipynb` 可起手，再把 `python` 程式碼格改成 `{pyodide}`）。
2. 文件頂 front-matter：`format: live-html` + `engine: markdown` + 沿用 `theme: [cosmo, custom.scss]`、`toc-location: left` 等。
3. **拿掉 Colab 按鈕**（就地執行已取代它）。導覽列的「在 Colab 開啟」也移除。
4. **第 7 章 Streamlit `app.py` 不能在 pyodide 跑** → 保留為唯讀程式碼（`#| edit: false` 或純 code block，不要變互動）。
5. 故意的 `SyntaxError` 格、填空練習（`print(? * ?)` 等）→ 可變成真的互動 cell 讓讀者動手。
6. 渲染輸出目錄沿用 `_site`；發布仍 `quarto publish gh-pages`（轉 pyodide 後不需 jupyter，publish 可不依賴 .venv）。

## 待辦的內容 / UI 修正（尚未做）

1. **TOC 捲動問題**：主頁捲動時左側目錄高亮會跟，但整體不會自動捲動（章節多時 active 項目跑到看不見處）。
   修法：`custom.scss` 給 `nav#TOC` 設 `position: sticky; top: 1rem; max-height: calc(100vh - 2rem); overflow-y: auto;`，讓它自己 sticky + 可內部捲動，Quarto 既有的 scroll-active-into-view 才會生效。
2. **補充章節 A 改寫**：把「補充章節 A：在本地端用 venv 跑 **Jupyter**」改成「用 venv 跑 **Streamlit**」。理由：互動化後讀者不需在本機跑 Jupyter（直接網頁玩），但 Streamlit 仍需本機跑，所以這章補上真正還需要本機做的事。

## 已 commit 但「尚未發布到 gh-pages」的內容修正（uv sync 後記得 publish）

- 4.8 裝飾器不再聲稱第 7 章會用到
- 7.4 步驟 3 `share.streamlit.io` 加超連結
- 補充章節 A/B 命名、補B-1～5、第 3 章「3.1 換你試試」
- 1.0 年份 `2021`→`2023`

（線上站目前還是「顯示輸出 + Mermaid」那版，上面這些要 publish 才會上線。）

## 搬移後清理

- `preview.ps1` / `publish.ps1`：可移除 `chcp 65001` + UTF-8 那段（ASCII 路徑不再需要）。全轉 pyodide 後甚至不需 venv/jupyter 來 publish。
- 更新 `README.md`、memory 裡殘留的中文路徑為新路徑。
- 舊 CJK 路徑若還留著空殼或 junction，清掉。

## 已完成（脈絡參考）

Quarto 站、GitHub Pages 一鍵部署、（將被移除的）Colab 按鈕、cosmo 淺色主題 + custom.scss、左側 TOC 配色 + 大標/小標縮排、1.2 Mermaid 流程圖、`execute: true` 顯示程式輸出、多項內容修正。設計文件在 `docs/superpowers/specs/`。
