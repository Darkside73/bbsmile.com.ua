class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  has_attached_file :asset, styles: { thumb: '98x112#', medium: '444' }
  validates_attachment :asset, presence: true,
                       # content_type: { content_type: ['image/jpg', 'image/png', 'image/gif'] },
                       size: { in: 0..1.megabytes }
  acts_as_list scope: [:imageable_id]
  default_scope -> { order(:position) }
end
