class Variant::Image < Asset
  has_attached_file :attachment,
                    styles: { grid: '300x200' },
                    processors: [:compression],
                    convert_options: { grid: '-background white -gravity Center -extent 300x200' },
                    url: DEFAULT_URL, path: DEFAULT_PATH
  validates_attachment_content_type :attachment, content_type: /^image\/(png|jpg|jpeg)/,
                                    message: I18n.t('errors.messages.paperclip.content_type_image')
end
