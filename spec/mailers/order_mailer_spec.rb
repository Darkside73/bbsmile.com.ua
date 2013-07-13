require "spec_helper"

describe OrderMailer do
  let(:order) { create :order }
  describe ".new_order" do
    let(:mail) { OrderMailer.new_order(order) }
    it "renders the receiver email" do
      mail.to.should == [order.user.email]
    end

    context "body" do
      subject { mail.body.encoded }
      it { should include(order.number) }
      it { should include(order.variant.title) }
    end
  end
end
