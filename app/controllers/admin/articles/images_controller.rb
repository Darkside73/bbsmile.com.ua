class Admin::Articles::ImagesController < ApplicationController
  respond_to :json

  def create
    image = article.images.new
    image.attachment = params[:file]
    image.save
    respond_with image.as_json.merge({delete_url: admin_image_path(image)}), location: article
  end

  private

  def article
    @article ||= Article.find params[:article_id]
  end
end
