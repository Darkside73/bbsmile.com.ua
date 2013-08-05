require 'spec_helper'

describe PricesSync do
  before :each do
    @session = double 'GoogleDrive::Session'
    @spreadsheet = double 'GoogleDrive::Spreadsheet'
    @worksheets = [{ws1: {a: 1}, ws2: {a: 2}}]
    GoogleDrive.should_receive(:login) { @session }
    @session.should_receive(:spreadsheet_by_key) { @spreadsheet }
  end

  describe "#new" do
    it "login to gdrive and open spreadsheet" do
      sync = PricesSync.new
    end
  end

  describe "#diff" do
    let(:row_changing) { { 'id' => 1, 'price' => 10, 'price_old' => 15, 'available' => 1, 'sku' => '123' } }
    let(:row_not_changing) { { 'id' => 2, 'price' => 100, 'available' => 0, 'sku' => '124' } }
    let(:category) { create :category }
    let!(:variant1) { create :variant, id: 1, price: 20, price_old: 25 }
    let!(:variant2) { create :variant, id: 2, price: 100, available: false, sku: '124' }
    it "search category variants changed in worksheet" do
      worksheet = @worksheets.first
      @spreadsheet.should_receive(:worksheet_by_title).with(category.title).and_return worksheet
      worksheet.should_receive(:list).and_return [row_changing, row_not_changing]
      subject.diff(category).variants_to_update.should == [variant1]
      variant2.should_not be_changed
    end
  end

  describe "#load" do
    let(:category) { create :category }
    let(:variants) { create_list :variant, 3 }
    it "load category variants to worksheet" do
      worksheet = @worksheets.first
      @spreadsheet.should_receive(:worksheet_by_title).with(category.title).and_return worksheet
      worksheet.stub(num_rows: 0)
      worksheet.stub(num_cols: 0)
      worksheet.stub(:save)
      subject.load category
    end
  end
end
