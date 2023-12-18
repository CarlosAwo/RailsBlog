class Article < ApplicationRecord
  has_many :comments

  def direct_comments
    comments.where(parent_comment: nil)
  end

end
