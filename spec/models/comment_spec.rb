require 'spec_helper'

describe Comment do
  
  before(:each) do
  	@comment = Comment.new(:text => "awesome comment")  	
  end

  context "validating model attributes" do

  	it "should create with valid attributes" do
  		@comment.save.should be_true
  	end

  	it "should not create without a text" do
  		@comment.text = nil
  		@comment.save.should be_false  		
  	end
  end
end
