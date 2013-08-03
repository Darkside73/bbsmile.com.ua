require 'spec_helper'

describe PricesSync do
  before :each do
    @session = double 'GoogleDrive::Session'
    @spreadsheet = double 'GoogleDrive::Spreadsheet'
    @worksheets = [[hash_including(a: 1)]]
    GoogleDrive.should_receive(:login) { @session }
    @session.should_receive(:spreadsheet_by_key) { @spreadsheet }
    @spreadsheet.should_receive(:worksheets) { @worksheets }
  end

  describe "#new" do
    it "fetch first worksheet from specified spreadsheet" do
      sync = PricesSync.new
      sync.worksheet.should be @worksheets.first
    end
  end

  describe "#diff" do
    let(:row_changing) { { 'id' => 1, 'price' => 10, 'price_old' => 15, 'available' => 1, 'sku' => '123' } }
    let(:row_not_changing) { { 'id' => 2, 'price' => 100, 'available' => 0, 'sku' => '124' } }
    let!(:variant1) { create :variant, id: 1, price: 20, price_old: 25 }
    let!(:variant2) { create :variant, id: 2, price: 100, available: false, sku: '124' }
    it "return variants differ with price" do
      worksheet = @worksheets.first
      worksheet.should_receive(:list).and_return [row_changing, row_not_changing]
      subject.diff.variants_to_update.should == [variant1]
      variant2.should_not be_changed
    end
  end

  describe "#load" do
    let(:variants) { create_list :variant, 3 }
    it "load actual variants to worksheet" do
      worksheet = @worksheets.first
      worksheet.stub_chain(:list, :keys)
      expect(worksheet).to receive(:delete)
      empty_worksheet = double 'GoogleDrive::Worksheet'
      empty_worksheet.stub(:save)
      empty_worksheet.stub_chain(:list, :keys=)
      expect(@spreadsheet).to receive(:add_worksheet).and_return(empty_worksheet)
      subject.load
    end
  end
end
