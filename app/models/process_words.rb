class ProcessWords < Struct.new(:word_string)
  def to_codes
    words.map do |english|
      word_codes(english)
    end
  end

  def words
    word_string.split(/\W+/)
  end

  def word_codes(english)
    word = find_word(english)
    return [] unless word
    Dictionary::Codes.new(word.phonetic).phonetics
  end

  def find_word(english)
    Persistence::Word.where(english: english.downcase).first
  end
end
