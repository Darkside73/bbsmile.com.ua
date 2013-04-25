class Image < ActiveRecord::Base
  has_attached_file :asset
  validates_attachment :asset, presence: true,
                       # content_type: { content_type: ['image/jpg', 'image/png', 'image/gif'] },
                       size: { in: 0..1.megabytes }

end
