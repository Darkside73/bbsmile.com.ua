require 'rails_helper'

require 'converter/products_importer'
describe Converter::ProductsImporter do

  before do
    create :leaf_category, page_title: 'cat 1'
    create :leaf_category, page_title: 'cat 2'
    create :product, page_url_old: 'exist/product/url'
  end

  let(:data_base_path) { "#{Rails.root}/spec/fixtures/files/converter" }
  let(:csv_file) { File.read "#{data_base_path}/prices.csv" }
  subject { Converter::ProductsImporter.new csv_file }

  before :each do
    subject.categories_map = { 'cat 1 old' => 'cat 1', 'cat 2 old' => 'cat 2' }
  end

  it 'create products' do
    expect { subject.import }.to change { Product.count }
    product = Page.find_by(url: 'url/old/sample').try(:pageable)
    expect(product).to be
    expect(product.category.title).to eq('cat 1')
    expect(product.brand.name).to eq('Brand 1')
    expect(product.old_id).to eq(5533)
    expect(product.video).to eq('video from youtube')
  end
end
