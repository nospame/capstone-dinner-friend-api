class TagsController < ApplicationController
  def index
    @tags = Tag.all.order(:name)
    render template: "tags/index"
  end
end
