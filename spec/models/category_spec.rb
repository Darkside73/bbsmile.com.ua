require 'spec_helper'

describe Category do
  context 'when save' do
    it 'create record with page' do
      expect {
        category = Category.create(
          leaf: true,
          page_attributes: { title: 'Some category', url: 'some/url' }
        )
      }.to change { Category.count }.by(1)
    end
    it 'not create record if invalid data' do
      category = build :category, page_attributes: { title: 'valid', url: '' }
      expect { category.save.should be_false }.not_to change { Category.count }
    end
    it 'update category title' do
      category = create :category
      old_title = category.page.title
      category.update_attributes page_attributes: attributes_for(:page)
      category.save.should be_true
      category.page.title.should_not == old_title
    end

    let(:leaf_category) { create :leaf_category }
    it "disallow set leaf parent" do
      category = build :category
      category.parent = leaf_category
      category.should have(1).error_on(:parent)
    end
  end
  context 'ancestry' do
    subject { Category }
    its(:arrange) { should respond_to :each }
    it 'create children' do
      category = create :category
      child = Category.new(
        parent: category,
        page_attributes: attributes_for(:page)
      )
      expect { child.save }.to change { category.children.count }
    end
  end
  context 'acts as list' do
    let(:category) { create :category, children_count: 2 }
    context 'when create new record' do
      it 'sorted to the end of the list' do
        subcategory = create :category, parent: category
        subcategory.position.should == 3
        subcategory.lower_items.should be_empty
      end
      # add another category as noise for testing sorting scope
      let(:another_category) { create :category, children_count: 2 }
      describe '#insert_at' do
        it 'create record in given position' do
          second_subcategory = category.children.second
          subcategory = create :category, parent: category
          subcategory.insert_at(2)
          subcategory.should_not be_a_new(Category)
          subcategory.position.should == 2
          expect { second_subcategory.reload }.to change {
            second_subcategory.position
          }.to(3)
          expect { another_category.reload }.not_to change {
            another_category.children.first
          }
        end
      end
    end
  end
  context 'when category is leaf' do
    describe 'save' do
      let(:leaf_category) { create :leaf_category }
      it 'not allow add children' do
        expect {
          create :category, parent: leaf_category
        }.to raise_error(ActiveRecord::ActiveRecordError)
        expect {
          leaf_category.reload
        }.not_to change { leaf_category.is_childless? }
      end
    end
  end
  describe '.destroy' do
    it 'allow destroy model' do
      category = create :category
      category.destroy
      expect { category.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
    it 'disallow destroy model with children' do
      category = create :category, children_count: 3
      expect { category.destroy }.to raise_error(Ancestry::AncestryException)
    end
  end
  describe "#products_grid" do
    let(:category) { category = create :category_with_products }
    it "sort by variant price descending" do
      products = category.products_grid(sort: :price, direction: 'desc')
      products.first.price.should be > products.second.price
    end
  end
end
