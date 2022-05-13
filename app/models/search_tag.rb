class SearchTag < ApplicationRecord
  belongs_to :favorite_search
  belongs_to :tag
end
