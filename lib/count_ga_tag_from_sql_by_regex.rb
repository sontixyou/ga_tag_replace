# 実行完了までに、15秒くらいかかる
require 'byebug'

ONCLICK_REGEX = /onclick=\\\"ga/.freeze

# 上と下でもカウント回数は変化しない
# GA_TAG_REGEX = /onclick=\\\"ga(.*)\\\"/.freeze
GA_TAG_REGEX = /onclick=\\\"ga(.*)/.freeze

GA_TAG_REGEX_HONBAN_20221005v1 = /onclick=\\\"ga([a-zA-Z0-9ぁ-んーァ-ヶーｱ-ﾝﾞﾟ一-龠!"#$%&'()*+-.,\/:;<=>?@\[\]^_`{|}\\~ 　]{0,150})\\\"/.freeze
GA_TAG_REGEX_HONBAN_20221005v2 = /onclick=\\\"ga(.{0,150})\\\"/.freeze

start_time = Time.now

# 本番では、SQLファイルを読み込む。
path = '../plus-staging-dump.20221005.sql'

onclick_counter, ga_tag_counter, honban_ga_tag_counter = 0, 0, 0

File.open(path, 'r').each_line do |read_line|
  next if !read_line.include?('INSERT INTO `nt_posts` VALUES ')

  # 1行の中に、複数のGAタグをある場合、すべてのGAタグを置換する。
  read_line.gsub!(ONCLICK_REGEX) { |matched_text|
    onclick_counter += 1
    matched_text_by_onclick_regex.puts(matched_text)
    matched_text
  }

  read_line.gsub!(GA_TAG_REGEX) { |matched_text|
    ga_tag_counter += 1
    matched_text
  }

  read_line.gsub!(GA_TAG_REGEX_HONBAN) { |matched_text|
    honban_ga_tag_counter += 1
    matched_text_by_ga_tag_regex_honban.puts(matched_text)
    matched_text
  }
end

puts "処理にかかった時間: #{Time.now - start_time}"
puts "onclick_counter: #{onclick_counter}"
puts "ga_tag_counter: #{ga_tag_counter}"
puts "honban_ga_tag_counter: #{honban_ga_tag_counter}"


# OUTPUTS
# 処理にかかった時間: 18.829566
# onclick_counter: 71143
# ga_tag_counter: 714
# honban_ga_tag_counter: 63741
