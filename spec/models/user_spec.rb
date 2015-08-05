require 'rails_helper'

describe User do
  context "when save" do
    it "write first and last name to name attribute" do
      user = User.new
      user.first_name = "John"
      user.last_name = "Doe"
      user.save
      expect(user.name).to eq("John Doe")
    end
  end
end
