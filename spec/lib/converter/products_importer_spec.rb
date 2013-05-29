require 'spec_helper.rb'

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
    product.should be
    product.category.title.should == 'cat 1'
    product.brand.name.should == 'Brand 1'
    product.old_id.should == 5533
    product.video.should == 'video from youtube'
  end

  before { Product::Image.any_instance.stub(:save_attached_files) }
  it 'create product images' do
    subject.data_base_path = data_base_path
    subject.import
    product = Page.find_by(url: 'url/old/sample').pageable
    product.images.should have(1).item
  end

  it "create content" do
    Converter::ProductsImporter::ContentParser.
      any_instance.stub(:content).and_return(double(:content).as_null_object)
    subject.data_base_path = data_base_path
    subject.import
  end
end