class PromotionsCell < Cell::Rails

  def category(args)
    category = args[:category]
    banners = {}
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
