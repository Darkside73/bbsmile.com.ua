require "rails_helper"

describe OrderMailer do
  let(:order) { create :order }
  describe ".new_order" do
    let(:mail) { OrderMailer.new_order(order) }
    it "renders the receiver email" do
      expect(mail.to).to eq([order.user.email])
    end

    context "body" do
      subject { mail.body.encoded }
      it { should include(order.number) }
    end
  end
end
