class Asset < ActiveRecord::Base
  belongs_to :assetable, polymorphic: true
  delegate :url, to: :attachment

  attr_reader :attachment_url

  DEFAULT_URL  = '/uploads/:class/:id_partition/:style/:filename'
  DEFAULT_PATH = ':rails_root/public:url'

  has_attached_file :attachment
  validates_attachment_presence :attachment
  validates_attachment_size :attachment, less_than: 1.megabyte,
                            message: I18n.t('errors.messages.paperclip.size')
  validates_attachment_content_type :attachment,
                                    content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  acts_as_list scope: [:assetable_id, :type]
  default_scope -> { order(:position) }

  def attachment_url= url
    self.attachment = URI.parse(url) if url.present?
  end
end
