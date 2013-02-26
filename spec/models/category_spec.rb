require 'spec_helper'

describe Category do
  subject { Category }
  before { category = create :category, title: 'Category', subcategory: 'Subcategory' }
  its(:arrange) { should respond_to :each }
  # describe ".arrange" do
  # end
end