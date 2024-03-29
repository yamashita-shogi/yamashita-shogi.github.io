---
title: CloudRun Job が動かない
date: 2023-03-24 00:08:51
categories:
- GCP
tags:
- CloudRun
---

## 概要
2022 年の 9 月時点くらいの話です

multistage build で alpine -> alpine な dokcer image を、CloudRun Job で動かそうとした場合動かなかったというメモになります

結果的に CloudRun Job では動かないまま諦めて、同じイメージを Fargate に持っていったら動いたので CloudRun Job は諦めて謎のままになっています

## 内容
* もともとは alipine -> busybox な multistage docker image でしたが、そのイメージだと CloudRun Job は動く

* 概要の通りアプリ実行環境に alpine を採用するとコンテナが起動できなくなる

* 具体的に言うと、secret manager をマウントしていましたが、それがマウントできないようになったことでアプリが動かなくなってました

* busybox だとマウントできてる
  * ここが理解できなかったところ
  * OS を変えたらマウントできないとは・・？

* ubuntu でもだめ

* 確認できたエラー
```
container start failed
```
```
Container called exit(255)
```

* secret manager の内容をファイルとして入れればローカルでも動く、CloudRun Job では動かない


## まとめ
alpine × secret manager という組み合わせが良くないということかもしれません。

また、現在（2023/03/24）でも CloudRun Job にはプレビューがついています

Fargate でイメージをそのまま移してそれが動いているので、自分のなにかミスで動いていないということは無いのでは…と思ってしまいましたが

ただ、もしかしたら重大な仕様とかそういうのを見落としてるのかもしれません

当時はあまり参考になる同じような事象の記事も特に見つかりませんでしたし結果諦めました

結果的には幸か不幸かマルチクラウド環境にすることができたので、色々幅広く試す土台ができたのは良かったなというところです

もし同じような状況で解決した人が居れば教えていただきたいです