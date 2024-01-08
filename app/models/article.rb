class Article < ApplicationRecord
  has_one_attached :picture

  has_many :comments, -> { where(parent_comment: nil) }

  validates :picture, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..(2.megabytes) }

  def picture_url
    picture.attached? ? Rails.application.routes.url_helpers.rails_blob_path(picture, only_path: true) : '/default_featured_article.jpg'
  end

end
