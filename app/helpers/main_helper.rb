module MainHelper
  def landing_item_for(items, options, &block)
    options[:items] = items
    default_block = proc { |items| render items }
    render({ layout: 'landing_item', locals: options }, &block || default_block)
  end

  def luvion_promo_items
    slugs = [
      'videonyanya-luvion-supreme-robot', 'videonyanya-luvion-grand-elite',
      'videonyanya-luvion-prestige-touch', 'mnogotsvetnyiy-nochnichok-luvion-ecoled'
    ]

    slugs.map! { |slug| slug = Page.find_by(url: slug) }
  end
end
