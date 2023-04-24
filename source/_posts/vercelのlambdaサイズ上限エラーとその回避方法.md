---
title: vercel の lambda サイズ上限エラーとその回避方法
date: 2023-03-22 17:34:23
categories:
- vercel
---

## 概要
vercel 上に SSR をデプロイしていますが、少し前にデプロイした際、突然以下のエラーに遭遇しました。
```
Error: The Serverless Function "index" is 85.53mb which exceeds the maximum size limit of 50mb. Learn More: https://vercel.link/serverless-function-size
```

これの解消方法と調べたことを書きます


## 解消方法
まずは解消方法から書きます

`vercel.json` というデプロイの設定ファイルで指定するビルダーのバージョンを以下のように変更しました
```
"use": "@nuxtjs/vercel-builder"
↓
"use": "@nuxtjs/vercel-builder@0.21.3"
```


## 調べたこと、やってみたこと
以下のことを試しましたが効果なしでした
* 不要な画像の削除
* リージョンの変更
* 不要モジュールの見直し

解消法は [こちら](https://stackoverflow.com/questions/74235239/vercel-build-size-vs-local-build-size-is-different) から vercel-build の github issue にたどり着き、それらを参考にしました

もしかしたらもう治ってるかもしれませんが、バージョン固定をいつまでしてたらいいのかなど情報は追っておかないといけないかもしれませんね

ビルダーのバグでこんなことになってしまうんだと勉強になりました