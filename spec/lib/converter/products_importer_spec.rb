require 'spec_helper.rb'

require 'converter/products_importer'
describe Converter::ProductsImporter do
  before do
    create :category, page_title: 'cat 1'
    create :category, page_title: 'cat 2'
  end
  let(:csv_file) { File.read "#{Rails.root}/spec/fixtures/files/converter/prices.csv" }
  subject { Converter::ProductsImporter.new csv_file }
  it 'create products' do
    subject.categories_map = { 'cat 1 old' => 'cat 1', 'cat 2 old' => 'cat 2' }
    expect { subject.import }.to change { Product.count }
    product = Page.find_by(url: 'url/old/sample').try(:pageable)
    product.should be
    product.category.title.should == 'cat 1'
    product.brand.name.should == 'Brand 1'
  end
end