class Content < ApplicationRecord
  belongs_to :contentable, polymorphic: true

  validates :text, presence: true
end
