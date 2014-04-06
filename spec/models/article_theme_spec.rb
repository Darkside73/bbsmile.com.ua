require 'spec_helper'

describe ArticleTheme do
  describe ".visible" do
    before do
      create_list :article_theme, 2
      create_list :hidden_article_theme, 1
    end
    it "returns only visible themes" do
      ArticleTheme.visible.should have(2).items
    end
  end
end
