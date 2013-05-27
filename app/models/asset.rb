class Asset < ActiveRecord::Base
  belongs_to :assetable, polymorphic: true

  delegate :url, to: :attachment

  has_attached_file :attachment, styles: { thumb: '98x112#', medium: '444' }
  validates_attachment_presence :attachment
  validates_attachment_content_type :attachment, content_type: /^image\/(png|gif|jpg|jpeg)/,
                                    message: I18n.t('errors.messages.paperclip.content_type_image')
  validates_attachment_size :attachment, less_than: 1.megabyte,
                            message: I18n.t('errors.messages.paperclip.size')
  acts_as_list scope: [:assetable_id, :type]
  default_scope -> { order(:position) }
end
