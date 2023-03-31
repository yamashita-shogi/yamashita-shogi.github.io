---
title: github に push できない場合はステータスページをまず見よう
date: 2023-03-28 19:15:35
categories: github
tags:
---

## 概要
![2023/03/27 の内容](/images/github_incident.png)

## 内容
昨日以下のような表記で github に push できない事象が起きまして、かなり慌てました
```
$ git push origin HEAD
Enumerating objects: 18, done.
Counting objects: 100% (18/18), done.
Delta compression using up to 8 threads
Compressing objects: 100% (8/8), done.
Writing objects: 100% (10/10), 1.57 KiB | 1.57 MiB/s, done.
Total 10 (delta 5), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (5/5), completed with 4 local objects.
remote: fatal error in commit_refs
To github.com:hoge/fuga.git
 ! [remote rejected] HEAD -> hoge (failure)
```

なにか自分のミスではないかという思考でいろいろローカルを見てたのですが、一向に解消せず。

結果、github で障害が起きていたことを知りました。

なかなか github の障害にあたることが無かったのでいい機会になりました。

まずはステータスを見てみようということですね。以下から確認できます。
https://www.githubstatus.com/
