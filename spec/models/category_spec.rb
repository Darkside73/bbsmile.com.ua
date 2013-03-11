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
end