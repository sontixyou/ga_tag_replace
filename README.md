# GAタグの置換

## 下準備

1. コードを確認する際には、Ruby3.1.2をインストールしてください。処理速度重視のため、Ruby3にしています。

```sh
rbenv install '3.1.2'
ruby -v # 3.1.2
```

2. DBから記事ページのテーブルをダンプしてくる。

## 外部ファイルから読み込んで、GAタグを置換する

`plus-staging-dump_20220906_test.sql`を`replace_ga_tag_from_file_and_write_sql.rb`と同じディレクトリに置いてください。

```sh
$ cd this_repository/lib
# ダンプしたsqlファイルをthis_repository/libに保存する
$ ruby replace_ga_tag_from_file_and_write_sql.rb
```

これを実行すると、「INSERT INTO `nt_posts` VALUES 」の文字列がある行のGAタグを置換して、外部ファイルへ書き出します。
「INSERT INTO `nt_posts` VALUES 」の文字列がない行は、そのまま外部ファイルへ書き出す。
