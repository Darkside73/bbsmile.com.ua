module MainHelper
  def landing_item_for(items, options, &block)
    options[:items] = items
    default_block = proc { render items }
    render({ layout: 'landing_item', locals: options }, &block || default_block)
  end
end