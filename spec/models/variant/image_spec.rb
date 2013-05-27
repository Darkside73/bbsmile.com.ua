require 'spec_helper'

describe Variant::Image do
  it { should have_attached_file(:attachment) }
end
