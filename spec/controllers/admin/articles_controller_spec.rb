require 'rails_helper'

describe Admin::ArticlesController do
  describe 'GET new' do
    let(:theme) { create :article_theme }
    it 'assigns new article' do
      get :new, params: { article_theme_id: theme.id }
      expect(assigns :article).to be_a_new(Article)
      expect(assigns(:article).theme).to eq(theme)
    end
  end
  describe 'POST create' do
    let(:theme) { create :article_theme }
    it 'create article' do
      post :create,
        params: {
          article_theme_id: theme.id, article: {
            page_attributes: attributes_for(:page),
            content_attributes: attributes_for(:content)
          }
        }
      expect(flash[:notice]).to have_content(/created/i)
    end
  end
  describe 'PUT update' do
    let(:article) { create :article }
    it 'update article' do
      put :update,
        params: {
          id: article.id, article: {
            page_attributes: attributes_for(:page),
            content_attributes: attributes_for(:content)
          }
        }
      expect(flash[:notice]).to have_content(/updated/i)
      expect redirect_to([:admin, article.theme])
      expect { article.reload }.to change { article.page.title + article.content.text }
    end
  end
  describe 'DELETE' do
    it 'destroy article' do
      article = create :article
      expect {
        delete :destroy, xhr: true, params: { id: article.id }
        article.reload
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
