class Content < ActiveRecord::Base
  belongs_to :contentable, polymorphic: true

  validates :text, presence: true
end
