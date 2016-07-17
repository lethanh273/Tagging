require "rails_helper"

describe Comment do

  before(:each) do
    @post = Factory(:post)
    @attr = { :body => "lorem ipsum" }
  end
  
  it "should create a new instance with valid attributes" do
    @post.comments.create!(@attr)
  end
  
  describe "user associations" do
    
    before(:each) do
      @comment = @post.comments.create(@attr)
    end
    
    it "should have a post attribute" do
      @comment.should respond_to(:post)
    end
    
    it "should have the right associated post" do
      @comment.post_id.should == @post.id
      @comment.post.should == @post
    end
  end
  
  describe "validations" do

    it "should have a post id" do
      Comment.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @post.comments.build(:body => "    ").should_not be_valid
    end
  end

end
