require 'spec_helper'

describe Keyword do

  context "validating model attributes" do

    before(:each) do
        @keyword = Keyword.new(:word => "awesome")
    end

    it "should not create without a word" do
      @keyword.save.should be_true
    end

    it "should not duplicate a word on blacklist" do
      @keyword.save.should be_true
      @new_keyword = Keyword.new(:word => @keyword.word)
      @new_keyword.save.should be_false
    end

  end

  context "validating scopes" do
    before do
      @keywords = ["testing", "another test", "awesome test", "testing again"]
      @keywords.each do |word|
        Keyword.create(:word => word)
      end
    end

    it "should return a string with all the words" do
      @list = Keyword.blacklist
      @list.class.should == String      
      @list.include?(@kewords.to_s).should be_true      
    end    
  end
end
