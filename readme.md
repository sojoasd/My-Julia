# Julia Technical Sharing 

## Julia 特色
- 弱型別、強型別混用
- 設計目的是為了提供接近 C 語言的性能
- 支援 JIT, AOT 兩種編譯方式，彼此效能差異很大
    - AOT 編譯就是 Julia 效能好的原因
    - JIT 編譯是一般高階語言的編譯模式
- 很適合處理數值運算、圖表繪製、機器學習等
- 很冷門、很難找到相關資源

## 說明 Julia 的運作
- 依據 [CI/CD pipeline](https://github.com/sojoasd/My-Julia/blob/main/.github/workflows/action.yml) 的測試 Package、發布 Package、產生 dylib 檔案三部分，說明 Julia 的運作

### 測試 Package (pkg-test job)
- 目的: 測試 package 功能是否正常、顯示未涵蓋的部分
- 呼叫```testPkgCoverage.jl```進行測試，列出未涵蓋的檔案與行數
    - [範例連結](https://github.com/sojoasd/My-Julia/actions/runs/11159140906/job/31016931373)
    - 未涵蓋資訊: ```File: src/PlotsOperator.jl, Uncovered lines: [3]```
    - ```generate_coverage(pkgName)```預設測試入口```/test/runtests.jl```
    - 這裡的沒有使用 @test macro
- ```runtests.jl``` 檔案的意義不僅僅是測試，AOT 編譯會依據測試涵蓋部分進行編譯

### 發布 Package (pkg-register job)
- 目的: 發布 Package 到 Registry (Repo)
- 呼叫 ```registerPkg.jl``` 發布 package
    - 因 github actions 的 julia 機器無權限存取 github repo，所以 repo url 必須使用 https 且需要夾帶 token (secrets)
- 發布完成會出現
    - Registry.toml: 註冊資訊，所有 package 註冊清單
    - [{Index}/{PkgName} 路徑](https://github.com/sojoasd/My-Julia/tree/main/P/PlotsOperator): package 詳細資訊，包含[版本清單](https://github.com/sojoasd/My-Julia/blob/main/P/PlotsOperator/Versions.toml)
- 任何地方都可以加入 Registry (Repo url)，選擇版號進行 add pkg，但注意```Repo url```必須是夾帶 token 的 https url，如 generateDylib.jl 的 ```registryPrivateRepoUrl```

### 產生 dylib 檔案 (dylib-generate job)
- 目的: 進行 AOT 編譯，產生 dylib 檔案
- 呼叫 ```generateDylib.jl``` 進行 AOT 編譯
    - ```precompile_execution_file``` 參數為 runtests.jl 的路徑，必須執行測試，測試涵蓋率會影響 AOT 編譯完整度
- job log 可以用關鍵字查詢三種編譯模式的執行結果
    - ```test uncompiled```: 未進行編譯狀態下測試
    - ```test JIT compile```: 已 JIT 編譯狀態下測試
    - ```test AOT compile```: 已 AOT 編譯狀態下測試
    - [範例連結](https://github.com/sojoasd/My-Julia/tree/main/PlotsOperator): [job log](https://github.com/sojoasd/My-Julia/actions/runs/11147980242/job/30983732176)
        - uncompiled: 6.5 秒、消耗 138 MB 記憶體
        - JIT compile: 0.9 秒、消耗 126 MB 記憶體
        - AOT compile: 0.04 秒、消耗 3 MB 記憶體

## 三個 Package 簡單說明，並比較效能差異
- [PlotsOperator](https://github.com/sojoasd/My-Julia/tree/main/PlotsOperator): 用來繪製[圖表](https://github.com/sojoasd/My-Julia/blob/main/PolarPlots.png)
    - 效能差異大

- [FindRoot](https://github.com/sojoasd/My-Julia/tree/main/FindRoot): 用來找出函數的根，繪製[圖表](https://github.com/sojoasd/My-Julia/blob/main/polynomial_plot.png)
    - 效能差異不大

- [MatrixOperator](https://github.com/sojoasd/My-Julia/tree/main/MatrixOperator): 用來進行矩陣運算
    - 效能幾乎一樣(猜測是因為矩陣運算已經被優化過，就算 AOT 編譯也無法再進行優化)

