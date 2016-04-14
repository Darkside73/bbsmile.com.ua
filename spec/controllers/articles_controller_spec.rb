require 'rails_helper'

describe ArticlesController do
  describe 'GET show' do
    let(:article) { create :article }
    it 'assings article' do
      get :show, params: { slug: article.url }
      expect(assigns :article).to eq(article)
      expect render_template(:show)
    end
  end
end
