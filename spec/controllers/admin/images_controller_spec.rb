require 'spec_helper'

describe Admin::ImagesController do
  describe 'DELETE' do
    it 'destroy Image' do
      image = create :image
      expect {
        xhr :delete, :destroy, id: image.id
        image.reload
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
