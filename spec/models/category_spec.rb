require 'spec_helper'

describe Category do
  context 'tree behavior' do
    subject { Category }
    before { category = create :category, title: 'Category', subcategories: ['Subcategory'] }
    its(:arrange) { should respond_to :each }
  end
  context 'save' do
    it 'saves valid data' do
      category = build :category, title: 'Some category'
      expect { category.save.should be_true }.to change { Category.count }.by(1)
    end
    it 'does not save invalid data' do
      category = build :category
      expect { category.save.should be_false }.not_to change { Category.count }
    end
    before do
      @url = 'some/url'
      @category = create :category, title: 'Some category', url: @url
    end
    it 'not allow url duplication' do
      category = build :category, title: 'Some category', url: @url
      category.save.should be_false
    end
    it 'create children' do
      child = Category.new(title: 'Some category', url: Faker::Lorem.word, parent: @category)
      expect { child.save }.to change { @category.children.count }
      child.type.should == 'Category'
    end
  end
  context 'acts as list' do
    let(:category) { create :category, title: 'Category', subcategories: ['Subcategory 1', 'Subcategory 2'] }
    context 'create new record' do
      it 'sorted to the end of the list' do
        subcategory = Category.new(title: 'Subcategory 3', url: Faker::Lorem.word, parent: category)
        subcategory.save
        subcategory.position.should == 3
        subcategory.lower_items.should be_empty
      end
      # add another category as noise
      let(:another_category) { create :category, title: 'Another Category', subcategories: ['Another Subcategory 1', 'Another Subcategory 2'] }
      describe '#insert_at' do
        it 'create record in given position' do
          second_subcategory = category.children.second
          subcategory = Category.new(title: 'Subcategory 3', url: Faker::Lorem.word, parent: category)
          subcategory.save
          subcategory.insert_at(2)
          subcategory.new_record?.should be_false
          subcategory.position.should == 2
          expect { second_subcategory.reload }.to change { second_subcategory.position }.to(3)
          expect { another_category.reload }.not_to change {
            another_category.children.first
          }
        end
      end
    end
  end
end