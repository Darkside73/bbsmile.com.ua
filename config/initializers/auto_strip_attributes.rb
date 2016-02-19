AutoStripAttributes::Config.setup do
  set_filter strip_slashes: false do |value|
    value.is_a?(String) ? value.sub(/^[\/]?(.*?)[\/]?$/, '\1') : value
  end
end
