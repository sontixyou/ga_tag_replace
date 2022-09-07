# GAタグの置換

## 下準備

コードを確認する際には、Ruby3.1.2をインストールしてください。処理速度重視のため、Ruby3にしています。

```sh
rbenv install '3.1.2'
ruby -v # 3.1.2
```

## GAタグ単体を置換する

`tag_replace_for_share/ga_tag_replace.rb`

実行コマンド

```sh
ruby ga_tag_replace.rb
```

## 1行に複数のGAタグがある時、タグ全てを置換する

`tag_replace_for_share/ga_tag_replace_line.rb`

```sh
ruby ga_tag_replace_line.rb
```

## 外部ファイルから読み込んで、GAタグを置換する

`plus-staging-dump_20220906_test.sql`を`replace_ga_tag_from_file_and_write_sql.rb`と同じディレクトリに置いてください。

```sh
ruby replace_ga_tag_from_file_and_write_sql.rb
```

これを実行すると、「INSERT INTO `nt_posts` VALUES 」の文字列がある行のGAタグを置換して、外部ファイルへ書き出します。
「INSERT INTO `nt_posts` VALUES 」の文字列がない行は、そのまま外部ファイルへ書き出す。
