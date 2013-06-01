class Tag
  def self.where(q, limit = 5)
    ActsAsTaggableOn::Tag.where('name LIKE ?', "%#{q}%").limit(limit)
  end

  def self.all
    ActsAsTaggableOn::Tag.all
  end
end