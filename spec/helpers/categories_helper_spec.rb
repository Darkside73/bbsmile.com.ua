require 'spec_helper'

describe CategoriesHelper do
  describe "#category_menu_items" do
    context 'category with children assings' do
      let(:category) { create :category, children_count: 3 }
      before { assign(:category, category) }
      it "returns category children " do
        helper.category_menu_items.should == category.children
      end
      context "hidden children" do
        let(:category) {
          category = create(:category)
          category.children.create attributes_for(:hidden_category)
          category
        }
        it "it not include hidden categories " do
          helper.category_menu_items.should be_empty
        end
      end
    end

    context 'category without children assings' do
      let(:category) { create :category, children_count: 3 }
      before { assign(:category, category.children.second) }
      it "returns category siblings" do
        helper.category_menu_items.should == category.children
      end
    end
  end
end