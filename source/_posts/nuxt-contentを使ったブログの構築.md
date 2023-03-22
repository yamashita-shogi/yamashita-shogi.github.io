---
title: nuxt/content を使ったブログの構築
date: 2022-11-08 16:39:35
categories:
- nuxt
tags:
---

## 使用するパッケージについて
markdown-it を最初使っていたのですが、build 後のスクリプトに未使用の部分が多くあり、それがページスコアの `time to interactive` に影響を及ぼしていたので nuxt/content に切り替えました。

切り替えたことで `time to interactive` と `First Contentful Paint` の向上が見られましたので、content が自分の使い方に合っていたということだと思いますが。


## 構築
nuxt/content を使って構築していくにあたり、以下を参考にさせていただきました🙇‍♂️
[Create Medium Style Blog Theme with Nuxt JS - Pramod Devireddy](https://domarpdev.github.io/blog/create-medium-style-blog-theme/)


content はこんな感じで入れます
{% codeblock lang:shell %}
npm i @nuxt/content
{% endcodeblock %}

ファイル構成はこんな形になります
```
├── content
│   └── blog
│       └── ほげ.md
├── pages
│   └── blog
│       ├── _slug.vue
│       └── index.vue
```

それぞれの役割は以下です

* content/blog/ほげ.md
  * markdown で書くブログ記事の内容
* pages/blog/index.vue
  * blog/ でアクセスしたときの一覧ページの vue ファイル
* pages/blog/_slug.vue
  * 各ブログ記事を出すための vue ファイル

blog 一覧ページには以下のような感じで $content を使って記事を検索し、その結果を vue で使うような形です
{% codeblock lang:js %}
<script>
export default {
  async asyncData ({ $content, params }) {
    const query = await $content("blog", params.slug).sortBy("createdAt", "desc")
    const blog = await query.fetch()
    return { blog }
  }
}
</script>
{% endcodeblock %}


content 情報が取れていれば、vue の方では例えば以下のような形で for をすることで記事の一覧を作ることができます。
{% codeblock lang:js %}
<v-card
  v-for="b of blog"
  :key="b.slug"
>
{% endcodeblock %}

こんな感じで構成が整えば `npm run dev` 等で `http://localhost:3000/blog/` などといった URL でアクセスできます。

記事一覧が出ているでしょうか？



## タグがついた記事の一覧表示
content 以下の markdown ファイルに以下のようにタグをつけることができます
```
---
title: hoge
tags:
  - ふが
---
```


こうやってつけたタグごとの一覧ページも出すことができます

ファイル構成はこんな感じになります
```
├── pages
│   └── blog
│       ├── tag
│       │    └── _slug
│       │          └── index.vue
│       ├── _slug.vue
│       └── index.vue
```

要は `pages/blog/tag/_slug/index.vue` の追加だけです。


中身はこんな形です
{% codeblock lang:js %}
<template>
  <v-container mt-50 pt-50>
    <h2
      class="my-4 mx-9"
      justify="center"
      align="center"
    >
      <v-icon>$tagOutlineIcon</v-icon>『{{ $route.params.slug }}』 のタグがついた記事
    </h2>
    <div class="d-flex flex-wrap">
        <v-card
          class="ma-6"
          elevation="5"
          v-for="b of blog"
          :key="b.slug"
          width="500"
        >
          <NuxtLink
            class="post-card"
            :to="{ name: 'blog-slug', params: { slug: b.slug } }"
          >
          </NuxtLink>
        </v-card>
    </div>

    <template v-if="blog.length === 0">
      <div class="d-flex flex-wrap justify-center fill-heilght">
        {{ $route.params.name }} に該当する記事はありませんでした
      </div>
    </template>

  </v-container>
</template>

<script>
export default {
  head() {
    return {
      title: this.$route.params.slug
    }
  },
  async asyncData ({ $content, params }) {
    const tag = params.slug
    const blog = await $content('blog')
      .only(['title', 'img', 'createdAt', 'slug'])
      .where({ tags: { $contains: tag } })
      .sortBy('createdAt', 'desc')
      .fetch()
    return { tag, blog };
  }
}
</script>

<style>
.post-card {
  text-decoration: none;
}
</style>
{% endcodeblock %}

こうすると、`http://localhost:3000/blog/タグA/` という URL で、タグ A のついた記事があれば一覧が出ますし、なければ『ありません』と出ます。


## まとめ
簡単にオリジナルのブログをつくれました。参考になる記事もたくさんあるので、構築もしやすいです。

ただ記事一覧の出し方やブログのレイアウトなど、細かい調整にある程度の知識も必要になり、自分はそこに時間をかけるのを避けたくて、代わりにこのブログを作り始めました。
（タグ一覧どこにどう出そうか、記事一覧もっと見やすくだしたいけどどっからどう着手したらいいか　などの部分）

勉強にはなったんですけどね。熱が出てきたらまた再開するかもしれませんが。


