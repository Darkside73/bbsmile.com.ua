require 'spec_helper'

describe Product::Image do
  it { should have_attached_file(:attachment) }
end
