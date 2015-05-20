namespace :migrate_data do
  desc "TODO"
  task related_pages: :environment do
    RelatedPage.all.each do |r|
      ActiveRecord::Base.transaction do
        begin
          product, related_product = Product.find(r.page_id), Product.find(r.related_id)
          r.page_id = product.page.id
          r.related_id = related_product.page.id
          r.save
        rescue ActiveRecord::RecordNotFound => error
        end
      end
    end
  end
end
