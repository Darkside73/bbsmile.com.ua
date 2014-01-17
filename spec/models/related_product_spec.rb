require 'spec_helper'

describe RelatedProduct do
  let(:related_product) { create :related_product }
  it "has relations" do
    related_product.product.should be_a(Product)
    related_product.related.should be_a(Product)
  end

  let(:product) { create :product }
  let(:similar_product) { create :product}
  it 'create relation between products' do
    related = product.related_products.build(
      related: similar_product,
      type_of: :similar
    )
    expect { related.save }.to change { product.similar_products.count }.by(1)
  end

  context 'validation' do
    it { should validate_presence_of :product }
    it { should validate_presence_of :related }
  end
end
