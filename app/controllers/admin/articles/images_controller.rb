class Admin::Articles::ImagesController < ApplicationController
  respond_to :json

  def create
    image = article.images.new
    image.attachment = params[:file]
    respond_with image, location: article
  end

  private

  def article
    @article ||= Article.find params[:article_id]
  end
end
