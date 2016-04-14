require 'rails_helper'

describe CategoriesController do
  describe 'GET show' do
    context 'when category found' do
      let(:category) { create :category }
      it 'assings category' do
        get :show, params: { slug: category.url }
        expect(assigns :category).to be_a(Category)
        expect render_template(:show)
      end
    end

    context 'when category not found' do
      it 'raise error' do
        expect { get :show, params: { slug: "oh no! I'm not exist" } }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
