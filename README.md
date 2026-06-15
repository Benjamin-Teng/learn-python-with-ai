# 用 AI 學寫 Python — 教學網站

給程式零基礎者（期貨營業員）的中文 Python 教學講義，從 Python 基礎一路帶到用 Streamlit 架起自己的網站。本專案用 [Quarto](https://quarto.org) 把講義 notebook 渲染成教學網站，部署在 GitHub Pages。

- 🌐 **線上閱讀**：<https://benjamin-teng.github.io/learn-python-with-ai>
- 📓 **唯一來源**：`index.ipynb`（你只要維護這一個檔案）
- ▶️ **動手執行**：網站每個重點章節有「Open in Colab」按鈕，另開分頁即可實際跑程式

## 檔案結構

```text
.
├── index.ipynb        # 講義內容（唯一來源，也是 Colab 開啟的檔案）
├── _quarto.yml        # 網站設定（主題、左側目錄、搜尋、執行程式碼顯示輸出）
├── custom.scss        # 主題微調（CJK 字型、配色、程式碼區塊、左側目錄樣式）
├── preview.ps1        # 一鍵本機預覽
├── publish.ps1        # 一鍵重新發布
├── pyproject.toml     # uv 專案依賴（jupyter，供渲染時執行 notebook 用）
├── uv.lock            # uv 鎖定的確切版本（讓環境可重現）
├── README.md          # 本說明
├── _site/             # 渲染輸出（自動產生，不需手動編輯，已 gitignore）
└── docs/              # 設計文件
```

## 前置（第一次接手這個專案時做一次）

需要兩樣工具：**Quarto**（渲染網站）和 **uv**（管理執行 notebook 用的 Python 環境）。

```powershell
# 1) 安裝 Quarto（Windows）
winget install --id Posit.Quarto -e
# 2) 安裝 uv（若還沒有）
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
# 3) 還原 Python 環境（會依 uv.lock 建好 .venv，含 jupyter）
uv sync
```

> macOS 的 Quarto：`brew install --cask quarto`。裝完開「新的」終端機，`quarto --version` 確認。

## 日常工作流程

### 1. 更新內容

直接編輯 `index.ipynb`（用 Jupyter、VS Code，或任何 notebook 編輯器）。**改完存檔就好**——發布時 Quarto 會自動執行程式碼、把最新輸出印到網頁上，你不必手動跑。

> 想讓某一格「不要執行」或「故意顯示錯誤」，在那格最上面加一行 `#| eval: false`（不執行）或 `#| error: true`（顯示錯誤）。

### 2. 本機預覽（邊改邊看）

```powershell
.\preview.ps1
```

會自動開瀏覽器，存檔 `index.ipynb` 後畫面即時更新。按 `Ctrl+C` 結束。

### 3. 重新發布到網路上

```powershell
.\publish.ps1
```

會：本機執行 notebook → 渲染 → 推送到 `gh-pages` 分支 → GitHub Pages 自動更新（約 1～2 分鐘後生效）。第一次會問 `Update site at ...?`，輸入 `Y` 即可。

> **為什麼用 `.ps1` 腳本而不是直接打 `quarto preview`？**
> 因為這個資料夾名稱是中文，而「執行 notebook」時 Quarto 啟動 Python 會被中文路徑卡住。
> 兩支腳本已幫你設好 UTF-8 環境並啟用 `.venv`，所以直接用它們最省事。

## 「Open in Colab」按鈕怎麼運作

按鈕連到：

```text
https://colab.research.google.com/github/Benjamin-Teng/learn-python-with-ai/blob/main/index.ipynb
```

Colab 會直接讀取本 repo `main` 分支上的 `index.ipynb`。因此**只要把更新後的 `index.ipynb` 推上 GitHub `main`，Colab 看到的就是最新版**。注意 repo 必須維持 **public**，Colab 才能讀取。

## 常見問題

- **改了內容但網站沒更新？** 確認有跑 `.\publish.ps1`，並等 1～2 分鐘讓 GitHub Pages 重建（瀏覽器可能要強制重新整理 `Ctrl+F5`）。
- **`quarto` 指令找不到？** 重開一個新的終端機（讓 PATH 生效），或重新安裝 Quarto。
- **發布時出現「找不到 python」之類錯誤？** 多半是沒先 `uv sync`，或沒用 `.\publish.ps1`（少了 UTF-8／`.venv` 設定）。
- **想換主題 / 調整版面？** 改 `_quarto.yml` 的 `theme` 或 `custom.scss`，可選主題見 <https://quarto.org/docs/output-formats/html-themes.html>。
```
