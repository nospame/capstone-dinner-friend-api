class FavoriteSearchesController < ApplicationController
  def index
    @favorite_searches = FavoriteSearch.where(user_id: current_user.id)
    render template: 'favorite_searches/index'
  end

  def create
    @favorite_search = FavoriteSearch.find_or_create_by(
      user_id: current_user.id,
      search_term: params[:q]
    )
    if params[:tags]
      params[:tags].split(',').each do |tag|
        SearchTag.find_or_create_by(
          favorite_search_id: @favorite_search.id,
          tag_id: Tag.find_by(name: tag).id
        )
      end
    end
    render template: 'favorite_searches/show'
  end

  def destroy
    favorite_search = FavoriteSearch.find_by(search_term: params[:q], user_id: current_user.id)
    favorite_search.destroy
    render json: {message: "Ingredient removed."}
  end
end
