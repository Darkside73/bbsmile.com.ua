module MainHelper
  def landing_item_for(items, options, &block)
    options[:items] = items
    default_block = proc { |items| render items }
    render({ layout: 'landing_item', locals: options }, &block || default_block)
  end

  def luvion_promo_items(promo_id)
    slugs = {
      night_light: [
        'videonyanya-luvion-supreme-robot', 'videonyanya-luvion-grand-elite',
        'videonyanya-luvion-prestige-touch', 'mnogotsvetnyiy-nochnichok-luvion-ecoled'
      ],
      thermometer: [
        'tsifrovoy-termometr-luvion-bath-and-room',
        'radionyanya-tomy-classic-ta-100', 'radionyanya-tomy-digital-td-300',
        'radionyanya-tomy-digital-plus-td-350', 'radionyanya-tomy-digital-tf-525',
        'radionyanya-tomy-digital-tf-550', 'radionyanya-tomy-digital-tf-550'
      ]
    }

    slugs[promo_id].map { |slug| slug = Page.find_by(url: slug) }.reject(&:nil?)
  end

  def promo_gift? product
    product.brand_id.in?([172, 201]) && product.category_id == 14
  end

  def promo_discount? product
    product.brand_id.in?([172]) && product.category_id == 15
  end
end
