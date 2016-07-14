class PromotionsCell < Cell::ViewModel

  def show
    banners = {
      'mebel.jpg' => page_path(
        'duetyi-krovat-komod',
        anchor: 'promo4', utm_campaign: 'duetyi-krovat-komod',
        utm_medium: 'category_page_side',
        utm_source: 'local'
      )
    }
    banners = banners.to_a.shuffle
    @banners = if model.id == 12
      Hash[banners.slice(0..1)]
    elsif model.root_id == 12
      Hash[[banners.slice(0)]]
    else
      []
    end
    render
  end
end
