require 'spec_helper.rb'

require 'converter/products_importer/content_parser'
describe Converter::ProductsImporter::ContentParser do
  subject { Converter::ProductsImporter::ContentParser.new content_file }
  context 'when content file exists' do
    let(:content_file) { "#{Rails.root}/spec/fixtures/files/converter/content/5533.html" }
    it 'create content model' do
      subject.content.should be_a(Content)
      subject.content.should be_new_record
    end
    its(:content) { should be_an_instance_of(Content) }
  end

  context 'when content file does not exist' do
    let(:content_file) { "#{Rails.root}/spec/fixtures/files/converter/content/not_exists.html" }
    it 'not create content model' do
      expect { subject.content }.to_not change { Content.count }
    end
    its(:content) { should be_nil }
  end
end