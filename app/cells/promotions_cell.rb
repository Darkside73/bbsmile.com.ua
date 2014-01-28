class PromotionsCell < Cell::Rails

  def category(args)
    category = args[:category]
    banners = {
      '1.jpg' => page_path(
        'promotions',
        anchor: 'promo4', utm_campaign: 'veres-sonya-matras',
        utm_medium: 'category_page_side',
        utm_source: 'local'
      )
    }
    banners = banners.to_a.shuffle
    @banners = if category.id == 12
      Hash[banners.slice(0..1)]
    elsif category.root_id == 12
      Hash[[banners.slice(0)]]
    else
      []
    end
    render
  end
end
