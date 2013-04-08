require 'spec_helper'

describe PagesController do
  describe 'GET show' do
    context 'when page found' do
      let(:page) { create :page }
      it 'assings page' do
        get :show, page: page.url
        assigns(:page).should be_a(Page)
        should render_template(:show)
      end

      let(:category) { create :category, children_count: 3 }
      it 'assings category' do
        get :show, page: category.url
        assigns(:category).should be_a(Category)
        should render_template('categories/show')
      end
    end

    context 'when page not found' do
      it 'render template' do
        get :show, page: 'information'
        should render_template(:information)
      end

      it 'raise error if template not found' do
        expect { get :show, page: "oh no! I'm not exist" }.to raise_error
      end
    end
  end
end