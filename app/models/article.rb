class Article < ApplicationRecord
  has_many :comments, -> { where(parent_comment: nil) }


end
