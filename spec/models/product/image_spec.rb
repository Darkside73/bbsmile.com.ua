require 'rails_helper'

describe Product::Image do
  it { should have_attached_file(:attachment) }
end
