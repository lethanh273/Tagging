class Article < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	validates :title, presence: true, length: {minimum: 5}
	validates :body,  presence: true
	has_many :taggings
	has_many :tags, through: :taggings

	def self.tagged_with(name)
        p "Duyensexy"
 		Tag.find_by_name!(name).articles
	end

	def self.tag_counts
  		Tag.select("tags.*, count(taggings.tag_id) as count").
    joins(:taggings).group("taggings.tag_id")
	end

	def tag_list
  		tags.map(&:name).join(", ")
	end

	def tag_list=(names)
  		self.tags = names.split(",").map do |n|
    		Tag.where(name: n.strip).first_or_create!
  		end
  	end
end
