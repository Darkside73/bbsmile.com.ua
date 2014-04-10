require 'spec_helper'

describe ArticlesController do
  describe 'GET show' do
    let(:article) { create :article }
    it 'assings article' do
      get :show, slug: article.url
      assigns(:article).should == article
      should render_template(:show)
    end
  end
end
