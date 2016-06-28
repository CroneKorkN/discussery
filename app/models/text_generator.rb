class TextGenerator
  def self.text size=rand(10)+1
    sentences = []
    size.times do
      sentences << sentence(rand(8))
    end
    sentences.join(" ")
  end
  
  def self.sentence size
    sentence = []
    (size+1).times do
      sentence << word(rand(8))
    end
    return "#{sentence.join(' ')}.".capitalize
  end
  
  def self.word size
    word = ""
    (size+1).times do
      word += (97 + rand(26)).chr
    end
    word = word.capitalize if rand(3) == 1
    return word
  end
end
