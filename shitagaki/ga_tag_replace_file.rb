#  外部ファイルから読み込み、GA タグを全て置換するコード
require 'byebug'

GA_TAG_REGEX = /onclick=\\\"ga([a-zA-Z0-9ぁ-んーァ-ヶーｱ-ﾝﾞﾟ一-龠!"#$%&'()*+-.,\/:;<=>?@\[\]^_`{|}\\~ 　]{0,100})\\\"/.freeze

require 'fileutils'
start_time = Time.now
# path = './plus_post_short.txt'
path = './post_from_db.txt'
temp_file = File.new('plus_tmp.sql', "w")
File.open(path, 'r').each_line do |read_line|
  read_line.gsub!(GA_TAG_REGEX) {|matched|
    before_replace_text_array = matched.split(',')
    #  3番目の要素に eventを入れ込む
    before_replace_text_array.insert(3, "\\\'click\\\'")
    # noninteraction の一つ前に要素を削除する
    before_replace_text_array.delete_at(5)
    replace_text_store = before_replace_text_array.join(",")
  }
  temp_file.puts(read_line)
end

temp_file.close
FileUtils.mv(temp_file.path, path)

puts "処理にかかった時間: #{Time.now - start_time}" # 手元では、0.02秒くらい
