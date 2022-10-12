# 動作確認する際は、%%%が入っている行をコメントアウトすること

# 外部ファイルから読み込み、GA タグを全て置換するコード
require 'byebug'
require 'fileutils'

# gaタグの中身の文字数が150文字以上ある場合、置換できなくなる。
# もし、文字数上限なくすと、gsub!でマッチしないgaタグが存在するため、上限を設定している。
# この上限は、もう少し上げてもいいかもしれない。
GA_TAG_REGEX = /onclick=\\\"ga(.{0,150})\\\"/.freeze

start_time = Time.now

# 本番では、SQLファイルを読み込む。
path = '../plus-staging-dump.20221005.sql'

# 「ダンプファイルを1行ずつ読み込んで、書き込む」の繰り返しができないので、書き込み先のファイルを用意する。
output_file = File.new('output_plus_dump.sql', "w")

# 動作確認用ファイル用意
# %%%matched_text_file = File.new('../replace_ga_tag_before_and_after/matched_texts.txt', "w")
# %%%replaced_text_file = File.new('../replace_ga_tag_before_and_after/replaced_texts.txt', "w")

File.open(path, 'r').each_line do |read_line|
  if !read_line.include?('INSERT INTO `nt_posts` VALUES ')
    output_file.puts(read_line)
    next
  end

  # 1行の中に、複数のGAタグをある場合、すべてのGAタグを置換する。
  read_line.gsub!(GA_TAG_REGEX) { |matched_text|
    # %%%matched_text_file.puts(matched_text)
    text_array_before_replace = matched_text.split(',')
    # 3番目の要素に \'click\' を入れ込む
    text_array_before_replace.insert(3, " \\\'click\\\'")
    # noninteraction の1つ前の要素を削除する
    text_array_before_replace.delete_at(5)
    replaced_text = text_array_before_replace.join(",")
    # %%%replaced_text_file.puts(replaced_text)
  }

  # GAタグの置換完了したINSERT INTOのSQL文をファイルへ書き込む。
  output_file.puts(read_line)
end

# 書き込み先のファイルを保存するようにする。
output_file.close

puts "処理にかかった時間: #{Time.now - start_time}"
