require "spec_helper"

describe ManagerMailer do
  describe ".new_order" do
    let(:order) { create :order }
    let(:mail) { ManagerMailer.new_order(order) }
    context "body" do
      subject { mail.body.encoded }
      it { should include(order.number) }
      it { should include(order.variant.title) }
    end
  end
  describe ".price_loaded" do
    let(:category) { create :category }
    let(:mail) { ManagerMailer.price_loaded(category) }
    context "body" do
      subject { mail.body.encoded }
      it { should include(category.title) }
    end
  end
end
