module Pageable
  extend ActiveSupport::Concern

  included do
    has_one :page, as: :pageable, dependent: :destroy
    accepts_nested_attributes_for :page
    delegate :title, :name, :url, :url_old, :hidden, to: :page
    scope :by_url, ->(url) { Page.find_by(url: url).try(:pageable) }
    after_update do |pageable|
      pageable.page.touch
    end
  end
end
