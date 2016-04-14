require 'rails_helper'

describe PagesController do
  describe 'GET show' do
    context "when template found" do
      it 'render template' do
        get :show, params: { slug: 'shipping' }
        expect render_template(:shipping)
      end
    end

    context "when page found by old url" do
      let(:page) { create :page, url_old: 'old/url' }
      it "redirect to page actual url" do
        get :show, params: { slug: page.url_old }
        expect(response.code).to eq('301')
      end
    end

    context 'when page not found' do
      it 'raise RoutingError' do
        expect { get :show, params: { slug: "oh no! I'm not exist" } }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
