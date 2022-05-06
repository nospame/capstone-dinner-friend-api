class TagsController < ApplicationController
  def index
    @tags = Tag.all
    render template: "tags/index"
  end
end
