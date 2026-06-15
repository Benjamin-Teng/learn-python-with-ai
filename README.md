# 用 AI 學寫 Python — 教學網站

給程式零基礎者（期貨營業員）的中文 Python 教學講義，從 Python 基礎一路帶到用 Streamlit 架起自己的網站。本專案用 [Quarto](https://quarto.org) 把講義 notebook 渲染成教學網站，部署在 GitHub Pages。

- 🌐 **線上閱讀**：<https://benjamin-teng.github.io/learn-python-with-ai>
- 📓 **唯一來源**：`index.ipynb`（你只要維護這一個檔案）
- ▶️ **動手執行**：網站每個重點章節有「Open in Colab」按鈕，另開分頁即可實際跑程式

## 檔案結構

```text
.
├── index.ipynb        # 講義內容（唯一來源，也是 Colab 開啟的檔案）
├── _quarto.yml        # 網站設定（主題、左側目錄、搜尋、不執行程式碼）
├── README.md          # 本說明
├── _site/             # 渲染輸出（自動產生，不需手動編輯，已 gitignore）
└── docs/              # 設計文件
```

## 前置：安裝 Quarto

只有第一次需要。Windows（PowerShell）：

```powershell
winget install --id Posit.Quarto -e
```

> macOS：`brew install --cask quarto`；或到 <https://quarto.org/docs/get-started/> 下載安裝檔。
> 裝完開「新的」終端機，執行 `quarto --version` 確認。

## 日常工作流程

### 1. 本機預覽（邊改邊看）

```powershell
quarto preview
```

會自動開瀏覽器，存檔 `index.ipynb` 後畫面即時更新。按 `Ctrl+C` 結束。

### 2. 更新內容

直接編輯 `index.ipynb`（用 Jupyter、VS Code，或任何 notebook 編輯器）。**改完存檔就好**，不需要在 notebook 裡執行程式——網站刻意以靜態方式呈現程式碼，實際執行交給讀者在 Colab 進行。

### 3. 重新發布到網路上

```powershell
quarto publish gh-pages
```

這一個指令會：本機渲染 → 推送到 `gh-pages` 分支 → GitHub Pages 自動更新（約 1～2 分鐘後生效）。

> 第一次執行會問是否要建立 `gh-pages` 分支，輸入 `Y` 即可；之後不再詢問。

## 「Open in Colab」按鈕怎麼運作

按鈕連到：

```text
https://colab.research.google.com/github/Benjamin-Teng/learn-python-with-ai/blob/main/index.ipynb
```

Colab 會直接讀取本 repo `main` 分支上的 `index.ipynb`。因此**只要把更新後的 `index.ipynb` 推上 GitHub `main`，Colab 看到的就是最新版**。注意 repo 必須維持 **public**，Colab 才能讀取。

## 常見問題

- **改了內容但網站沒更新？** 確認有跑 `quarto publish gh-pages`，並等 1～2 分鐘讓 GitHub Pages 重建。
- **`quarto` 指令找不到？** 重開一個新的終端機（讓 PATH 生效），或重新安裝 Quarto。
- **想換主題 / 調整版面？** 改 `_quarto.yml` 的 `theme` 與 `format.html` 設定，可選主題見 <https://quarto.org/docs/output-formats/html-themes.html>。
