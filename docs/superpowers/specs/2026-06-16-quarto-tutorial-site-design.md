# 設計文件：把 Python 教學 notebook 架成 Quarto 教學網站

| 項目 | 內容 |
|---|---|
| 文件版本 | v1.0（2026-06-16 初版） |
| 狀態 | Accepted，進入實作 |
| 作者 | Benjamin-Teng + Claude |
| 來源 | 既有 notebook `用AI學Python_從零到網站_互動講義.ipynb` |

## Overview

把一份給程式零基礎者（期貨營業員）的中文 Python 教學 notebook，用 **Quarto** 轉成排版漂亮、有左側目錄與搜尋、手機也好讀的單頁教學網站，部署到 **GitHub Pages**，並在重點章節加上「Open in Colab」按鈕讓讀者另開分頁動手跑。原本用 JupyterLite 呈現、可讀性差，本案取代之。

## 目標與成功標準

1. notebook 渲染後中文字、emoji、程式碼區塊正常顯示，排版乾淨好讀（手機 RWD）。
2. 左側可點章節目錄（TOC）+ 頂部全文搜尋 + 淺色主題。
3. 重點實作章節有「Open in Colab」按鈕，點擊另開分頁到 Colab。
4. 一鍵部署到 GitHub Pages，最終網址 `https://benjamin-teng.github.io/learn-python-with-ai`。
5. 提供本機預覽指令與 README（更新內容 / 重新發布步驟）。

## 關鍵設計決策（已與使用者定案）

1. **頁面結構：單一 notebook → 一頁長卷。** 維持單一 `.ipynb` 為唯一來源，維護最簡單（改一個檔、跑一個指令重新發布）。
2. **檔名改為 `index.ipynb`。** Quarto 單頁網站首頁須命名 `index`；附帶好處是 Colab 網址乾淨（`.../blob/main/index.ipynb`）。檔案內中文大標題與所有內容不變。
3. **`execute: enabled: false`（渲染時不執行程式）。** notebook 內含故意的語法錯誤格（教讀者讀錯誤訊息）、Streamlit `app.py`、留白練習格——一律以靜態呈現，build 不會壞，且不需安裝 jupyter kernel 來跑程式。20 個 code cell 目前皆無存輸出，故網站只顯示程式碼、不顯示執行結果，動手執行交給 Colab。
4. **部署用 `quarto publish gh-pages`。** 本機渲染 → 推 `gh-pages` 分支 → Pages 上線，不需設定 CI。日後更新只需：① 編輯 `index.ipynb` ② `quarto publish gh-pages`。
5. **Repo：public `learn-python-with-ai`（帳號 Benjamin-Teng）。** Colab 開啟 GitHub notebook 與免費 Pages 都需要 public。

## 架構與檔案結構

```text
學習用AI寫程式/
├── _quarto.yml          # website 設定：主題 / 左側 TOC / 搜尋 / execute off
├── index.ipynb          # 講義單一來源，亦為 Colab 開啟目標
├── README.md            # 更新內容 + 重新發布步驟 + 預覽指令
├── pyproject.toml       # uv 管理（僅在 Quarto 要求時加入 jupyter dev 依賴）
├── .gitignore           # 忽略 .venv / .quarto / _site / .claude 等
├── _publish.yml         # 首次 quarto publish gh-pages 後自動生成
└── docs/superpowers/specs/  # 本設計文件
```

## 元件設計

- **`_quarto.yml`**：`project.type: website`、`format.html` 設 `theme: cosmo`、`toc: true`、`toc-location: left`、`code-copy: true`、`code-tools` 視需要；`website.search`、`website.navbar`（含 GitHub 連結與站名）；頂層 `execute.enabled: false`。語言設繁中（`lang: zh-TW`）。
- **Colab 按鈕**：以 markdown / raw HTML cell 注入。頁頂一顆主按鈕；第 3、4、6、7 章前各一顆。連結統一指向
  `https://colab.research.google.com/github/Benjamin-Teng/learn-python-with-ai/blob/main/index.ipynb`，`target="_blank"` 另開分頁。
- **README.md**：安裝前置（Quarto）、本機預覽 `quarto preview`、更新與重新發布 `quarto publish gh-pages`、Colab 連結維護說明。

## 環境與依賴

- 系統層：Quarto CLI（winget `Posit.Quarto`，使用者本機原本未裝）。
- Python：僅在 Quarto 讀取 `.ipynb` 時要求 `jupyter` 才加入（用 uv 管理為 dev 依賴）；不執行任何使用者程式。

## 邊界（Out of Scope）

- 不做「頁面內就地執行」（in-browser kernel）；動手執行一律走 Colab 另開分頁。
- 不拆章多頁、不做多語系、不自訂 CSS 大改版（先以內建淺色主題達成可讀性）。
- 不設定 GitHub Actions CI（採本機 `quarto publish` 即可）。

## 風險與處置

- **Quarto 讀 `.ipynb` 需要 jupyter**：先試不裝，若 render 報「Jupyter is not available」才以 uv 安裝 jupyter（裝前告知使用者）。
- **CJK 路徑 / Colab 網址**：改名 `index.ipynb` 後為純 ASCII 路徑，規避編碼問題。
- **首次 `quarto publish` 互動提示**：以非互動參數執行；屬對外發布動作，已獲使用者同意。
