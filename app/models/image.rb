class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  has_attached_file :asset, styles: { thumb: '98x112#', medium: '444' }
  validates_attachment_presence :asset
  validates_attachment_content_type :asset, content_type: /^image\/(png|gif|jpg|jpeg)/,
                                    message: I18n.t('errors.messages.paperclip.content_type_image')
  validates_attachment_size :asset, less_than: 1.megabyte,
                            message: I18n.t('errors.messages.paperclip.size')
  acts_as_list scope: [:imageable_id]
  default_scope -> { order(:position) }
end
