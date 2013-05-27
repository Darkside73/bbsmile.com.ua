class Product::Image < Asset
  has_attached_file :attachment, styles: { thumb: '98x112#', medium: '444' }
  validates_attachment_content_type :attachment, content_type: /^image\/(png|gif|jpg|jpeg)/,
                                    message: I18n.t('errors.messages.paperclip.content_type_image')
end
