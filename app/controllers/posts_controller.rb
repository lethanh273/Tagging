class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def index
		
		if params[:tag]
			@posts = Post.tagged_with(params[:tag])
			@articles = Article.tagged_with(params[:tag])
			render 'tags/index'
		else
			@posts = Post.includes(:comments).where(['comments.recent = ?', true]).references(:comment)
	    end
	    
	end

	def new
		@post = Post.new
	end

	def show
		@post = Post.find(params[:id])
	end

	def create
		@post = Post.new(post_params)

		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])

		if @post.update(params[:post].permit(:title, :body,:tag_list))
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy

		redirect_to posts_path
	end

	private

	def post_params
		params.require(:post).permit(:title, :body, :tag_list)
	end
end
