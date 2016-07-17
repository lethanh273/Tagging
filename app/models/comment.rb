class Comment < ActiveRecord::Base
  belongs_to :post
  validates :post_id, :presence => true
  validates :body, :presence => true

  before_save do 
  	 self.recent = true
  end
  @@recent_limit = 3

  def self.limit_recent_comment_by_post post_id
	  if (Comment.where("recent = ? and post_id = ?",true,post_id).count == @@recent_limit)
	  	c = Comment.where("recent = ? and post_id = ?",true,post_id).order(:id).first.update_column(:recent, false)
	  end
  end
  def self.limit_recent_comment_by_article article_id
    if (Comment.where("recent = ? and article_id = ?",true,article_id).count == @@recent_limit)
      c = Comment.where("recent = ? and article_id = ?",true,article_id).order(:id).first.update_column(:recent, false)
    end
  end
end
