class Keyword
  include MongoMapper::Document

  key :word, String

  validates_presence_of :word
  validates_uniqueness_of :word
	
  def self.blacklist
   all.collect(&:word).to_s
  end
end
