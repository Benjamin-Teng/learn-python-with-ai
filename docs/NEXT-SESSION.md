# 交接文件（NEXT SESSION）

> **上一棒**：把 7.4「開始前你需要兩樣東西」的 **GitHub 帳號**做成超連結（指向 <https://github.com/>，沿用本節既有的 `target="_blank"` 連結樣式）。進版 **v1.1.2**。
> **這一棒**：在有 Mac 時，對桌機 **Safari** 做一次跨瀏覽器實機驗證（見下）。

## 待辦：桌機 Safari 跨瀏覽器實機驗證

**背景**：站台靠 quarto-live + **Pyodide 0.28.1**（WebAssembly 版 Python）在讀者瀏覽器裡跑程式。桌機 **Chrome / Firefox / Edge** 在相容性分析上高信心可正常運行（Chrome/Firefox 都在 Pyodide 官方 CI 內持續測試）。唯一沒被 Pyodide CI 涵蓋的引擎是 **Safari（WebKit）**——支援但沒被持續驗證。不預期會壞，但值得實機點一次才安心。

### 5 分鐘 checklist

開線上網址 <https://benjamin-teng.github.io/learn-python-with-ai>，建議用 **Safari 16+（macOS Monterey 以上）**：

1. 隨便找一個程式格按 **Run Code**，確認有跑出結果（驗證 Pyodide 在 WebKit 載入成功；第一次按會等幾秒下載環境，屬正常）。
2. 捲動長頁，看左側「本頁目錄」的高亮會不會跟著章節走（驗證 `toc-scroll.html` + sticky CSS）。
3. 點 7.4 的「**GitHub 帳號**」連結，確認會在新分頁開啟 github.com。

### 已知限制（屬預期行為，不必當 bug 驗）

- **行動版 Safari / Chrome**：閱讀沒問題，但互動程式格在手機瀏覽器上不保證能跑（quarto 互動元件的已知限制），桌機才完整。
- **`input()` 阻塞式鍵盤輸入**：在 GitHub Pages 上**所有瀏覽器一律不可用**（缺 COOP/COEP 標頭、無 `SharedArrayBuffer`）。本講義是「貼程式碼按 Run」的型態、不依賴 `input()`，因此無影響。
