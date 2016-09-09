class Product::Image < Asset
  has_attached_file :attachment,
                    styles: { thumb: '98x112', medium: '444>', grid: '300x200' },
                    convert_options: {
                      grid: '-background white -gravity Center -extent 300x200',
                      thumb: '-background white -gravity Center -extent 98x112'
                    },
                    processors: [:compression],
                    url: DEFAULT_URL, path: DEFAULT_PATH
  validates_attachment_content_type :attachment, content_type: /^image\/(png|gif|jpg|jpeg)/,
                                    message: I18n.t('errors.messages.paperclip.content_type_image')
end
