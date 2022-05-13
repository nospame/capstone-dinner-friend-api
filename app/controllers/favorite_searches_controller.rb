class FavoriteSearchesController < ApplicationController
  def index
    @favorite_searches = FavoriteSearch.where(user_id: current_user.id)
    render template: 'favorite_searches/index'
  end

  def create
    @favorite_search = FavoriteSearch.find_or_create_by(
      user_id: current_user.id,
      search_term: params[:search_term]
    )
    render template: 'favorite_searches/show'
  end

  def destroy
    favorite_search = FavoriteSearch.find_by(search_term: params[:search_term], user_id: current_user.id)
    favorite_search.destroy
    render json: {message: "Ingredient removed."}
  end
end
