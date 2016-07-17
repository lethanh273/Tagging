class CommentsController < ApplicationController
	def create
		if params[:post_id]
			@post = Post.find(params[:post_id])
			Comment.limit_recent_comment_by_post @post.id
			@comment = @post.comments.create(params[:comment].permit(:name, :body))
			respond_to do |format|
      			format.html { redirect_to post_path(@post)}
      			format.js
    		end
		elsif params[:article_id]
			@article = Article.find(params[:article_id])
			Comment.limit_recent_comment_by_article @article.id
			@comment = @article.comments.create(params[:comment].permit(:name, :body))
			respond_to do |format|
      			format.html { redirect_to article_path(@article)}
      			format.js
    		end
    	end
	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy

		redirect_to post_path(@post)
	end
end
