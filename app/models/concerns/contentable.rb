module Contentable
  extend ActiveSupport::Concern

  included do
    has_one :content, as: :contentable, dependent: :destroy
    before_save -> { content.text.gsub!(/<p(.*?)>\s*?[&nbsp;]+\s*?<\/p>/, '<p\1></p>') }, if: :content
  end

  def description
    content.try(:text)
  end
end
