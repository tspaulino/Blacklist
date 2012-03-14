require 'spec_helper'

describe Keyword do

  context "validating model attributes" do

    before(:each) do
        @keyword = Keyword.new(:word => "awesome")
    end

    it "should create with valid attributes" do
      @keyword.save.should be_true
    end

    it "should not duplicate a word on blacklist" do
      @keyword.save.should be_true
      @new_keyword = Keyword.new(:word => @keyword.word)
      @new_keyword.save.should be_false
    end

    it "should not create without a word" do
      @keyword.word = nil
      @keyword.save.should be_false
    end

  end

  context "validating class methods" do

    before do
      @keywords = ["testing", "another test", "awesome test", "testing again"]
      @keywords.each do |word|
        Keyword.create(:word => word)
      end
    end

    it "should generate a regular expression with leet speak validation for all the keywords" do
      @regex = Regexp.new(Keyword.to_regex)
      @keywords.each do |word|
        @regex.match(word).should_not be_nil
      end
    end

    it "should filter keywords on a received comment using xxxx instead of the word or a leet version" do
      @comment = Comment.create(:text => "This comment should not show the cc0mm3nt word and continue commentable")
      Keyword.create(:word => "comment")
      @moderated_comment = Keyword.moderate(@comment)
      @moderated_comment.text.match(/\b(comment)\b/i).should be_nil
      @moderated_comment.text.match(/(xxxx)/).should_not be_nil
      @moderated_comment.text.match(/(commentable)/i).should_not be_nil
    end
  end

end
