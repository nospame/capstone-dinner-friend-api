class FavoriteSearchesController < ApplicationController
  before_action :authenticate_user

  def index
    @favorite_searches = FavoriteSearch.where(user_id: current_user.id)
    render template: 'favorite_searches/index'
  end

  def create
    @favorite_search = FavoriteSearch.create(
      user_id: current_user.id,
      search_term: params[:q]
    )
    if params[:tags]
      params[:tags].each do |tag|
        SearchTag.create(
          favorite_search_id: @favorite_search.id,
          tag_id: Tag.find_by(name: tag).id
        )
      end
    end
    render template: 'favorite_searches/show'
  end

  def destroy
    favorite_search = FavoriteSearch.find_by(search_term: params[:q], user_id: current_user.id)
    search_tags = SearchTag.where(favorite_search_id: favorite_search.id)
    favorite_search.destroy
    search_tags.destroy
    render json: {message: "Favorite search removed."}
  end
end
