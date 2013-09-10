AttributeNormalizer.configure do |config|

  config.normalizers[:currency] = lambda do |value, options|
    value.is_a?(String) ? value.gsub(/[^0-9\.]+/, '') : value
  end

  config.normalizers[:booleanize] = lambda do |value, options|
    return !!value if !!value == value || value.nil?
    value == 'false' ? false : true
  end

  # TODO rename to "trim" with :char option
  config.normalizers[:strip_slashes] = lambda do |value, options|
    value.is_a?(String) ? value.sub(/^[\/]?(.*?)[\/]?$/, '\1') : value
  end

  config.normalizers[:truncate] = lambda do |text, options|
    if text.is_a?(String)
      options.reverse_merge!(:length => 30, :omission => "...")
      l = options[:length] - options[:omission].mb_chars.length
      chars = text.mb_chars
      (chars.length > options[:length] ? chars[0...l] + options[:omission] : text).to_s
    else
      text
    end
  end

  # The default normalizers if no :with option or block is given is to apply the :strip and :blank normalizers (in that order).
  # You can change this if you would like as follows:
  # config.default_normalizers = :strip, :blank, :falsize

  # You can enable the attribute normalizers automatically if the specified attributes exist in your column_names. It will use
  # the default normalizers for each attribute (e.g. config.default_normalizers)
  config.default_attributes = :name, :title

  # Also, You can add an specific attribute to default_attributes using one or more normalizers:
  # config.add_default_attribute :name, :with => :truncate
end
