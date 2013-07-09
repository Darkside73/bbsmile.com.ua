module Admin
  module Contentable
    extend ActiveSupport::Concern

    included do
      before_action :assign_content, only: [:edit, :update]
    end

    def create_for(contentable)
      @content = contentable.build_content content_params
      if @content.save
        redirect_to [:content, :admin, contentable],
                    notice: I18n.t('flash.message.content.saved')
      else
        render :new
      end
    end

    def update_content
      @content = Content.find params[:id]
      if @content.update content_params
        redirect_to [:content, :admin, @content.contentable],
                    notice: I18n.t('flash.message.content.saved')
      else
        render :edit
      end
    end

    def content_params
      params.require(:content).permit(:text)
    end

    def assign_content
      @content = Content.find params[:id]
    end
  end
end
