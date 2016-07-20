require 'rails_helper'

describe SiteSettings do
  it 'save attribute' do
    settings = SiteSettings.new(offline_mode: true)
    settings.save
    settings = SiteSettings.new
    expect(settings.offline_mode).to be_truthy
  end

  describe '.get' do
    it 'return particular settings value' do
      expect(SiteSettings.get :offline_mode).to be
    end

    it 'return nil if attribute not exist' do
      expect(SiteSettings.get :foobar).to be_nil
    end
  end

  describe '.all' do
    it 'return all settings' do
      expect(SiteSettings.all).to include(:offline_mode)
    end
  end
end
