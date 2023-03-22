---
title: pandas の値操作のメモ
date: 2023-03-01 00:23:36
categories:
- Python
tags:
- pandas
---

## 概要
pandas は超便利です

pandas で解釈した dataframe の操作に関するメモをまとめます

思い出したら定期的に追記していきます

### 抽出
例：数字含む内容なら
{% codeblock サンプル lang:python %}
print(df["キー名"].str.extract(r"(\d.+)"))
{% endcodeblock %}


