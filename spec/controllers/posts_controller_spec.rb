require "rails_helper"

describe PostsController do
  include Devise::TestHelpers

  render_views

  describe "GET 'show'" do
    
    before(:each) do
      @post = Factory(:post)
    end
  
    it "should be successful" do
      get :show, :id => @post
      expect(response).to be_success
    end
    
    it "should have the right title" do
       get :show, :id => @post
       expect(response.body).to have_content(@post.title)
    end
  end
  
  describe "POST 'create'" do

    describe "failure" do
      
      before(:each) do
      	@user = Factory(:user)
        @attr = { :title => "", :body => "" }
      end

      it "should render the 'new' page" do

      	test_sign_in(@user)
        post :create, :post => @attr
        expect(response).to render_template('new')
      end

      it "should not create a user" do

      	test_sign_in(@user)
        lambda do
          post :create, :post => @attr
        end.should_not change(Post, :count)
      end
    end

    describe "success" do

      before(:each) do
      	@user = Factory(:user)
        @attr = { "title" => "thanh", "body" => "gresh","tag_list" => "aaaaa"}
      end

      it "should create a post" do
		test_sign_in(@user)
    	expect {
          post :create, :post => @attr
        }.to change(Post, :count).by(1)
      end
    end
  end
end
