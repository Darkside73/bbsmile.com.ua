require 'spec_helper'

describe Image do
  it { should have_attached_file(:asset) }
  it { should validate_attachment_presence(:asset) }
  # it { should validate_attachment_content_type(:asset).
  #             allowing('image/png', 'image/gif', 'image/jpeg') }
  it { should validate_attachment_size(:asset).
                less_than(1.megabytes) }
end
