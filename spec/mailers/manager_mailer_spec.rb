require "spec_helper"

describe ManagerMailer do
  let(:order) { create :order }
  describe ".new_order" do
    let(:mail) { ManagerMailer.new_order(order) }
    context "body" do
      subject { mail.body.encoded }
      it { should include(order.number) }
      it { should include(order.variant.title) }
      it { should include(order.price.to_s) }
    end
  end
end
