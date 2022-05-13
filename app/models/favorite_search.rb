class FavoriteSearch < ApplicationRecord
  belongs_to :user
  has_many :search_tags
  has_many :tags, through: :search_tags

  def tags_list
    tags.map{|tag| tag.name}
  end
end
