require 'rails_helper'

describe Admin::ArticleThemesController do
  describe 'GET index' do
    let(:themes) { create_list :article_theme, 3 }
    it 'assings themes' do
      get :index
      expect(assigns :themes).to be
    end
  end
  describe 'GET show' do
    let(:theme) { create :article_theme }
    it 'assign theme' do
      get :show, id: theme.id
      expect(assigns :theme).to be
    end
  end
  describe 'GET new' do
    it 'assigns new theme' do
      get :new
      expect(assigns :theme).to be_a_new(ArticleTheme)
    end
  end
  describe 'POST create' do
    it 'create theme and redirect to index' do
      post :create, article_theme: {
        page_attributes: attributes_for(:page)
      }
      expect(flash[:notice]).to have_content(/created/i)
    end
  end
  describe 'PUT update' do
    let(:theme) { create :article_theme }
    it 'update theme' do
      put :update, id: theme.id, article_theme: { page_attributes: attributes_for(:page) }
      expect(flash[:notice]).to have_content(/updated/i)
      expect(response).to redirect_to([:admin, theme])
      expect { theme.reload }.to change { theme.page.title }
    end
  end
  describe 'POST sort' do
    let(:themes) { create_list :article_theme, 2 }
    it 'put themes in desired order' do
      first = themes.first
      second = themes.second
      expect {
        expect {
          post :sort, id: first.id, position: 2
          first.reload
          second.reload
        }.to change { second.position }.from(2).to(1)
      }.to change { first.position }.from(1).to(2)
      expect(response).to be_success
    end
  end
  describe 'DELETE' do
    it 'destroy theme' do
      theme = create :article_theme
      expect {
        xhr :delete, :destroy, id: theme.id
        theme.reload
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
    it 'flash error if theme has articles' do
      theme = create :article_theme_with_articles
      xhr :delete, :destroy, id: theme.id
      expect(flash[:error]).to have_content(/forbidden/i)
    end
  end
end
