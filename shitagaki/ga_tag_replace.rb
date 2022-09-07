# onclick=\"ga(\'send\', \'event\', \'記事ページ\',\'TU-Field_2545\', \'店舗画像\', {\'nonInteraction\': 1})\"
# 上記の文字列を下記のように置換する
# onclick=\"ga(\'send\', \'event\', \'記事ページ\',\'click\', \'TU-Field_2545\', {\'nonInteraction\': 1})\"

# GA タグを置換する最小単位のコード
text = "onclick=\"ga(\'send\', \'event\', \'記事ページ\',\'TU-Field_2545\', \'店舗画像\', {\'nonInteraction\': 1})\""
puts "#{text: text}"

text_after_replace = "onclick=\"ga(\'send\', \'event\', \'記事ページ\',\'click\', \'TU-Field_2545\', {\'nonInteraction\': 1})\""

GA_TAG_REGEX = /onclick=\"ga\([a-zA-Z0-9ぁ-んーァ-ヶーｱ-ﾝﾞﾟ一-龠!"#$%&'()*+-.,\/:;<=>?@\[\]^_`{|}~ 　]+\)\"/.freeze

puts text.gsub(GA_TAG_REGEX) {|matched|
  before_replace_text_array = matched.split(',')
  #  3番目の要素に eventを入れ込む
  before_replace_text_array.insert(3, "\'click\'")
  # noninteraction の一つ前に要素を削除する
  before_replace_text_array.delete_at(5)
  replace_text_store = before_replace_text_array.join(",")
  #  バックスラッシュ付き' とバックスラッシュ付き " を入れ込む
  replace_text_store.gsub("'", /\\'/.source).gsub("\"", /\\"/.source)
}
