class Comment < ApplicationRecord
  has_many :sub_comments, class_name: 'Comment', foreign_key: 'parent_comment_id'
  has_many :likes, as: :likeable

  belongs_to :article
  belongs_to :user
  belongs_to :parent_comment, class_name: 'Comment', optional: true

  validates :body, presence: true

  def parent_comment?
    parent_comment.nil?
  end 
  def sub_comment?
    !parent_comment?
  end
end
