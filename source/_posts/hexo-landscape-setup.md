---
title: hexo デフォルトのlandscapeテーマのバナー画像を変更する
date: 2022-11-04 00:08:30
categories:
- hexo
tags:
- 
---

## 概要
変更方法は出てくるけどデフォルトの場合どこに画像置けばいいんだとなった

## 方法
ルートディレクトリで以下 theme の clone を行ったあと
```
git clone --depth 1 https://github.com/hexojs/hexo-theme-landscape themes/landscape
```

以下 PATH に置き換えたい画像を配置して
`themes/landscape/source/css/images/`

そのあとの変更は[こちら](https://al-batross.net/2019/12/26/hexo-change-banner/)を参考にさせていただきました。

ローカル確認段階なので、 `hexo clean && hexo generate` はやっておりません
