require 'rails_helper'

describe PricesSync do
  before :example do
    @session = double 'GoogleDriveV0::Session'
    @spreadsheet = double 'GoogleDriveV0::Spreadsheet'
    @worksheets = [{ws1: {a: 1}, ws2: {a: 2}}]
    expect(GoogleDriveV0).to receive(:login) { @session }
    expect(@session).to receive(:spreadsheet_by_key) { @spreadsheet }
  end

  describe "#diff" do
    let(:row_changing) { { 'id' => 1, 'price' => 10, 'price_old' => 15, 'available' => 1, 'sku' => '123' } }
    let(:row_not_changing) { { 'id' => 2, 'price' => 100, 'available' => 0, 'sku' => '124' } }
    let(:category) { create :category }
    let!(:variant1) { create :variant, id: 1, price: 20, price_old: 25 }
    let!(:variant2) { create :variant, id: 2, price: 100, available: false, sku: '124' }
    it "search category variants changed in worksheet" do
      worksheet = @worksheets.first
      expect(@spreadsheet).to receive(:worksheet_by_title).with(category.title).and_return worksheet
      expect(worksheet).to receive(:list).and_return [row_changing, row_not_changing]
      expect(PricesSync.diff(category).items_to_update).to eq([variant1])
      expect(variant2).to_not be_changed
    end
  end

  describe "#load" do
    let(:category) { create :category }
    let(:variants) { create_list :variant, 3 }
    it "load category variants to worksheet" do
      pending %Q{Double "GoogleDriveV0::Spreadsheet" was originally created in one example but has leaked into another example and can no longer be used. rspec-mocks' doubles are designed to only last for one example, and you need to create a new one in each example you wish to use it for.}
      worksheet = @worksheets.first
      expect(@spreadsheet).to receive(:worksheet_by_title).with(category.title).and_return worksheet
      allow(worksheet).to receive(:num_rows).and_return(0)
      allow(worksheet).to receive(:num_cols).and_return(0)
      allow(worksheet).to receive(:save)
      PricesSync.load category
    end
  end
end
