require 'rails_helper'

require 'converter/products_importer/content_parser'
describe Converter::ProductsImporter::ContentParser do
  subject { Converter::ProductsImporter::ContentParser.new content_file }
  context 'when content file exists' do
    let(:content_file) { "#{Rails.root}/spec/fixtures/files/converter/content/5533.html" }
    it 'create content model' do
      expect(subject.content).to be_a(Content)
      expect(subject.content).to be_new_record
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

  describe "clean_html" do
    let(:dirty_html) { '<img />&NBSp; <b class="warning">bold</b><p>paragraph</p><p> <b></b></p>' }
    subject { Converter::ProductsImporter::ContentParser.new('').clean_html(dirty_html) }
    it { should_not include('<img') }
    it { should_not include('class="warning"') }
    it { should_not include('&NBSp;') }
    it { should_not include('<p> <b></b></p>') }
    it { should_not include('<b></b>') }
    it { should_not include('<p> </p>') }
    it { should include('<b>bold</b>') }
    it { should include('<p>paragraph</p>') }
  end
end
