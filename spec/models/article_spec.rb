require 'rails_helper'

describe Article do
  context 'when save' do
    it 'clear &nbsp; from content paragraph' do
      article = create :article, content_attributes: { text: '<p style="margin: 0">&nbsp;</p>' }
      expect(article.description).to eq('<p style="margin: 0"></p>')
    end
  end
end
