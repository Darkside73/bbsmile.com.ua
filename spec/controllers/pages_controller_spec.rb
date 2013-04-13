require 'spec_helper'

describe PagesController do
  describe 'GET show' do
    context 'when page found' do
      let(:page) { create :page }
      it 'assings page' do
        get :show, slug: page.url
        assigns(:page).should be_a(Page)
        should render_template(:show)
      end
    end

    context 'when page not found' do
      it 'render template' do
        get :show, slug: 'information'
        should render_template(:information)
      end

      it 'raise error if template not found' do
        expect { get :show, slug: "oh no! I'm not exist" }.to raise_error
      end
    end
  end
end