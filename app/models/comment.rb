class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true

  has_many :sub_comments, as: :commentable, class_name: 'Comment', foreign_key: 'parent_comment_id'
  belongs_to :parent_comment, class_name: 'Comment', foreign_key: 'parent_comment_id', optional: true
end
