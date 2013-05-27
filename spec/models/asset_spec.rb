require 'spec_helper'

describe Asset do
  it { should have_attached_file(:attachment) }
  it { should validate_attachment_presence(:attachment) }
  it { should validate_attachment_size(:attachment).less_than(1.megabytes) }
  it { should respond_to(:url) }
end
