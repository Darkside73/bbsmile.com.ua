class RelatedPage < ApplicationRecord
  belongs_to :page
  belongs_to :related, class_name: 'Page'

  enum type_of: [:similar, :suggested]

  validates_presence_of :type_of, :page, :related
  validates_associated  :page, :related
end
