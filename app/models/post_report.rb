class PostReport < Struct.new(:word_count)
  def self.generate(post)
    word_count = post.content.split.map {|word| word.gsub(/\W/,'')}.count
    PostReport.new(word_count)
  end
end