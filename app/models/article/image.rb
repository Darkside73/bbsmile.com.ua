class Article::Image < Asset
  has_attached_file :attachment, processors: [:compression], url: DEFAULT_URL, path: DEFAULT_PATH
  validates_attachment_content_type :attachment, content_type: /^image\/(png|jpg|jpeg)/,
                                    message: I18n.t('errors.messages.paperclip.content_type_image')

  default_scope -> { reorder :created_at }

  def as_json(options = {})
    {
      image: {
        url: self.url
      }
    }
  end
end
