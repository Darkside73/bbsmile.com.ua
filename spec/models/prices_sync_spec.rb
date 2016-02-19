require 'rails_helper'
require 'service/google_api_client'

describe PricesSync do
  before :each do
    @session = double 'GoogleDrive::Session'
    @spreadsheet = GoogleDrive::Spreadsheet
    @worksheets = [{ws1: {a: 1}, ws2: {a: 2}}]
    expect(Service::GoogleApiClient).to receive(:access_token).at_most(:once)
    expect(GoogleDrive).to receive(:login_with_oauth).at_most(:once) { @session }
    expect(@session).to receive(:spreadsheet_by_key).at_most(:once) { @spreadsheet }
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
      expect(PricesSync.connect.diff(category).items_to_update).to eq([variant1])
      expect(variant2).to_not be_changed
    end
  end

  describe "#load" do
    let(:category) { create :category }
    let(:variants) { create_list :variant, 3 }
    it "load category variants to worksheet" do
      worksheet = @worksheets.first
      expect(@spreadsheet).to receive(:worksheet_by_title).with(category.title).and_return worksheet
      allow(worksheet).to receive(:num_rows).and_return(0)
      allow(worksheet).to receive(:num_cols).and_return(0)
      allow(worksheet).to receive(:save)
      PricesSync.connect.load category
    end
  end
end
