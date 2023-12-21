class Comment < ApplicationRecord
  belongs_to :article

  has_many :sub_comments, class_name: 'Comment', foreign_key: 'parent_comment_id'
  belongs_to :parent_comment, class_name: 'Comment', foreign_key: 'parent_comment_id', optional: true

  def parent_comment?
    parent_comment.nil?
  end 
  def sub_comment?
    !parent_comment?
  end
end
