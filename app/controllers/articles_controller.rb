class ArticlesController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def index
		if params[:tag]
			@articles = Article.tagged_with(params[:tag])
		else
			@articles = Article.includes(:comments).where(['comments.recent = ?', true]).references(:comment)
	    end
	end

	def new
		@article = Article.new
	end

	def show
		@article = Article.find(params[:id])
	end

	def create
		@article = Article.new(article_params)

		if @article.save
			redirect_to @article
		else
			render 'new'
		end
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])

		if @article.update(params[:article].permit(:title, :body,:tag_list))
			redirect_to @article
		else
			render 'edit'
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		redirect_to articles_path
	end

	private

	def article_params
		params.require(:article).permit(:title, :body, :tag_list)
	end
end
