class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :post
  belongs_to :article

end
