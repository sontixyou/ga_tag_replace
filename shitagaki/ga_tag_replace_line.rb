#  1行の中に複数のGA タグを全て置換する最小単位のコード

require 'byebug'

line = "<!--広告店舗開始-->\n\n<h3>関西圏なら即日出張買取可能なTU-Field</h3>\n\n<a href=\"https://tu-field.jp/\" target=\"_blank\" onclick=\"ga(\'send\', \'event\', \'記事ページ99999\',\'TU-Field_2545\', \'店舗画像\', {\'nonInteraction\': 1})\"><img src=\"https://uridoki.net/topics/wp-content/uploads/TU_top-1.png\" alt=\"TUFiled店舗画像1\" width=\"640\" height=\"350\" class=\"alignnone size-full wp-image-137927\" /></a>\n<a href=\"https://tu-field.jp/\" target=\"_blank\" onclick=\"ga(\'send\', \'event\', \'記事ページ1111\',\'TU-Field_2545\', \'店舗画像下テキストリンク\', {\'nonInteraction\': 1})\">▶TU fieldのサイトはこちら</a>\n\n"


GA_TAG_REGEX = /onclick=\"ga\([a-zA-Z0-9ぁ-んーァ-ヶーｱ-ﾝﾞﾟ一-龠!"#$%&'()*+-.,\/:;<=>?@\[\]^_`{|}~ 　]+\)\"/.freeze

result = line.gsub(GA_TAG_REGEX) {|matched|
  before_replace_text_array = matched.split(',')
  #  3番目の要素に eventを入れ込む
  before_replace_text_array.insert(3, "\'click\'")
  # noninteraction の一つ前に要素を削除する
  before_replace_text_array.delete_at(5)
  replace_text_store = before_replace_text_array.join(",")
  #  バックスラッシュ付き' とバックスラッシュ付き " を入れ込む
  result = replace_text_store.gsub!("'", /\\'/.source).gsub!("\"", /\\"/.source)
}

puts result
