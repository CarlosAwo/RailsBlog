class ArticleDecorator < ApplicationDecorator
  delegate_all

  def display_resume
    "#{content.slice(0, 100)} ..."
  end

  def author_avatar_url
    user.avatar_url
  end

  def display_publication_date
    created_at.strftime("%B %d, %Y")
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
