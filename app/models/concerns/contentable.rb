module Contentable
  extend ActiveSupport::Concern

  included do
    has_one :content, as: :contentable, dependent: :destroy
  end

  def description
    content.try(:text)
  end
end
