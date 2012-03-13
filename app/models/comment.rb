class Comment
  include MongoMapper::Document

  key :text, String

  validates_presence_of :text

end
