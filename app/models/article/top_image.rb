class Article::TopImage < Asset
  has_attached_file :attachment,
                    styles: { thumb: '98x112' },
                    url: DEFAULT_URL, path: DEFAULT_PATH
  validates_attachment_content_type :attachment, content_type: /^image\/(png|gif|jpg|jpeg)/,
                                    message: I18n.t('errors.messages.paperclip.content_type_image')

end
