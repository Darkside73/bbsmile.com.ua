require 'rails_helper'

describe CategoriesController do
  describe 'GET show' do
    context 'when category found' do
      let(:category) { create :category }
      it 'assings category' do
        get :show, slug: category.url
        assigns(:category).should be_a(Category)
        should render_template(:show)
      end
    end

    context 'when category not found' do
      it 'raise error' do
        expect { get :show, slug: "oh no! I'm not exist" }.to raise_error
      end
    end
  end
end
