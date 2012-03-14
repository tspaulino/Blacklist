class Keyword
  include MongoMapper::Document

  key :word, String

  validates_presence_of :word
  validates_uniqueness_of :word

  LEET_BASE = {
      a: "@|4",
      b: "8",
      c: "c",
      d: "d",
      e: "3",
      f: "(ph)",
      g: "6",
      h: "#",
      i: "!|1",
      j: "j",
      k: "X",
      l: "1|7",
      m: "m",
      n: "n",
      o: "0",
      p: "9",
      q: "q",
      r: "r",
      s: "5",
      t: "7",
      u: "v",
      v: "v",
      w: "(vv)",
      x: "x",
      y: "Y",
      z: "2"
  }
	
  def self.to_regex
    result = all.collect{|item|
      item.word.gsub(/./i) {
          |key| "(#{key}+|#{translate(key)})"
      }.insert(0, "\\b(") << ")\\b"
    }.join("|")
    result
  end

  def self.translate(key)
    LEET_BASE[key.to_sym]
  end

  def self.moderate(comment)
    comment.text.gsub!(/#{self.to_regex}/i, 'xxxx')
    comment
  end

end
