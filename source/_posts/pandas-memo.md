---
title: pandas の操作についてのメモ
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

## テーブルから dataframe の生成
{% codeblock サンプル lang:python %}
df = pd.read_html(str(table_html_source))
{% endcodeblock %}

### 抽出
例：特定のカラムで条件に合う行を抽出
{% codeblock サンプル lang:python %}
df = df[~(df["キー 1"].isna()) & ~(all["キー 2"] == 0)]
{% endcodeblock %}

`.isna` は数字かどうか、`==0` はそのままですね

`~` これで否定です

dataframe はなにかフィルター系の処理をしたら dataframe がまた返ってくるので、元のものを上書きするか、別で保持する必要があります

### 正規表現を使った抽出
例：特定のカラムで正規表現を使って抽出
{% codeblock サンプル lang:python %}
print(df["キー名"].str.extract(r"(\d.+)"))
{% endcodeblock %}

### 置換
{% codeblock サンプル lang:python %}
df = df["キー 1"].replace("あ", "", regex=True).astype(int)
{% endcodeblock %}

### 型の強制
{% codeblock サンプル lang:python %}
df = df["キー 1"].astype(int)
{% endcodeblock %}

置換とかをしたあとに意図したデータだけになっているかとかの確認で使ってます

異常値があれば置換だったりの不足に使えます